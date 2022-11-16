import 'package:pigeon/pigeon.dart';

class VoidResult {
  const VoidResult({this.error});
  final PlatformError? error;
}

class PlatformError {
  const PlatformError(this.message, this.code);

  final String message;
  final int code;
}

class JoinArgs {
  const JoinArgs({
    required this.url,
    this.token = "",
    this.isMicEnabled = false,
    this.isCameraEnabled = false,
  });

  final String url;
  final String token;
  final bool isMicEnabled;
  final bool isCameraEnabled;
}

@HostApi()
abstract class DailyClientMessenger {
  @async
  VoidResult join(JoinArgs args);

  VoidResult leave();
}
