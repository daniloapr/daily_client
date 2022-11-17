import Flutter
import UIKit
import Daily

public class SwiftDailyClientPlugin: NSObject, FlutterPlugin, DailyMessenger {
    private let call = CallClient()
    
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
            
            let local = call.participants.local
            let remote = call.participants.remote
            
            let localParticipantMessage = LocalParticipantMessage(
                id: local.id.uuid.uuidString,
                isCameraEnabled: local.media?.camera.state == .playable,
                isMicrophoneEnabled: local.media?.microphone.state == .playable,
                userId: local.info.userId?.uuid.uuidString ?? ""
            )
            
            completion(JoinMessage(
                localParticipant: localParticipantMessage,
                remoteParticipants: <#T##[RemoteParticipantMessage?]?#>
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
    
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        DailyMessengerSetup.setUp(
            binaryMessenger: registrar.messenger(),
            api: SwiftDailyClientPlugin()
        )
    }
}
