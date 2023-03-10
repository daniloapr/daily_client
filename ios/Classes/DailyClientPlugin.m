#import "DailyClientPlugin.h"
#if __has_include(<daily_client/daily_client-Swift.h>)
#import <daily_client/daily_client-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "daily_client-Swift.h"
#endif

@implementation DailyClientPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDailyClientPlugin registerWithRegistrar:registrar];
}
@end
