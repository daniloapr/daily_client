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
            .sink() { _ in
                //We are not handling each single participant update for simplifying reason.
                let message = self.getParticipantsMessage(fromParticipants: self.call.participants)
                self.callback.onParticipantsUpdated(
                    localParticipantMessage:message.local,
                    remoteParticipantsMessage: message.remote,
                    completion: {}
                )
            }
            .store(in: &cancellables)
        
        call.events.callStateUpdated
            .receive(on: DispatchQueue.main)
            .sink() {event in
                let code = self.mapCallStateToCode(callState: event.state)
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
                        code: ErrorCode.invalidUrl
                    )
                )
            )
            return
        }
        
        do {
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
            
            startListeners()
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
                        code: ErrorCode.join
                    )
                )
            )
        }
    }
    
    func leave() -> VoidResult {
        call.leave()
        cancellables.forEach({$0.cancel()})
        cancellables = []
        return VoidResult(error: nil)
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
                    code: ErrorCode.updateMicrophone
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
                    code: ErrorCode.updateCamera
                )
            )
        }
    }
    
    private func getParticipantsMessage(
        fromParticipants participants: Daily.Participants
    ) -> (local: LocalParticipantMessage, remote: [RemoteParticipantMessage]) {
        let local = participants.local
        let media = local.media
        
        let localParticipantMessage = LocalParticipantMessage(
            id: local.id.uuid.uuidString,
            isCameraEnabled: media?.camera.state == .playable,
            isMicrophoneEnabled: media?.microphone.state == .playable,
            userId: local.info.userId?.uuid.uuidString ?? ""
        )
        
        let remoteParticipantsMessage = participants.remote.map{
            let participant: Daily.Participant = $0.value
            
            return RemoteParticipantMessage(
                id: participant.id.uuid.uuidString,
                isCameraEnabled: participant.media?.camera.state == .playable,
                isMicrophoneEnabled: participant.media?.microphone.state == .playable,
                userId: participant.info.userId?.uuid.uuidString ?? "",
                media: getMediaMessage(fromMedia: participant.media)
            )
            
        }
        
        return (localParticipantMessage, remoteParticipantsMessage)
    }
    
    private func mapCallStateToCode(callState: Daily.CallState) -> Int32 {
        switch callState {
            
        case .new:
            return 0
        case .joining:
            return 1
        case .joined:
            return 2
        case .leaving:
            return 3
        case .left:
            return 4
        @unknown default:
            return -1
        }
    }
    
    private func getMediaMessage(fromMedia media: Daily.ParticipantMedia?) -> MediaMessage? {
        
        if let media {
            return MediaMessage(
                camera: getMediaInfoMessage(fromVideoInfo: media.camera),
                microphone: getMediaInfoMessage(fromAudioInfo: media.microphone),
                screenVideo: getMediaInfoMessage(fromVideoInfo: media.screenVideo),
                screenAudio: getMediaInfoMessage(fromAudioInfo: media.screenAudio)
            )
        }
        
        return nil
    }
    
    private func getMediaInfoMessage(fromVideoInfo info: Daily.ParticipantVideoInfo) -> MediaInfoMessage {
        return MediaInfoMessage(
            state: mapMediaStateToMessage(mediaState: info.state),
            subscribed: mapTrackSubscriptionStateToMessage(subscriptionState: info.subscribed),
            track: TrackMessage(id: info.track?.id ?? "", isEnabled: info.track?.isEnabled ?? false)
        )
    }
    
    
    private func getMediaInfoMessage(fromAudioInfo info: Daily.ParticipantAudioInfo) -> MediaInfoMessage {
        return MediaInfoMessage(
            state: mapMediaStateToMessage(mediaState: info.state),
            subscribed: mapTrackSubscriptionStateToMessage(subscriptionState: info.subscribed),
            track: TrackMessage(id: info.track?.id ?? "", isEnabled: info.track?.isEnabled ?? false)
        )
    }
    
    private func mapMediaStateToMessage(mediaState: Daily.MediaState) -> MediaStateMessage {
        switch mediaState {
            
        case .blocked:
            return .blocked
        case .off:
            return .off
        case .receivable:
            return .receivable
        case .loading:
            return .loading
        case .playable:
            return .playable
        case .interrupted:
            return .interrupted
        @unknown default:
            return .unknown
        }
    }
    
    private func mapTrackSubscriptionStateToMessage(subscriptionState: Daily.TrackSubscriptionState) -> TrackSubscriptionStateMessage{
        switch subscriptionState {
            
        case .subscribed:
            return .subscribed
        case .staged:
            return .staged
        case .unsubscribed:
            return .unsubscribed
        @unknown default:
            return .unknown
        }
    }
}
