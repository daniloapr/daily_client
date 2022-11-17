import '../daily_client.dart';
import '../pigeon.g.dart';

class DailyClient {
  final _messenger = DailyClientMessenger();

  Future<void> join(JoinOptions options) async {
    final result = await _messenger.join(
      JoinArgs(
        url: options.url,
        token: options.token,
        enableMicrophone: options.enableMicrophone,
        enableCamera: options.enableCamera,
      ),
    );
    _handleError(result.error);
  }

  Future<void> leave() async {
    final result = await _messenger.leave();
    _handleError(result.error);
  }

  void _handleError(PlatformError? error) {
    if (error != null) {
      switch (error.code) {
        case ErrorCode.invalidUrl:
          throw DailyInvalidUrlException();
        case ErrorCode.join:
          DailyJoinException();
      }
    }
  }
}
