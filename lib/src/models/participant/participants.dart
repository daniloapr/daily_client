import 'local_participant.dart';
import 'remote_participant.dart';

class Participants {
  const Participants({
    required this.local,
    required this.remote,
  });

  final LocalParticipant local;
  final List<RemoteParticipant> remote;

  @override
  String toString() {
    return 'Participants(local: $local, remote: $remote)';
  }
}
