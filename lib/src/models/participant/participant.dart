import 'package:daily_client/src/models/participant/media_state.dart';

import 'media.dart';

abstract class Participant {
  const Participant({
    required this.id,
    required this.userId,
    required this.isCameraEnabled,
    required this.isMicrophoneEnabled,
    required this.media,
  });

  /// ID defined by the Daily server.
  final String id;

  /// ID defined by the client side.
  final String userId;
  final bool isCameraEnabled;
  final bool isMicrophoneEnabled;
  final Media? media;

  bool get isSharingScreen => media?.screenVideo.state == MediaState.playable;
}
