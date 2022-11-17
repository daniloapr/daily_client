import Flutter
import UIKit
import Daily

public class SwiftDailyClientPlugin: NSObject, FlutterPlugin, DailyClientMessenger {
    private let call = CallClient()
    
    func join(args: JoinArgs, completion: @escaping (VoidResult) -> Void) {
        let url = URL(string: args.url)
        
        if(!(url?.isFileURL ?? false)) {
            completion(
                VoidResult(
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
                url: url!,
                token: args.token.isEmpty ? nil : MeetingToken(stringValue: args.token),
                settings: .init(
                    inputs: .set(.init(
                        camera: .set(.enabled(args.enableCamera)),
                        microphone: .set(.enabled(args.enableMicrophone))
                    ))
                )
            )
        } catch {
            completion(
                VoidResult(
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
    
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        DailyClientMessengerSetup.setUp(
            binaryMessenger: registrar.messenger(),
            api: SwiftDailyClientPlugin()
        )
    }
}
