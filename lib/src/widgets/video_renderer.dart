import 'package:daily_client/src/models/participant/local_participant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../models/participant/participant.dart';

class VideoRenderer extends StatelessWidget {
  const VideoRenderer({
    super.key,
    required this.participant,
    required this.videoScaleMode,
    this.isScreenShare = false,
  });

  final Participant participant;
  final VideoScaleMode videoScaleMode;

  /// Shows a screen share instead of the camera when available
  final bool isScreenShare;
  // This is used in the platform side to register the view.
  static const String viewType = 'DailyVideoRenderer';

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> creationParams = <String, dynamic>{
      "participantId": participant.id,
      "isLocal": participant is LocalParticipant,
      "videoScaleMode": videoScaleMode.index,
      "isScreenShare": isScreenShare,
    };

    return SizedBox.expand(
      child: Builder(
        builder: (context) {
          switch (defaultTargetPlatform) {
            case TargetPlatform.iOS:
              return UiKitView(
                viewType: viewType,
                layoutDirection: TextDirection.ltr,
                creationParams: creationParams,
                creationParamsCodec: const StandardMessageCodec(),
              );
            default:
              throw UnsupportedError('Unsupported platform view');
          }
        },
      ),
    );
  }
}

enum VideoScaleMode {
  /// Resizes the content so it’s all within the available space,
  /// both vertically and horizontally.
  ///
  /// This mode preserves the content’s aspect ratio. If the content doesn’t have
  /// the same aspect ratio as the available space, the content becomes the same
  /// size as the available space on one axis and leaves empty space on the other.
  fit,

  /// Resize the content so it occupies all available space,
  /// both vertically and horizontally.
  ///
  /// This mode preserves the content’s aspect ratio. If the content doesn’t have
  /// the same aspect ratio as the available space, the content becomes the same
  /// size as the available space on one axis, and larger on the other axis.
  fill,
}
