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

  StreamSubscription? _participantsSubscription;

  @override
  Future<void> close() async {
    _participantsSubscription?.cancel();
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
      final profiles =
          SubscriptionProfiles.values.map((e) => e.settings).toList();
      await _dailyClient.updateSubscriptionProfiles(profiles);

      final result = await _dailyClient.join(
        daily.JoinOptions(
          url: url,
          token: token,
          enableCamera: enableCamera,
          enableMicrophone: enableMicrophone,
        ),
      );

      emit(AvConnectedState(
        localParticipant: result.localParticipant,
        remoteParticipants: result.remoteParticipants,
      ));
    } catch (e) {
      final errorMessage =
          e is daily.DailyClientException ? e.message : 'Something is wrong';
      emit(AvErrorState(errorMessage));
    }
  }

  void _startListeners() {
    _participantsSubscription =
        _dailyClient.participants.listen((participants) {
      _onParticipantsUpdated(participants);
    });
  }

  void toggleMic() {
    final currentState = state;
    if (currentState is! AvConnectedState) return;
    try {
      _dailyClient.setMicrophoneEnabled(
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

  void _onParticipantsUpdated(daily.Participants participants) {
    final subscriptionsOptions = participants.remote
        .map(
          (e) => daily.UpdateSubscriptionOptions(
            participantId: e.id,
            profileName: SubscriptionProfiles.visible.name,
          ),
        )
        .toList();

    _dailyClient.updateSubscriptions(subscriptionsOptions);

    final currentState = state;
    if (currentState is! AvConnectedState) return;

    emit(currentState.copyWith(
      participants.local,
      participants.remote,
    ));
  }
}
