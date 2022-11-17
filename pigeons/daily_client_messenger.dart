import 'package:pigeon/pigeon.dart';

/// This is the base class used for generating the pigeon code
@HostApi()
abstract class DailyClientMessenger {
  @async
  VoidResult join(JoinArgs args);

  VoidResult leave();
}

class VoidResult {
  const VoidResult(this.error);

  final PlatformError? error;
}

class PlatformError {
  const PlatformError(this.message, this.code);

  final String message;
  final ErrorCode code;
}

enum ErrorCode { invalidUrl, join }

class JoinArgs {
  const JoinArgs(
    this.url,
    this.token,
    this.enableMicrophone,
    this.enableCamera,
  );

  final String url;
  final String token;
  final bool enableMicrophone;
  final bool enableCamera;
}
