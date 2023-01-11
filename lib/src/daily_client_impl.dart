import 'dart:async';

import '../pigeon.g.dart';
import 'models/events/daily_event.dart';
import 'models/exception/daily_client_exception.dart';
import 'models/join/join_result.dart';
import 'models/participant/local_participant.dart';
import 'models/participant/remote_participant.dart';
import 'models/profiles/subscription_profile_settings_update.dart';
import 'models/profiles/update_subscriptions.dart';
import 'models/state/call_state.dart';

class DailyClient extends DailyCallback {
  DailyClient() {
    DailyCallback.setup(this);
  }

  final _messenger = DailyMessenger();

  final _eventsController = StreamController<DailyEvent>.broadcast();
  final _callStateController = StreamController<CallState>.broadcast();

  Stream<DailyEvent> get events => _eventsController.stream;
  Stream<CallState> get callState => _callStateController.stream;

  Future<JoinResult> join({
    required String url,
    String token = '',
    bool enableCamera = false,
    bool enableMicrophone = false,
  }) async {
    final result = await _messenger.join(
      JoinArgs(
        url: url,
        token: token,
        enableMicrophone: enableMicrophone,
        enableCamera: enableCamera,
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

  Future<void> updateSubscriptionProfiles(
    List<SubscriptionProfileSettingsUpdate> settings,
  ) async {
    final args = settings
        .map(
          (e) => UpdateSubscriptionProfileArgs(
            name: e.name,
            subscribeCamera: e.subscribeCamera,
            subscribeMicrophone: e.subscribeMicrophone,
          ),
        )
        .toList();
    await _messenger.updateSubscriptionProfiles(args);
  }

  /// Update Participants with id [option.participantId] to profile subscription
  /// with name [options.profileName].
  Future<void> updateSubscriptions(
    List<UpdateSubscriptionOptions> options,
  ) async {
    final args = options
        .map((e) => UpdateSubscriptionArgs(
              participantId: e.participantId,
              profileName: e.profileName,
            ))
        .toList();
    await _messenger.updateSubscriptions(args);
  }

  Future<void> leave() async {
    final result = await _messenger.leave();
    _handleError(result.error);
  }

  void _handleError(PlatformError? error) {
    if (error != null) {
      switch (error.code) {
        case Code.invalidUrl:
          throw DailyInvalidUrlException();
        case Code.join:
          throw DailyJoinException();
        case Code.updateCamera:
          throw DailyUpdateCameraException();
        case Code.updateMicrophone:
          throw DailyUpdateCameraException();
        case Code.updateSubscriptionProfiles:
          throw DailyUpdateSubscriptionProfiles();
        case Code.updateSubscriptions:
          throw DailyUpdateSubscriptions();
      }
    }
  }

  Future<void> setMicrophoneEnabled(bool enableMic) async {
    await _messenger.setMicrophoneEnabled(enableMic);
  }

  Future<void> setCameraEnabled(bool enableCamera) async {
    await _messenger.setCameraEnabled(enableCamera);
  }

  /// This function is called from the native side. Do not call it directly.
  @override
  void onParticipantUpdated(
    RemoteParticipantMessage remoteParticipantMessage,
  ) {
    _eventsController.add(ParticipantUpdatedEvent(
      RemoteParticipant.fromMessage(remoteParticipantMessage),
    ));
  }

  /// This function is called from the native side. Do not call it directly.
  @override
  void onLocalParticipantUpdated(
    LocalParticipantMessage localParticipantMessage,
  ) {
    _eventsController.add(LocalParticipantUpdatedEvent(
      LocalParticipant.fromMessage(localParticipantMessage),
    ));
  }

  /// This function is called from the native side. Do not call it directly.
  @override
  void onParticipantJoined(RemoteParticipantMessage remoteParticipantMessage) {
    _eventsController.add(ParticipantJoinedEvent(
      RemoteParticipant.fromMessage(remoteParticipantMessage),
    ));
  }

  /// This function is called from the native side. Do not call it directly.
  @override
  void onParticipantLeft(RemoteParticipantMessage remoteParticipantMessage) {
    _eventsController.add(ParticipantLeftEvent(
      RemoteParticipant.fromMessage(remoteParticipantMessage),
    ));
  }

  /// This function is called from the native side. Do not call it directly.
  @override
  void activeSpeakerChanged(
      RemoteParticipantMessage? remoteParticipantMessage) {
    final participant = remoteParticipantMessage != null
        ? RemoteParticipant.fromMessage(remoteParticipantMessage)
        : null;

    _eventsController.add(ActiveSpeakerChangedEvent(participant));
  }

  /// This function is called from the native side. Do not call it directly.
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
