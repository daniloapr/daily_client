import 'package:flutter_test/flutter_test.dart';
import 'package:daily_client/daily_client.dart';
import 'package:daily_client/daily_client_platform_interface.dart';
import 'package:daily_client/daily_client_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDailyClientPlatform
    with MockPlatformInterfaceMixin
    implements DailyClientPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DailyClientPlatform initialPlatform = DailyClientPlatform.instance;

  test('$MethodChannelDailyClient is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDailyClient>());
  });

  test('getPlatformVersion', () async {
    DailyClient dailyClientPlugin = DailyClient();
    MockDailyClientPlatform fakePlatform = MockDailyClientPlatform();
    DailyClientPlatform.instance = fakePlatform;

    expect(await dailyClientPlugin.getPlatformVersion(), '42');
  });
}
