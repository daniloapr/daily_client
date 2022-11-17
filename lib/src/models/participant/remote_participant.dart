import '../../../pigeon.g.dart';
import 'participant.dart';

class RemoteParticipant extends Participant {
  const RemoteParticipant({
    required super.id,
    required super.userId,
    required super.isCameraEnabled,
    required super.isMicrophoneEnabled,
  });

  factory RemoteParticipant.fromMessage(RemoteParticipantMessage message) {
    return RemoteParticipant(
      id: message.id,
      userId: message.userId,
      isCameraEnabled: message.isCameraEnabled,
      isMicrophoneEnabled: message.isMicrophoneEnabled,
    );
  }

  static List<RemoteParticipant> listFromMessage(
    List<RemoteParticipantMessage?> list,
  ) {
    return list
        .where((message) => message != null)
        .map((message) => RemoteParticipant.fromMessage(message!))
        .toList();
  }
}
