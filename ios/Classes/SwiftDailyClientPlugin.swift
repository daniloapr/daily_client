import Flutter
import UIKit
import Daily
import Combine

public class SwiftDailyClientPlugin: NSObject, FlutterPlugin, DailyMessenger {
    /// Client from Daily SDK
    @MainActor private lazy var callClient: CallClient = {
        let callClient = CallClient()
        callClient.delegate = self
        return callClient
    }()

    /// Sends data back to the Flutter layer
    let callback: DailyCallback
    /// Stores the individual event observers
    var cancellables: Set<AnyCancellable> = []
    
    init(callback: DailyCallback) {
        self.callback = callback
    }
    
    /// Register flutter plugin
    @MainActor public static func register(with registrar: FlutterPluginRegistrar) {
        let callback = DailyCallback(binaryMessenger: registrar.messenger())
        let plugin = SwiftDailyClientPlugin(callback: callback)
        
        DailyMessengerSetup.setUp(
            binaryMessenger: registrar.messenger(),
            api: plugin
        )
        
        let factory = DailyVideoRendererFactory(messenger: registrar.messenger(), call: plugin.callClient)
        registrar.register(factory, withId: "DailyVideoRenderer")
    }
    
    @MainActor func join(args: JoinArgs, completion: @escaping (JoinMessage) -> Void)  {
        guard let url = URL(string: args.url) else {
            completion(
                JoinMessage(
                    error: PlatformError(
                        message: "Invalid url",
                        code: Code.invalidUrl
                    )
                )
            )
            return
        }
        
        do {
            try callClient.join(
                url: url,
                token: args.token.isEmpty ? nil : MeetingToken(stringValue: args.token),
                settings: .init(
                    inputs: .set(.init(
                        camera: .set(.enabled(args.enableCamera)),
                        microphone: .set(.enabled(args.enableMicrophone))
                    ))
                )
            )
            
            
            let message = getParticipantsMessage(fromParticipants: callClient.participants)
            
            completion(JoinMessage(
                localParticipant: message.local,
                remoteParticipants: message.remote
            ))
        } catch {
            completion(
                JoinMessage(
                    error: PlatformError(
                        message: "\(error)",
                        code: Code.join
                    )
                )
            )
        }
    }
    
    @MainActor func leave() -> VoidResult {
        callClient.leave()
        cancellables.forEach({$0.cancel()})
        cancellables = []
        return VoidResult()
    }
    
    @MainActor func setMicrophoneEnabled(enableMic: Bool) -> VoidResult {
        do {
            _ = try callClient.updateInputs {inputs in
                inputs(\.microphone, .enabled(enableMic))
            }
            
            return VoidResult()
        } catch {
            return VoidResult(
                error: PlatformError(
                    message: "\(error)",
                    code: Code.updateMicrophone
                )
            )
        }
        
    }
    
    @MainActor func setCameraEnabled(enableCam: Bool) -> VoidResult {
        do {
            _ = try callClient.updateInputs {inputs in
                inputs(\.camera, .enabled(enableCam))
            }
            return VoidResult()
        } catch {
            return VoidResult(
                error: PlatformError(
                    message: "\(error)",
                    code: Code.updateCamera
                )
            )
        }
    }
    
    @MainActor func updateSubscriptionProfiles(args: [UpdateSubscriptionProfileArgs]) -> VoidResult {
        do {
            try args.forEach{ arg in
                let _ = try callClient.updateSubscriptionProfiles{ profiles in
                    profiles(SubscriptionProfile(stringLiteral: arg.name)) { profile in
                        profile(\.camera, .subscribed(arg.subscribeCamera))
                        profile(\.microphone, .subscribed(arg.subscribeMicrophone))
                    }
                }
            }
        } catch {
            return VoidResult(
                error: PlatformError(
                    message: "\(error)",
                    code: Code.updateSubscriptionProfiles
                )
            )
        }
        return VoidResult()
    }
    
    /// Participants subscription
    @MainActor func updateSubscriptions(args: [UpdateSubscriptionArgs]) -> VoidResult {
        do {
            let participants: SubscriptionSettingsUpdatesById = args.reduce(into: [:]) { dictionary, arg in
                let participantId = ParticipantId(uuid: UUID(uuidString: arg.participantId)!)
                let subscription: Update<SubscriptionSettingsUpdate> = .set(.init(
                    profile: .set(.init(stringLiteral: arg.profileName))
                ))
                
                dictionary[participantId] = subscription
            }
            
            let _ = try callClient.updateSubscriptions(forParticipants: participants)
            
        } catch {
            return VoidResult(
                error: PlatformError(
                    message: "\(error)",
                    code: Code.updateSubscriptions
                )
            )
        }
        
        return VoidResult()
    }
    
    @MainActor func getParticipants() -> ParticipantsMessage {
        let participants = getParticipantsMessage(fromParticipants: callClient.participants)
        
        return ParticipantsMessage(
            local: participants.local,
            remote: participants.remote
        )
    }
    
    @MainActor func onParticipantsUpdated() {
        print("DailyClient: participantsUpdated")
        let message = getParticipantsMessage(fromParticipants: self.callClient.participants)
        
        self.callback.onParticipantsUpdated(
            localParticipantMessage:message.local,
            remoteParticipantsMessage: message.remote,
            completion: {}
        )
    }
    
    func onParticipantUpdated(participant: Daily.Participant) {
        print("DailyClient: onParticipantUpdated")
        if (participant.info.isLocal) {
            let participantMessage = mapLocalParticipantToMessage(fromParticipant: participant)
            self.callback.onLocalParticipantUpdated(
                localParticipantMessage: participantMessage,
                completion: {}
            )
        } else {
            let participantMessage = mapRemoteParticipantToMessage(fromParticipant: participant)
            self.callback.onParticipantUpdated(
                remoteParticipantMessage: participantMessage,
                completion: {}
            )
        }
    }
    
    func onParticipantJoined(participant: Daily.Participant) {
        print("DailyClient: participantJoined")
        let participantMessage = mapRemoteParticipantToMessage(fromParticipant: participant)
        self.callback.onParticipantJoined(
            remoteParticipantMessage: participantMessage,
            completion: {}
        )
    }
    
    func onParticipantLeft(participant: Daily.Participant) {
        print("DailyClient: onParticipantLeft")
        let participantMessage = mapRemoteParticipantToMessage(fromParticipant: participant)
        
        self.callback.onParticipantLeft(
            remoteParticipantMessage: participantMessage,
            completion: {}
        )
    }
    
    func onActiveSpeakerChanged(participant: Daily.Participant?) {
        print("DailyClient: onActiveSpeakerChanged")
        let participantMessage = participant != nil ? mapRemoteParticipantToMessage(fromParticipant: participant!) : nil
        
        self.callback.activeSpeakerChanged(
            remoteParticipantMessage: participantMessage,
            completion: {}
        )
    }
}
