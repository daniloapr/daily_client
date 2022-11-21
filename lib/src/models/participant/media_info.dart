import 'package:daily_client/pigeon.g.dart';

import 'media_state.dart';
import 'track.dart';
import 'track_subscription_state.dart';

class MediaInfo {
  MediaInfo({
    required this.state,
    required this.subscribed,
    required this.track,
  });

  final MediaState state;
  final TrackSubscriptionState subscribed;
  final Track? track;

  factory MediaInfo.fromMessage(MediaInfoMessage message) {
    final trackMessage = message.track;
    final track = message.track != null
        ? Track(id: trackMessage!.id, isEnabled: trackMessage.isEnabled)
        : null;

    return MediaInfo(
      state: _mapMediaStateMessage(message.state),
      subscribed: _mapTrackSubscriptionState(message.subscribed),
      track: track,
    );
  }
}

MediaState _mapMediaStateMessage(MediaStateMessage message) {
  switch (message) {
    case MediaStateMessage.blocked:
      return MediaState.blocked;
    case MediaStateMessage.off:
      return MediaState.off;
    case MediaStateMessage.receivable:
      return MediaState.receivable;
    case MediaStateMessage.loading:
      return MediaState.loading;
    case MediaStateMessage.playable:
      return MediaState.playable;
    case MediaStateMessage.interrupted:
      return MediaState.interrupted;
    case MediaStateMessage.unknown:
      return MediaState.unknown;
  }
}

TrackSubscriptionState _mapTrackSubscriptionState(
  TrackSubscriptionStateMessage message,
) {
  switch (message) {
    case TrackSubscriptionStateMessage.subscribed:
      return TrackSubscriptionState.subscribed;
    case TrackSubscriptionStateMessage.staged:
      return TrackSubscriptionState.staged;
    case TrackSubscriptionStateMessage.unsubscribed:
      return TrackSubscriptionState.unsubscribed;
    case TrackSubscriptionStateMessage.unknown:
      return TrackSubscriptionState.unknown;
  }
}
