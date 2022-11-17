import 'package:daily_client/pigeon.g.dart';
import 'package:daily_client/src/models/participant/participant.dart';

class LocalParticipant extends Participant {
  const LocalParticipant({
    required super.id,
    required super.userId,
    required super.isCameraEnabled,
    required super.isMicrophoneEnabled,
  });

  factory LocalParticipant.fromMessage(LocalParticipantMessage message) {
    return LocalParticipant(
      id: message.id,
      userId: message.userId,
      isCameraEnabled: message.isCameraEnabled,
      isMicrophoneEnabled: message.isMicrophoneEnabled,
    );
  }
}
