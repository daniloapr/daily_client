import '../../../daily_client.dart';
import '../../../pigeon.g.dart';

class RemoteParticipant extends Participant {
  const RemoteParticipant({
    required super.id,
    required super.userId,
    required super.isCameraEnabled,
    required super.isMicrophoneEnabled,
    required super.media,
    required this.userName,
    required this.joinedAt,
  });

  final DateTime? joinedAt;
  final String userName;

  factory RemoteParticipant.fromMessage(RemoteParticipantMessage message) {
    final mediaMessage = message.media;
    final media = mediaMessage != null ? Media.fromMessage(mediaMessage) : null;

    return RemoteParticipant(
      id: message.id,
      userId: message.userId,
      userName: message.userName,
      isCameraEnabled: media?.camera.state == MediaState.playable,
      isMicrophoneEnabled: media?.microphone.state == MediaState.playable,
      media: media,
      joinedAt: DateTime.tryParse(message.joinedAtIsoString),
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
    return '''
    RemoteParticipant(
      id: $id,
      userId: $userId,
      isCameraEnabled: $isCameraEnabled,
      isMicrophoneEnabled: $isMicrophoneEnabled,
      media: $media,
      joinedAt: $joinedAt
    )
    ''';
  }
}
