import 'package:daily_client/pigeon.g.dart';

class DailyClient {
  final _messenger = DailyClientMessenger();

  Future<void> join(String url) async {
    final result = await _messenger.join(JoinArgs(
      url: url,
      token: 'token',
      isMicEnabled: false,
      isCameraEnabled: false,
    ));
    print(result.error?.message);
  }

  Future<void> leave() async {
    await _messenger.leave();
  }
}
