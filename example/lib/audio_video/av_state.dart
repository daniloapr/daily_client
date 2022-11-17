import 'package:daily_client/daily_client.dart' as daily;

abstract class AvState {
  const AvState();
}

class AvConnectedState extends AvState {
  const AvConnectedState({
    required this.localParticipant,
    required this.remoteParticipants,
  });
  final daily.LocalParticipant localParticipant;
  final List<daily.RemoteParticipant> remoteParticipants;

  AvConnectedState copyWith(
    daily.LocalParticipant? localParticipant,
    List<daily.RemoteParticipant>? remoteParticipants,
  ) {
    return AvConnectedState(
      localParticipant: localParticipant ?? this.localParticipant,
      remoteParticipants: remoteParticipants ?? this.remoteParticipants,
    );
  }
}

class AvLeftState extends AvState {
  const AvLeftState();
}
