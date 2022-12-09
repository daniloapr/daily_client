// Autogenerated from Pigeon (v4.2.6), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import
import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

enum Code {
  invalidUrl,
  join,
  updateCamera,
  updateMicrophone,
  updateSubscriptions,
  updateSubscriptionProfiles,
}

enum TrackSubscriptionStateMessage {
  subscribed,
  staged,
  unsubscribed,
  unknown,
}

enum MediaStateMessage {
  blocked,
  off,
  receivable,
  loading,
  playable,
  interrupted,
  unknown,
}

class UpdateSubscriptionArgs {
  UpdateSubscriptionArgs({
    required this.participantId,
    required this.profileName,
  });

  String participantId;
  String profileName;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['participantId'] = participantId;
    pigeonMap['profileName'] = profileName;
    return pigeonMap;
  }

  static UpdateSubscriptionArgs decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return UpdateSubscriptionArgs(
      participantId: pigeonMap['participantId']! as String,
      profileName: pigeonMap['profileName']! as String,
    );
  }
}

class VoidResult {
  VoidResult({
    this.error,
  });

  PlatformError? error;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['error'] = error?.encode();
    return pigeonMap;
  }

  static VoidResult decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return VoidResult(
      error: pigeonMap['error'] != null
          ? PlatformError.decode(pigeonMap['error']!)
          : null,
    );
  }
}

class PlatformError {
  PlatformError({
    required this.message,
    required this.code,
  });

  String message;
  Code code;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['message'] = message;
    pigeonMap['code'] = code.index;
    return pigeonMap;
  }

  static PlatformError decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return PlatformError(
      message: pigeonMap['message']! as String,
      code: Code.values[pigeonMap['code']! as int]
,
    );
  }
}

class JoinArgs {
  JoinArgs({
    required this.url,
    required this.token,
    required this.enableMicrophone,
    required this.enableCamera,
  });

  String url;
  String token;
  bool enableMicrophone;
  bool enableCamera;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['url'] = url;
    pigeonMap['token'] = token;
    pigeonMap['enableMicrophone'] = enableMicrophone;
    pigeonMap['enableCamera'] = enableCamera;
    return pigeonMap;
  }

  static JoinArgs decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return JoinArgs(
      url: pigeonMap['url']! as String,
      token: pigeonMap['token']! as String,
      enableMicrophone: pigeonMap['enableMicrophone']! as bool,
      enableCamera: pigeonMap['enableCamera']! as bool,
    );
  }
}

class UpdateSubscriptionProfileArgs {
  UpdateSubscriptionProfileArgs({
    required this.name,
    required this.subscribeCamera,
    required this.subscribeMicrophone,
  });

  String name;
  bool subscribeCamera;
  bool subscribeMicrophone;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['name'] = name;
    pigeonMap['subscribeCamera'] = subscribeCamera;
    pigeonMap['subscribeMicrophone'] = subscribeMicrophone;
    return pigeonMap;
  }

  static UpdateSubscriptionProfileArgs decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return UpdateSubscriptionProfileArgs(
      name: pigeonMap['name']! as String,
      subscribeCamera: pigeonMap['subscribeCamera']! as bool,
      subscribeMicrophone: pigeonMap['subscribeMicrophone']! as bool,
    );
  }
}

/// Returning class from join() function
class JoinMessage {
  JoinMessage({
    this.localParticipant,
    this.remoteParticipants,
    this.error,
  });

  LocalParticipantMessage? localParticipant;
  List<RemoteParticipantMessage?>? remoteParticipants;
  PlatformError? error;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['localParticipant'] = localParticipant?.encode();
    pigeonMap['remoteParticipants'] = remoteParticipants;
    pigeonMap['error'] = error?.encode();
    return pigeonMap;
  }

  static JoinMessage decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return JoinMessage(
      localParticipant: pigeonMap['localParticipant'] != null
          ? LocalParticipantMessage.decode(pigeonMap['localParticipant']!)
          : null,
      remoteParticipants: (pigeonMap['remoteParticipants'] as List<Object?>?)?.cast<RemoteParticipantMessage?>(),
      error: pigeonMap['error'] != null
          ? PlatformError.decode(pigeonMap['error']!)
          : null,
    );
  }
}

class LocalParticipantMessage {
  LocalParticipantMessage({
    required this.id,
    required this.userId,
    this.media,
  });

  String id;
  String userId;
  MediaMessage? media;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['id'] = id;
    pigeonMap['userId'] = userId;
    pigeonMap['media'] = media?.encode();
    return pigeonMap;
  }

  static LocalParticipantMessage decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return LocalParticipantMessage(
      id: pigeonMap['id']! as String,
      userId: pigeonMap['userId']! as String,
      media: pigeonMap['media'] != null
          ? MediaMessage.decode(pigeonMap['media']!)
          : null,
    );
  }
}

class RemoteParticipantMessage {
  RemoteParticipantMessage({
    required this.id,
    required this.userId,
    required this.userName,
    this.media,
    required this.joinedAtIsoString,
  });

  String id;
  String userId;
  String userName;
  MediaMessage? media;
  String joinedAtIsoString;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['id'] = id;
    pigeonMap['userId'] = userId;
    pigeonMap['userName'] = userName;
    pigeonMap['media'] = media?.encode();
    pigeonMap['joinedAtIsoString'] = joinedAtIsoString;
    return pigeonMap;
  }

  static RemoteParticipantMessage decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return RemoteParticipantMessage(
      id: pigeonMap['id']! as String,
      userId: pigeonMap['userId']! as String,
      userName: pigeonMap['userName']! as String,
      media: pigeonMap['media'] != null
          ? MediaMessage.decode(pigeonMap['media']!)
          : null,
      joinedAtIsoString: pigeonMap['joinedAtIsoString']! as String,
    );
  }
}

class ParticipantsMessage {
  ParticipantsMessage({
    required this.local,
    required this.remote,
  });

  LocalParticipantMessage local;
  List<RemoteParticipantMessage?> remote;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['local'] = local.encode();
    pigeonMap['remote'] = remote;
    return pigeonMap;
  }

  static ParticipantsMessage decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return ParticipantsMessage(
      local: LocalParticipantMessage.decode(pigeonMap['local']!)
,
      remote: (pigeonMap['remote'] as List<Object?>?)!.cast<RemoteParticipantMessage?>(),
    );
  }
}

class MediaMessage {
  MediaMessage({
    required this.camera,
    required this.microphone,
    required this.screenVideo,
    required this.screenAudio,
  });

  MediaInfoMessage camera;
  MediaInfoMessage microphone;
  MediaInfoMessage screenVideo;
  MediaInfoMessage screenAudio;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['camera'] = camera.encode();
    pigeonMap['microphone'] = microphone.encode();
    pigeonMap['screenVideo'] = screenVideo.encode();
    pigeonMap['screenAudio'] = screenAudio.encode();
    return pigeonMap;
  }

  static MediaMessage decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return MediaMessage(
      camera: MediaInfoMessage.decode(pigeonMap['camera']!)
,
      microphone: MediaInfoMessage.decode(pigeonMap['microphone']!)
,
      screenVideo: MediaInfoMessage.decode(pigeonMap['screenVideo']!)
,
      screenAudio: MediaInfoMessage.decode(pigeonMap['screenAudio']!)
,
    );
  }
}

class MediaInfoMessage {
  MediaInfoMessage({
    required this.state,
    required this.subscribed,
    this.track,
  });

  MediaStateMessage state;
  TrackSubscriptionStateMessage subscribed;
  TrackMessage? track;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['state'] = state.index;
    pigeonMap['subscribed'] = subscribed.index;
    pigeonMap['track'] = track?.encode();
    return pigeonMap;
  }

  static MediaInfoMessage decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return MediaInfoMessage(
      state: MediaStateMessage.values[pigeonMap['state']! as int]
,
      subscribed: TrackSubscriptionStateMessage.values[pigeonMap['subscribed']! as int]
,
      track: pigeonMap['track'] != null
          ? TrackMessage.decode(pigeonMap['track']!)
          : null,
    );
  }
}

class TrackMessage {
  TrackMessage({
    required this.id,
    required this.isEnabled,
  });

  String id;
  bool isEnabled;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['id'] = id;
    pigeonMap['isEnabled'] = isEnabled;
    return pigeonMap;
  }

  static TrackMessage decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return TrackMessage(
      id: pigeonMap['id']! as String,
      isEnabled: pigeonMap['isEnabled']! as bool,
    );
  }
}

class _DailyMessengerCodec extends StandardMessageCodec{
  const _DailyMessengerCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is JoinArgs) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else 
    if (value is JoinMessage) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else 
    if (value is LocalParticipantMessage) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else 
    if (value is LocalParticipantMessage) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else 
    if (value is MediaInfoMessage) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else 
    if (value is MediaMessage) {
      buffer.putUint8(133);
      writeValue(buffer, value.encode());
    } else 
    if (value is ParticipantsMessage) {
      buffer.putUint8(134);
      writeValue(buffer, value.encode());
    } else 
    if (value is PlatformError) {
      buffer.putUint8(135);
      writeValue(buffer, value.encode());
    } else 
    if (value is RemoteParticipantMessage) {
      buffer.putUint8(136);
      writeValue(buffer, value.encode());
    } else 
    if (value is TrackMessage) {
      buffer.putUint8(137);
      writeValue(buffer, value.encode());
    } else 
    if (value is UpdateSubscriptionArgs) {
      buffer.putUint8(138);
      writeValue(buffer, value.encode());
    } else 
    if (value is UpdateSubscriptionProfileArgs) {
      buffer.putUint8(139);
      writeValue(buffer, value.encode());
    } else 
    if (value is VoidResult) {
      buffer.putUint8(140);
      writeValue(buffer, value.encode());
    } else 
{
      super.writeValue(buffer, value);
    }
  }
  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:       
        return JoinArgs.decode(readValue(buffer)!);
      
      case 129:       
        return JoinMessage.decode(readValue(buffer)!);
      
      case 130:       
        return LocalParticipantMessage.decode(readValue(buffer)!);
      
      case 131:       
        return LocalParticipantMessage.decode(readValue(buffer)!);
      
      case 132:       
        return MediaInfoMessage.decode(readValue(buffer)!);
      
      case 133:       
        return MediaMessage.decode(readValue(buffer)!);
      
      case 134:       
        return ParticipantsMessage.decode(readValue(buffer)!);
      
      case 135:       
        return PlatformError.decode(readValue(buffer)!);
      
      case 136:       
        return RemoteParticipantMessage.decode(readValue(buffer)!);
      
      case 137:       
        return TrackMessage.decode(readValue(buffer)!);
      
      case 138:       
        return UpdateSubscriptionArgs.decode(readValue(buffer)!);
      
      case 139:       
        return UpdateSubscriptionProfileArgs.decode(readValue(buffer)!);
      
      case 140:       
        return VoidResult.decode(readValue(buffer)!);
      
      default:      
        return super.readValueOfType(type, buffer);
      
    }
  }
}

/// This is the base class of communication with native code.
/// It's used for generating the Pigeon files
class DailyMessenger {
  /// Constructor for [DailyMessenger].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  DailyMessenger({BinaryMessenger? binaryMessenger}) : _binaryMessenger = binaryMessenger;
  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _DailyMessengerCodec();

  /// Join Daily call.
  Future<JoinMessage> join(JoinArgs arg_args) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.DailyMessenger.join', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_args]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else if (replyMap['result'] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyMap['result'] as JoinMessage?)!;
    }
  }

  /// Leave Daily call.
  Future<VoidResult> leave() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.DailyMessenger.leave', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(null) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else if (replyMap['result'] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyMap['result'] as VoidResult?)!;
    }
  }

  Future<VoidResult> setMicrophoneEnabled(bool arg_enableMic) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.DailyMessenger.setMicrophoneEnabled', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_enableMic]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else if (replyMap['result'] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyMap['result'] as VoidResult?)!;
    }
  }

  Future<VoidResult> setCameraEnabled(bool arg_enableCam) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.DailyMessenger.setCameraEnabled', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_enableCam]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else if (replyMap['result'] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyMap['result'] as VoidResult?)!;
    }
  }

  Future<VoidResult> updateSubscriptionProfiles(List<UpdateSubscriptionProfileArgs?> arg_args) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.DailyMessenger.updateSubscriptionProfiles', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_args]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else if (replyMap['result'] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyMap['result'] as VoidResult?)!;
    }
  }

  Future<VoidResult> updateSubscriptions(List<UpdateSubscriptionArgs?> arg_args) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.DailyMessenger.updateSubscriptions', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_args]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else if (replyMap['result'] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyMap['result'] as VoidResult?)!;
    }
  }

  Future<ParticipantsMessage> getParticipants() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.DailyMessenger.getParticipants', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(null) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else if (replyMap['result'] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyMap['result'] as ParticipantsMessage?)!;
    }
  }
}

class _DailyCallbackCodec extends StandardMessageCodec{
  const _DailyCallbackCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is LocalParticipantMessage) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else 
    if (value is MediaInfoMessage) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else 
    if (value is MediaMessage) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else 
    if (value is RemoteParticipantMessage) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else 
    if (value is RemoteParticipantMessage) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else 
    if (value is TrackMessage) {
      buffer.putUint8(133);
      writeValue(buffer, value.encode());
    } else 
{
      super.writeValue(buffer, value);
    }
  }
  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:       
        return LocalParticipantMessage.decode(readValue(buffer)!);
      
      case 129:       
        return MediaInfoMessage.decode(readValue(buffer)!);
      
      case 130:       
        return MediaMessage.decode(readValue(buffer)!);
      
      case 131:       
        return RemoteParticipantMessage.decode(readValue(buffer)!);
      
      case 132:       
        return RemoteParticipantMessage.decode(readValue(buffer)!);
      
      case 133:       
        return TrackMessage.decode(readValue(buffer)!);
      
      default:      
        return super.readValueOfType(type, buffer);
      
    }
  }
}
abstract class DailyCallback {
  static const MessageCodec<Object?> codec = _DailyCallbackCodec();

  void onParticipantsUpdated(LocalParticipantMessage localParticipantMessage, List<RemoteParticipantMessage?> remoteParticipantsMessage);
  void onParticipantUpdated(RemoteParticipantMessage remoteParticipantMessage);
  void onLocalParticipantUpdated(LocalParticipantMessage localParticipantMessage);
  void onParticipantJoined(RemoteParticipantMessage remoteParticipantMessage);
  void onParticipantLeft(RemoteParticipantMessage remoteParticipantMessage);
  void activeSpeakerChanged(RemoteParticipantMessage remoteParticipantMessage);
  void onCallStateUpdated(int stateCode);
  static void setup(DailyCallback? api, {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.DailyCallback.onParticipantsUpdated', codec, binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null, 'Argument for dev.flutter.pigeon.DailyCallback.onParticipantsUpdated was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final LocalParticipantMessage? arg_localParticipantMessage = (args[0] as LocalParticipantMessage?);
          assert(arg_localParticipantMessage != null, 'Argument for dev.flutter.pigeon.DailyCallback.onParticipantsUpdated was null, expected non-null LocalParticipantMessage.');
          final List<RemoteParticipantMessage?>? arg_remoteParticipantsMessage = (args[1] as List<Object?>?)?.cast<RemoteParticipantMessage?>();
          assert(arg_remoteParticipantsMessage != null, 'Argument for dev.flutter.pigeon.DailyCallback.onParticipantsUpdated was null, expected non-null List<RemoteParticipantMessage?>.');
          api.onParticipantsUpdated(arg_localParticipantMessage!, arg_remoteParticipantsMessage!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.DailyCallback.onParticipantUpdated', codec, binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null, 'Argument for dev.flutter.pigeon.DailyCallback.onParticipantUpdated was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final RemoteParticipantMessage? arg_remoteParticipantMessage = (args[0] as RemoteParticipantMessage?);
          assert(arg_remoteParticipantMessage != null, 'Argument for dev.flutter.pigeon.DailyCallback.onParticipantUpdated was null, expected non-null RemoteParticipantMessage.');
          api.onParticipantUpdated(arg_remoteParticipantMessage!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.DailyCallback.onLocalParticipantUpdated', codec, binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null, 'Argument for dev.flutter.pigeon.DailyCallback.onLocalParticipantUpdated was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final LocalParticipantMessage? arg_localParticipantMessage = (args[0] as LocalParticipantMessage?);
          assert(arg_localParticipantMessage != null, 'Argument for dev.flutter.pigeon.DailyCallback.onLocalParticipantUpdated was null, expected non-null LocalParticipantMessage.');
          api.onLocalParticipantUpdated(arg_localParticipantMessage!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.DailyCallback.onParticipantJoined', codec, binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null, 'Argument for dev.flutter.pigeon.DailyCallback.onParticipantJoined was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final RemoteParticipantMessage? arg_remoteParticipantMessage = (args[0] as RemoteParticipantMessage?);
          assert(arg_remoteParticipantMessage != null, 'Argument for dev.flutter.pigeon.DailyCallback.onParticipantJoined was null, expected non-null RemoteParticipantMessage.');
          api.onParticipantJoined(arg_remoteParticipantMessage!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.DailyCallback.onParticipantLeft', codec, binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null, 'Argument for dev.flutter.pigeon.DailyCallback.onParticipantLeft was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final RemoteParticipantMessage? arg_remoteParticipantMessage = (args[0] as RemoteParticipantMessage?);
          assert(arg_remoteParticipantMessage != null, 'Argument for dev.flutter.pigeon.DailyCallback.onParticipantLeft was null, expected non-null RemoteParticipantMessage.');
          api.onParticipantLeft(arg_remoteParticipantMessage!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.DailyCallback.activeSpeakerChanged', codec, binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null, 'Argument for dev.flutter.pigeon.DailyCallback.activeSpeakerChanged was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final RemoteParticipantMessage? arg_remoteParticipantMessage = (args[0] as RemoteParticipantMessage?);
          assert(arg_remoteParticipantMessage != null, 'Argument for dev.flutter.pigeon.DailyCallback.activeSpeakerChanged was null, expected non-null RemoteParticipantMessage.');
          api.activeSpeakerChanged(arg_remoteParticipantMessage!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.DailyCallback.onCallStateUpdated', codec, binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null, 'Argument for dev.flutter.pigeon.DailyCallback.onCallStateUpdated was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_stateCode = (args[0] as int?);
          assert(arg_stateCode != null, 'Argument for dev.flutter.pigeon.DailyCallback.onCallStateUpdated was null, expected non-null int.');
          api.onCallStateUpdated(arg_stateCode!);
          return;
        });
      }
    }
  }
}
