import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'daily_client_method_channel.dart';

abstract class DailyClientPlatform extends PlatformInterface {
  /// Constructs a DailyClientPlatform.
  DailyClientPlatform() : super(token: _token);

  static final Object _token = Object();

  static DailyClientPlatform _instance = MethodChannelDailyClient();

  /// The default instance of [DailyClientPlatform] to use.
  ///
  /// Defaults to [MethodChannelDailyClient].
  static DailyClientPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DailyClientPlatform] when
  /// they register themselves.
  static set instance(DailyClientPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
