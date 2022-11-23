import '../../../pigeon.g.dart';
import 'media.dart';
import 'participant.dart';

class RemoteParticipant extends Participant {
  const RemoteParticipant({
    required super.id,
    required super.userId,
    required super.isCameraEnabled,
    required super.isMicrophoneEnabled,
    required super.media,
  });

  factory RemoteParticipant.fromMessage(RemoteParticipantMessage message) {
    return RemoteParticipant(
      id: message.id,
      userId: message.userId,
      isCameraEnabled: message.isCameraEnabled,
      isMicrophoneEnabled: message.isMicrophoneEnabled,
      media: message.media != null ? Media.fromMessage(message.media!) : null,
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

  @override
  String toString() {
    return 'RemoteParticipant(id: $id)';
  }
}
