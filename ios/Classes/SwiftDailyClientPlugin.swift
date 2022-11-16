import Flutter
import UIKit

public class SwiftDailyClientPlugin: NSObject, FlutterPlugin, DailyClientMessenger {
    func join(args: JoinArgs, completion: @escaping (VoidResult) -> Void) {
        print("Joining: \(args.url)")
        completion(VoidResult(error: PlatformError(message: args.url, code: -1)))
    }
    
    func leave() -> VoidResult {
        print("Leaving")
        return VoidResult(error: nil)
    }
    
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        DailyClientMessengerSetup.setUp(
            binaryMessenger: registrar.messenger(),
            api: SwiftDailyClientPlugin()
        )
    }
}
