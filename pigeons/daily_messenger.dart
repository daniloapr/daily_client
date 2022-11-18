import 'package:pigeon/pigeon.dart';

/// This is the base class of communication with native code.
/// It's used for generating the Pigeon files
@HostApi()
abstract class DailyMessenger {
  /// Join Daily call.
  @async
  JoinMessage join(JoinArgs args);

  /// Leave Daily call.
  VoidResult leave();
  VoidResult setMicrophoneEnabled(bool enableMic);
  VoidResult setCameraEnabled(bool enableCam);
}

@FlutterApi()
abstract class DailyCallback {
  void onParticipantsUpdated(
    LocalParticipantMessage localParticipantMessage,
    List<RemoteParticipantMessage?> remoteParticipantsMessage,
  );

  void onCallStateUpdated(int stateCode);
}

class VoidResult extends Message {
  VoidResult(this.error);

  @override
  PlatformError? error;
}

class PlatformError {
  const PlatformError(this.message, this.code);

  final String message;
  final ErrorCode code;
}

enum ErrorCode {
  invalidUrl,
  join,
  updateCamera,
  updateMicrophone,
}

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

abstract class Message {
  abstract final PlatformError? error;
}

/// Returning class from join() function
class JoinMessage extends Message {
  JoinMessage(
    this.localParticipant,
    this.remoteParticipants,
    this.error,
  );

  final LocalParticipantMessage? localParticipant;
  final List<RemoteParticipantMessage?>? remoteParticipants;

  @override
  final PlatformError? error;
}

class LocalParticipantMessage {
  LocalParticipantMessage({
    required this.id,
    required this.userId,
    required this.isCameraEnabled,
    required this.isMicrophoneEnabled,
  });

  final String id;
  final bool isCameraEnabled;
  final bool isMicrophoneEnabled;
  final String userId;
}

class RemoteParticipantMessage {
  RemoteParticipantMessage({
    required this.id,
    required this.userId,
    required this.isCameraEnabled,
    required this.isMicrophoneEnabled,
  });

  final String id;
  final bool isCameraEnabled;
  final bool isMicrophoneEnabled;
  final String userId;
}
