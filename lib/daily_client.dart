
import 'daily_client_platform_interface.dart';

class DailyClient {
  Future<String?> getPlatformVersion() {
    return DailyClientPlatform.instance.getPlatformVersion();
  }
}
