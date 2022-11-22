import 'package:daily_client/pigeon.g.dart';
import 'package:daily_client/src/models/participant/participant.dart';

import 'media.dart';

class LocalParticipant extends Participant {
  const LocalParticipant({
    required super.id,
    required super.userId,
    required super.isCameraEnabled,
    required super.isMicrophoneEnabled,
    super.media,
  });

  factory LocalParticipant.fromMessage(LocalParticipantMessage message) {
    final mediaMessage = message.media;
    return LocalParticipant(
      id: message.id,
      userId: message.userId,
      isCameraEnabled: message.isCameraEnabled,
      isMicrophoneEnabled: message.isMicrophoneEnabled,
      media: mediaMessage != null ? Media.fromMessage(mediaMessage) : null,
    );
  }

  @override
  String toString() {
    return 'LocalParticipant(id: $id)';
  }
}
