import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'daily_client_platform_interface.dart';

/// An implementation of [DailyClientPlatform] that uses method channels.
class MethodChannelDailyClient extends DailyClientPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('daily_client');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
