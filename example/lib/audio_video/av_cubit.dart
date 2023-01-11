import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:daily_client/daily_client.dart' as daily;

import '../dependencies.dart';
import '../core/subscription_profiles.dart';
import 'av_state.dart';

class AvCubit extends Cubit<AvState> {
  AvCubit() : super(AvInitialState()) {
    _startListeners();
  }

  final _dailyClient = getIt<daily.DailyClient>();

  StreamSubscription? _eventsSubscription;

  @override
  Future<void> close() async {
    _eventsSubscription?.cancel();
    super.close();
  }

  void join({
    required String url,
    required String token,
    required bool enableCamera,
    required bool enableMicrophone,
  }) async {
    _startListeners();
    emit(AvLoadingState());

    try {
      // The updateSubscriptionProfiles is not necessary unless you need
      // to handle custom subscriptions.
      final profiles =
          SubscriptionProfiles.values.map((e) => e.settings).toList();
      await _dailyClient.updateSubscriptionProfiles(profiles);

      final result = await _dailyClient.join(
        url: url,
        token: token,
        enableCamera: enableCamera,
        enableMicrophone: enableMicrophone,
      );

      final remoteParticipantsById = <String, daily.RemoteParticipant>{};

      for (var participant in result.remoteParticipants) {
        remoteParticipantsById[participant.id] = participant;
      }

      emit(AvConnectedState(
        localParticipant: result.localParticipant,
        remoteParticipantById: remoteParticipantsById,
      ));
    } on daily.DailyClientException catch (e) {
      final errorMessage = e.message;
      emit(AvErrorState(errorMessage));
    }
  }

  void _startListeners() {
    _eventsSubscription = _dailyClient.events.listen((event) {
      if (event is daily.ParticipantJoinedEvent) {
        _onParticipantJoined(event.remoteParticipant);
      }
      if (event is daily.ParticipantLeftEvent) {
        _onParticipantLeft(event.remoteParticipant);
      }
      if (event is daily.ParticipantUpdatedEvent) {
        _onParticipantUpdated(event.remoteParticipant);
      }
      if (event is daily.LocalParticipantUpdatedEvent) {
        _onLocalParticipantUpdated(event.localParticipant);
      }
      if (event is daily.ActiveSpeakerChangedEvent) {
        _onActiveSpeakerChanged(event.remoteParticipant);
      }
    });
  }

  void toggleMic() async {
    final currentState = state;
    if (currentState is! AvConnectedState) return;
    try {
      await _dailyClient.setMicrophoneEnabled(
        !currentState.localParticipant.isMicrophoneEnabled,
      );
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  void toggleCamera() {
    final currentState = state;
    if (currentState is! AvConnectedState) return;
    try {
      _dailyClient.setCameraEnabled(
        !currentState.localParticipant.isCameraEnabled,
      );
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  void leave() async {
    await _dailyClient.leave();
    emit(const AvLeftState());
  }

  void _onParticipantJoined(daily.RemoteParticipant participant) {
    // This is setting the `visible` profile as default. It's not necessary
    // unless you need to handle custom subscriptions.
    _dailyClient.updateSubscriptions([
      daily.UpdateSubscriptionOptions(
        participantId: participant.id,
        profileName: SubscriptionProfiles.visible.name,
      )
    ]);

    final currentState = state;
    if (currentState is! AvConnectedState) return;

    final participants = Map<String, daily.RemoteParticipant>.from(
      currentState.remoteParticipantById,
    );
    participants[participant.id] = participant;

    emit(currentState.copyWith(
      remoteParticipantById: participants,
    ));
  }

  void _onParticipantLeft(daily.RemoteParticipant participant) {
    final currentState = state;
    if (currentState is! AvConnectedState) return;

    final participants = Map<String, daily.RemoteParticipant>.from(
      currentState.remoteParticipantById,
    );
    participants.remove(participant.id);

    emit(currentState.copyWith(
      remoteParticipantById: participants,
    ));
  }

  void _onParticipantUpdated(daily.RemoteParticipant participant) {
    final currentState = state;
    if (currentState is! AvConnectedState) return;

    final participants = Map<String, daily.RemoteParticipant>.from(
      currentState.remoteParticipantById,
    );
    participants[participant.id] = participant;

    emit(currentState.copyWith(
      remoteParticipantById: participants,
    ));
  }

  void _onLocalParticipantUpdated(daily.LocalParticipant localParticipant) {
    final currentState = state;
    if (currentState is! AvConnectedState) return;

    emit(currentState.copyWith(
      localParticipant: localParticipant,
    ));
  }

  void _onActiveSpeakerChanged(daily.RemoteParticipant? participant) {
    //TODO: implement active speaker sorting feature.
  }
}
