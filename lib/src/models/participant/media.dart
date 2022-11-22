import 'package:daily_client/pigeon.g.dart';
import 'package:daily_client/src/models/participant/media_info.dart';

class Media {
  const Media({
    required this.camera,
    required this.microphone,
    required this.screenVideo,
    required this.screenAudio,
  });

  final MediaInfo camera;
  final MediaInfo microphone;
  final MediaInfo screenVideo;
  final MediaInfo screenAudio;

  factory Media.fromMessage(MediaMessage mediaMessage) {
    return Media(
      camera: MediaInfo.fromMessage(mediaMessage.camera),
      microphone: MediaInfo.fromMessage(mediaMessage.microphone),
      screenVideo: MediaInfo.fromMessage(mediaMessage.screenVideo),
      screenAudio: MediaInfo.fromMessage(mediaMessage.screenAudio),
    );
  }
}
