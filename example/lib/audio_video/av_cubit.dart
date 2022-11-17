import 'package:daily_client/daily_client.dart' as daily;
import 'package:daily_client_example/dependencies.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'av_state.dart';

class AvCubit extends Cubit<AvState> {
  /// For simplicity, the Daily join() method must already have been called.
  AvCubit({
    required daily.LocalParticipant localParticipant,
    required List<daily.RemoteParticipant> remoteParticipants,
  }) : super(AvConnectedState(
          localParticipant: localParticipant,
          remoteParticipants: remoteParticipants,
        )) {
    _startListeners();
  }

  final _dailyClient = getIt<daily.DailyClient>();

  void _startListeners() {
    //TODO: start participants listener
    //TODO: start call state listener
  }

  void toggleMic() {
    final currentState = state as AvConnectedState;
    try {
      _dailyClient.setMicrophoneEnabled(
        !currentState.localParticipant.isMicrophoneEnabled,
      );
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  void toggleCamera() {
    final currentState = state as AvConnectedState;
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
}
