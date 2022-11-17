import '../participant/local_participant.dart';
import '../participant/remote_participant.dart';

class JoinResult {
  const JoinResult({
    required this.localParticipant,
    required this.remoteParticipants,
  });

  final LocalParticipant localParticipant;
  final List<RemoteParticipant> remoteParticipants;
}
