import 'package:daily_client/src/models/join/join_result.dart';

import '../daily_client.dart';
import '../pigeon.g.dart';

class DailyClient {
  final _messenger = DailyMessenger();

  Future<JoinResult> join(JoinOptions options) async {
    final result = await _messenger.join(
      JoinArgs(
        url: options.url,
        token: options.token,
        enableMicrophone: options.enableMicrophone,
        enableCamera: options.enableCamera,
      ),
    );
    _handleError(result.error);

    if (result.localParticipant == null || result.remoteParticipants == null) {
      throw DailyNullParticipantsException();
    }

    final localParticipant =
        LocalParticipant.fromMessage(result.localParticipant!);

    final remoteParticipants = result.remoteParticipants!
        .where((message) => message != null)
        .map((message) => RemoteParticipant.fromMessage(message!))
        .toList();

    return JoinResult(
      localParticipant: localParticipant,
      remoteParticipants: remoteParticipants,
    );
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
          throw DailyJoinException();
        case ErrorCode.updateCamera:
          throw DailyUpdateCameraException();
        case ErrorCode.updateMicrophone:
          throw DailyUpdateCameraException();
      }
    }
  }

  void setMicrophoneEnabled(bool enableMic) {
    _messenger.setMicrophoneEnabled(enableMic);
  }

  void setCameraEnabled(bool enableCamera) {
    _messenger.setCameraEnabled(enableCamera);
  }
}
