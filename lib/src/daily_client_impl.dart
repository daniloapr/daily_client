import 'dart:async';

import 'models/daily_client_exception.dart';
import 'models/join/join_result.dart';
import 'models/participant/local_participant.dart';
import 'models/participant/participants.dart';

import '../pigeon.g.dart';
import 'models/join/join_options.dart';
import 'models/participant/remote_participant.dart';
import 'models/state/call_state.dart';

class DailyClient extends DailyCallback {
  final _messenger = DailyMessenger();

  final _participantsController = StreamController<Participants>.broadcast();
  final _callStateController = StreamController<CallState>.broadcast();

  Stream<Participants> get participants => _participantsController.stream;
  Stream<CallState> get callState => _callStateController.stream;

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

    final remoteParticipants =
        RemoteParticipant.listFromMessage(result.remoteParticipants!);

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

  /// This function is called from the native side.
  @override
  void onParticipantsUpdated(
    LocalParticipantMessage localParticipantMessage,
    List<RemoteParticipantMessage?> remoteParticipantsMessage,
  ) {
    _participantsController.add(Participants(
      local: LocalParticipant.fromMessage(localParticipantMessage),
      remote: RemoteParticipant.listFromMessage(remoteParticipantsMessage),
    ));
  }

  @override
  void onCallStateUpdated(int stateCode) {
    final callState = _mapCodeToCallState(stateCode);
    _callStateController.add(callState);
  }

  CallState _mapCodeToCallState(int stateCode) {
    switch (stateCode) {
      case 0:
        return CallState.initial;
      case 1:
        return CallState.joining;
      case 2:
        return CallState.joined;
      case 3:
        return CallState.leaving;
      case 4:
        return CallState.left;
      default:
        return CallState.initial;
    }
  }
}
