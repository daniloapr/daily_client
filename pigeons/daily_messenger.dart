import 'package:pigeon/pigeon.dart';

/// This is the base class of communication with native code.
/// It's used for generating the Pigeon files
@HostApi()
abstract class DailyMessenger {
  /// Join Daily call.
  @async
  JoinMessage join(JoinArgs args);

  /// Leave Daily call.
  VoidResult leave();
  VoidResult setMicrophoneEnabled(bool enableMic);
  VoidResult setCameraEnabled(bool enableCam);
  VoidResult updateSubscriptionProfiles(
    List<UpdateSubscriptionProfileArgs> args,
  );
  VoidResult updateSubscriptions(List<UpdateSubscriptionArgs> args);
  ParticipantsMessage getParticipants();
}

@FlutterApi()
abstract class DailyCallback {
  void onParticipantUpdated(RemoteParticipantMessage remoteParticipantMessage);
  void onLocalParticipantUpdated(
    LocalParticipantMessage localParticipantMessage,
  );
  void onParticipantJoined(RemoteParticipantMessage remoteParticipantMessage);
  void onParticipantLeft(RemoteParticipantMessage remoteParticipantMessage);
  void activeSpeakerChanged(RemoteParticipantMessage? remoteParticipantMessage);
  void onCallStateUpdated(int stateCode);
}

class UpdateSubscriptionArgs {
  UpdateSubscriptionArgs(this.participantId, this.profileName);

  final String participantId;
  final String profileName;
}

class VoidResult extends Message {
  VoidResult(this.error);

  @override
  PlatformError? error;
}

class PlatformError {
  const PlatformError(this.message, this.code);

  final String message;
  final Code code;
}

enum Code {
  invalidUrl,
  join,
  updateCamera,
  updateMicrophone,
  updateSubscriptions,
  updateSubscriptionProfiles,
}

class JoinArgs {
  const JoinArgs(
    this.url,
    this.token,
    this.enableMicrophone,
    this.enableCamera,
  );

  final String url;
  final String token;
  final bool enableMicrophone;
  final bool enableCamera;
}

class UpdateSubscriptionProfileArgs {
  UpdateSubscriptionProfileArgs(
    this.name,
    this.subscribeCamera,
    this.subscribeMicrophone,
  );

  final String name;
  final bool subscribeCamera;
  final bool subscribeMicrophone;
}

abstract class Message {
  abstract final PlatformError? error;
}

/// Returning class from join() function
class JoinMessage extends Message {
  JoinMessage(
    this.localParticipant,
    this.remoteParticipants,
    this.error,
  );

  final LocalParticipantMessage? localParticipant;
  final List<RemoteParticipantMessage?>? remoteParticipants;

  @override
  final PlatformError? error;
}

class LocalParticipantMessage {
  LocalParticipantMessage({
    required this.id,
    required this.userId,
    required this.media,
  });

  final String id;
  final String userId;
  final MediaMessage? media;
}

class RemoteParticipantMessage {
  RemoteParticipantMessage({
    required this.id,
    required this.userId,
    required this.userName,
    required this.media,
    required this.joinedAtIsoString,
  });

  final String id;
  final String userId;
  final String userName;
  final MediaMessage? media;
  final String joinedAtIsoString;
}

class ParticipantsMessage {
  final LocalParticipantMessage local;
  final List<RemoteParticipantMessage?> remote;

  ParticipantsMessage(this.local, this.remote);
}

class MediaMessage {
  MediaMessage({
    required this.camera,
    required this.microphone,
    required this.screenVideo,
    required this.screenAudio,
  });
  final MediaInfoMessage camera;
  final MediaInfoMessage microphone;
  final MediaInfoMessage screenVideo;
  final MediaInfoMessage screenAudio;
}

class MediaInfoMessage {
  /// Used for both Video and Audio
  MediaInfoMessage({
    required this.state,
    required this.subscribed,
    required this.track,
  });

  final MediaStateMessage state;
  final TrackSubscriptionStateMessage subscribed;
  final TrackMessage? track;
}

enum TrackSubscriptionStateMessage {
  subscribed,
  staged,
  unsubscribed,
  unknown,
}

class TrackMessage {
  final String id;
  final bool isEnabled;

  TrackMessage(this.id, this.isEnabled);
}

enum MediaStateMessage {
  /// The track is blocked, i.e. does not have permission.
  blocked,

  /// The track is off, but not blocked.
  ///
  /// This occurs when the corresponding remote media has either `isEnabled` or `isPublishing`
  /// set to `false`, or the local media has `isEnabled` set to `false`.
  off,

  /// The track has been published and is available to be received, but hasn't been subscribed to.
  receivable,

  /// The track is loading. It has been subscribed to.
  loading,

  /// The track is ready to be played. It has been subscribed to and has finished loading.
  playable,

  /// The track is currently unexpectedly (and hopefully only temporarily) unplayable.
  interrupted,
  unknown,
}
