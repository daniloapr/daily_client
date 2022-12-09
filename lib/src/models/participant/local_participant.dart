import 'package:daily_client/daily_client.dart';
import 'package:daily_client/pigeon.g.dart';

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
    final media = mediaMessage != null ? Media.fromMessage(mediaMessage) : null;
    
    return LocalParticipant(
      id: message.id,
      userId: message.userId,
      isCameraEnabled: media?.camera.state == MediaState.playable,
      isMicrophoneEnabled: media?.microphone.state == MediaState.playable,
      media: media,
    );
  }

  @override
  String toString() {
    return '''
    LocalParticipant(
      id: $id,
      userId: $userId,
      isCameraEnabled: $isCameraEnabled,
      isMicrophoneEnabled: $isMicrophoneEnabled,
      media: $media
    )
    ''';
  }
}
