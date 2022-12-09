import Flutter
import UIKit
import Daily
import Combine

public class SwiftDailyClientPlugin: NSObject, FlutterPlugin, DailyMessenger {
    /// Client from Daily SDK
    private let call: Daily.CallClient
    /// Sends data back to the Flutter layer
    let callback: DailyCallback
    /// Stores the individual event observers
    var cancellables: Set<AnyCancellable> = []
    
    init(
        call: Daily.CallClient,
        callback: DailyCallback
    ) {
        self.call = call
        self.callback = callback
    }
    
    /// Register flutter plugin
    public static func register(with registrar: FlutterPluginRegistrar) {
        let call = Daily.CallClient()
        let callback = DailyCallback(binaryMessenger: registrar.messenger())
        let plugin = SwiftDailyClientPlugin(call: call, callback: callback)
        
        DailyMessengerSetup.setUp(
            binaryMessenger: registrar.messenger(),
            api: plugin
        )
        
        let factory = DailyVideoRendererFactory(messenger: registrar.messenger(), call: call)
        registrar.register(factory, withId: "DailyVideoRenderer")
    }
    
    private func startListeners() {
        call.events.participantUpdated
            .receive(on: DispatchQueue.main)
            .sink() { event in
                //We are not handling each single participant update for simplifying reason.
                self.onParticipantsUpdated()
                self.onParticipantUpdated(participant: event.participant)
            }
            .store(in: &cancellables)
        
        call.events.participantJoined
            .receive(on: DispatchQueue.main)
            .sink() { event in
                self.onParticipantJoined(participant: event.participant)
            }
            .store(in: &cancellables)
        
        call.events.participantLeft
            .receive(on: DispatchQueue.main)
            .sink() { event in
                self.onParticipantLeft(participant: event.participant)
            }
            .store(in: &cancellables)
        
        call.events.publishingUpdated
            .receive(on: DispatchQueue.main)
            .sink() { _ in
                print("DailyClient: publishingUpdated")
            }
            .store(in: &cancellables)
        
        call.events.subscriptionProfilesUpdated
            .receive(on: DispatchQueue.main)
            .sink() { _ in
                print("DailyClient: subscriptionProfilesUpdated")
            }
            .store(in: &cancellables)
        
        call.events.subscriptionsUpdated
            .receive(on: DispatchQueue.main)
            .sink() { _ in
                print("DailyClient: subscriptionsUpdated")
            }
            .store(in: &cancellables)
        
        call.events.callStateUpdated
            .receive(on: DispatchQueue.main)
            .sink() {event in
                let code = mapCallStateToCode(callState: event.state)
                self.callback.onCallStateUpdated(
                    stateCode: code,
                    completion: {}
                )
            } .store(in: &cancellables)
    }
    
    func join(args: JoinArgs, completion: @escaping (JoinMessage) -> Void) {
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
            startListeners()
            
            try call.join(
                url: url,
                token: args.token.isEmpty ? nil : MeetingToken(stringValue: args.token),
                settings: .init(
                    inputs: .set(.init(
                        camera: .set(.enabled(args.enableCamera)),
                        microphone: .set(.enabled(args.enableMicrophone))
                    ))
                )
            )
            
            
            let message = getParticipantsMessage(fromParticipants: call.participants)
            
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
    
    func leave() -> VoidResult {
        call.leave()
        cancellables.forEach({$0.cancel()})
        cancellables = []
        return VoidResult()
    }
    
    func setMicrophoneEnabled(enableMic: Bool) -> VoidResult {
        do {
            _ = try call.updateInputs {inputs in
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
    
    func setCameraEnabled(enableCam: Bool) -> VoidResult {
        do {
            _ = try call.updateInputs {inputs in
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
    
    func updateSubscriptionProfiles(args: [UpdateSubscriptionProfileArgs]) -> VoidResult {
        do {
            try args.forEach{ arg in
                let _ = try call.updateSubscriptionProfiles{ profiles in
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
    func updateSubscriptions(args: [UpdateSubscriptionArgs]) -> VoidResult {
        do {
            let participants: SubscriptionSettingsUpdatesById = args.reduce(into: [:]) { dictionary, arg in
                let participantId = ParticipantId(uuid: UUID(uuidString: arg.participantId)!)
                let subscription: Update<SubscriptionSettingsUpdate> = .set(.init(
                    profile: .set(.init(stringLiteral: arg.profileName))
                ))
                
                dictionary[participantId] = subscription
            }
            
            let _ = try call.updateSubscriptions(forParticipants: participants)
            
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
    
    func getParticipants() -> ParticipantsMessage {
        let participants = getParticipantsMessage(fromParticipants: call.participants)
        
        return ParticipantsMessage(
            local: participants.local,
            remote: participants.remote
        )
    }
    
    private func onParticipantsUpdated() {
        print("DailyClient: participantsUpdated")
        let message = getParticipantsMessage(fromParticipants: self.call.participants)
        
        self.callback.onParticipantsUpdated(
            localParticipantMessage:message.local,
            remoteParticipantsMessage: message.remote,
            completion: {}
        )
    }
    
    private func onParticipantUpdated(participant: Daily.Participant) {
        print("DailyClient: onParticipantUpdated")
        let participantMessage = mapRemoteParticipantToMessage(fromParticipant: participant)
        printParticipant(participantMessage: participantMessage)
        
        self.callback.onParticipantUpdated(
            remoteParticipantMessage: participantMessage,
            completion: {}
        )
    }
    
    private func onParticipantJoined(participant: Daily.Participant) {
        print("DailyClient: participantJoined")
        let participantMessage = mapRemoteParticipantToMessage(fromParticipant: participant)
        printParticipant(participantMessage: participantMessage)
        
        self.callback.onParticipantJoined(
            remoteParticipantMessage: participantMessage,
            completion: {}
        )
    }
    
    private func onParticipantLeft(participant: Daily.Participant) {
        print("DailyClient: onParticipantLeft")
        let participantMessage = mapRemoteParticipantToMessage(fromParticipant: participant)
        
        self.callback.onParticipantLeft(
            remoteParticipantMessage: participantMessage,
            completion: {}
        )
    }
}
