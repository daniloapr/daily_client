import 'package:daily_client/daily_client.dart' as daily;

abstract class AvState {
  const AvState();
}

class AvConnectedState extends AvState {
  const AvConnectedState({
    required this.localParticipant,
    required this.remoteParticipantById,
  });
  final daily.LocalParticipant localParticipant;
  final Map<String, daily.RemoteParticipant> remoteParticipantById;

  AvConnectedState copyWith({
    daily.LocalParticipant? localParticipant,
    Map<String, daily.RemoteParticipant>? remoteParticipantById,
  }) {
    return AvConnectedState(
      localParticipant: localParticipant ?? this.localParticipant,
      remoteParticipantById:
          remoteParticipantById ?? this.remoteParticipantById,
    );
  }
}

class AvInitialState extends AvState {}

class AvLoadingState extends AvState {}

class AvErrorState extends AvState {
  AvErrorState(this.message);
  String message;
}

class AvLeftState extends AvState {
  const AvLeftState();
}
