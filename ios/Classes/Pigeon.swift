// Autogenerated from Pigeon (v4.2.5), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation
#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#else
#error("Unsupported platform.")
#endif


/// Generated class from Pigeon.

enum ErrorCode: Int {
  case invalidUrl = 0
  case join = 1
  case updateCamera = 2
  case updateMicrophone = 3
}

enum TrackSubscriptionStateMessage: Int {
  case subscribed = 0
  case staged = 1
  case unsubscribed = 2
  case unknown = 3
}

enum MediaStateMessage: Int {
  case blocked = 0
  case off = 1
  case receivable = 2
  case loading = 3
  case playable = 4
  case interrupted = 5
  case unknown = 6
}

///Generated class from Pigeon that represents data sent in messages.
struct VoidResult {
  var error: PlatformError? = nil

  static func fromMap(_ map: [String: Any?]) -> VoidResult? {
    var error: PlatformError? = nil
    if let errorMap = map["error"] as? [String: Any?] {
      error = PlatformError.fromMap(errorMap)
    }

    return VoidResult(
      error: error
    )
  }
  func toMap() -> [String: Any?] {
    return [
      "error": error?.toMap()
    ]
  }
}

///Generated class from Pigeon that represents data sent in messages.
struct PlatformError {
  var message: String
  var code: ErrorCode

  static func fromMap(_ map: [String: Any?]) -> PlatformError? {
    let message = map["message"] as! String
    let code = ErrorCode(rawValue: map["code"] as! Int)!

    return PlatformError(
      message: message,
      code: code
    )
  }
  func toMap() -> [String: Any?] {
    return [
      "message": message,
      "code": code.rawValue
    ]
  }
}

///Generated class from Pigeon that represents data sent in messages.
struct JoinArgs {
  var url: String
  var token: String
  var enableMicrophone: Bool
  var enableCamera: Bool

  static func fromMap(_ map: [String: Any?]) -> JoinArgs? {
    let url = map["url"] as! String
    let token = map["token"] as! String
    let enableMicrophone = map["enableMicrophone"] as! Bool
    let enableCamera = map["enableCamera"] as! Bool

    return JoinArgs(
      url: url,
      token: token,
      enableMicrophone: enableMicrophone,
      enableCamera: enableCamera
    )
  }
  func toMap() -> [String: Any?] {
    return [
      "url": url,
      "token": token,
      "enableMicrophone": enableMicrophone,
      "enableCamera": enableCamera
    ]
  }
}

/// Returning class from join() function
///
///Generated class from Pigeon that represents data sent in messages.
struct JoinMessage {
  var localParticipant: LocalParticipantMessage? = nil
  var remoteParticipants: [RemoteParticipantMessage?]? = nil
  var error: PlatformError? = nil

  static func fromMap(_ map: [String: Any?]) -> JoinMessage? {
    var localParticipant: LocalParticipantMessage? = nil
    if let localParticipantMap = map["localParticipant"] as? [String: Any?] {
      localParticipant = LocalParticipantMessage.fromMap(localParticipantMap)
    }
    let remoteParticipants = map["remoteParticipants"] as? [RemoteParticipantMessage?] 
    var error: PlatformError? = nil
    if let errorMap = map["error"] as? [String: Any?] {
      error = PlatformError.fromMap(errorMap)
    }

    return JoinMessage(
      localParticipant: localParticipant,
      remoteParticipants: remoteParticipants,
      error: error
    )
  }
  func toMap() -> [String: Any?] {
    return [
      "localParticipant": localParticipant?.toMap(),
      "remoteParticipants": remoteParticipants,
      "error": error?.toMap()
    ]
  }
}

///Generated class from Pigeon that represents data sent in messages.
struct LocalParticipantMessage {
  var id: String
  var isCameraEnabled: Bool
  var isMicrophoneEnabled: Bool
  var userId: String
  var media: MediaMessage? = nil

  static func fromMap(_ map: [String: Any?]) -> LocalParticipantMessage? {
    let id = map["id"] as! String
    let isCameraEnabled = map["isCameraEnabled"] as! Bool
    let isMicrophoneEnabled = map["isMicrophoneEnabled"] as! Bool
    let userId = map["userId"] as! String
    var media: MediaMessage? = nil
    if let mediaMap = map["media"] as? [String: Any?] {
      media = MediaMessage.fromMap(mediaMap)
    }

    return LocalParticipantMessage(
      id: id,
      isCameraEnabled: isCameraEnabled,
      isMicrophoneEnabled: isMicrophoneEnabled,
      userId: userId,
      media: media
    )
  }
  func toMap() -> [String: Any?] {
    return [
      "id": id,
      "isCameraEnabled": isCameraEnabled,
      "isMicrophoneEnabled": isMicrophoneEnabled,
      "userId": userId,
      "media": media?.toMap()
    ]
  }
}

///Generated class from Pigeon that represents data sent in messages.
struct RemoteParticipantMessage {
  var id: String
  var isCameraEnabled: Bool
  var isMicrophoneEnabled: Bool
  var userId: String
  var media: MediaMessage? = nil

  static func fromMap(_ map: [String: Any?]) -> RemoteParticipantMessage? {
    let id = map["id"] as! String
    let isCameraEnabled = map["isCameraEnabled"] as! Bool
    let isMicrophoneEnabled = map["isMicrophoneEnabled"] as! Bool
    let userId = map["userId"] as! String
    var media: MediaMessage? = nil
    if let mediaMap = map["media"] as? [String: Any?] {
      media = MediaMessage.fromMap(mediaMap)
    }

    return RemoteParticipantMessage(
      id: id,
      isCameraEnabled: isCameraEnabled,
      isMicrophoneEnabled: isMicrophoneEnabled,
      userId: userId,
      media: media
    )
  }
  func toMap() -> [String: Any?] {
    return [
      "id": id,
      "isCameraEnabled": isCameraEnabled,
      "isMicrophoneEnabled": isMicrophoneEnabled,
      "userId": userId,
      "media": media?.toMap()
    ]
  }
}

///Generated class from Pigeon that represents data sent in messages.
struct MediaMessage {
  var camera: MediaInfoMessage
  var microphone: MediaInfoMessage
  var screenVideo: MediaInfoMessage
  var screenAudio: MediaInfoMessage

  static func fromMap(_ map: [String: Any?]) -> MediaMessage? {
    let camera = MediaInfoMessage.fromMap(map["camera"] as! [String: Any?])!
    let microphone = MediaInfoMessage.fromMap(map["microphone"] as! [String: Any?])!
    let screenVideo = MediaInfoMessage.fromMap(map["screenVideo"] as! [String: Any?])!
    let screenAudio = MediaInfoMessage.fromMap(map["screenAudio"] as! [String: Any?])!

    return MediaMessage(
      camera: camera,
      microphone: microphone,
      screenVideo: screenVideo,
      screenAudio: screenAudio
    )
  }
  func toMap() -> [String: Any?] {
    return [
      "camera": camera.toMap(),
      "microphone": microphone.toMap(),
      "screenVideo": screenVideo.toMap(),
      "screenAudio": screenAudio.toMap()
    ]
  }
}

///Generated class from Pigeon that represents data sent in messages.
struct MediaInfoMessage {
  var state: MediaStateMessage
  var subscribed: TrackSubscriptionStateMessage
  var track: TrackMessage? = nil

  static func fromMap(_ map: [String: Any?]) -> MediaInfoMessage? {
    let state = MediaStateMessage(rawValue: map["state"] as! Int)!
    let subscribed = TrackSubscriptionStateMessage(rawValue: map["subscribed"] as! Int)!
    var track: TrackMessage? = nil
    if let trackMap = map["track"] as? [String: Any?] {
      track = TrackMessage.fromMap(trackMap)
    }

    return MediaInfoMessage(
      state: state,
      subscribed: subscribed,
      track: track
    )
  }
  func toMap() -> [String: Any?] {
    return [
      "state": state.rawValue,
      "subscribed": subscribed.rawValue,
      "track": track?.toMap()
    ]
  }
}

///Generated class from Pigeon that represents data sent in messages.
struct TrackMessage {
  var id: String
  var isEnabled: Bool

  static func fromMap(_ map: [String: Any?]) -> TrackMessage? {
    let id = map["id"] as! String
    let isEnabled = map["isEnabled"] as! Bool

    return TrackMessage(
      id: id,
      isEnabled: isEnabled
    )
  }
  func toMap() -> [String: Any?] {
    return [
      "id": id,
      "isEnabled": isEnabled
    ]
  }
}

private class DailyMessengerCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
      case 128:
        return JoinArgs.fromMap(self.readValue() as! [String: Any])      
      case 129:
        return JoinMessage.fromMap(self.readValue() as! [String: Any])      
      case 130:
        return LocalParticipantMessage.fromMap(self.readValue() as! [String: Any])      
      case 131:
        return MediaInfoMessage.fromMap(self.readValue() as! [String: Any])      
      case 132:
        return MediaMessage.fromMap(self.readValue() as! [String: Any])      
      case 133:
        return PlatformError.fromMap(self.readValue() as! [String: Any])      
      case 134:
        return RemoteParticipantMessage.fromMap(self.readValue() as! [String: Any])      
      case 135:
        return TrackMessage.fromMap(self.readValue() as! [String: Any])      
      case 136:
        return VoidResult.fromMap(self.readValue() as! [String: Any])      
      default:
        return super.readValue(ofType: type)
      
    }
  }
}
private class DailyMessengerCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? JoinArgs {
      super.writeByte(128)
      super.writeValue(value.toMap())
    } else if let value = value as? JoinMessage {
      super.writeByte(129)
      super.writeValue(value.toMap())
    } else if let value = value as? LocalParticipantMessage {
      super.writeByte(130)
      super.writeValue(value.toMap())
    } else if let value = value as? MediaInfoMessage {
      super.writeByte(131)
      super.writeValue(value.toMap())
    } else if let value = value as? MediaMessage {
      super.writeByte(132)
      super.writeValue(value.toMap())
    } else if let value = value as? PlatformError {
      super.writeByte(133)
      super.writeValue(value.toMap())
    } else if let value = value as? RemoteParticipantMessage {
      super.writeByte(134)
      super.writeValue(value.toMap())
    } else if let value = value as? TrackMessage {
      super.writeByte(135)
      super.writeValue(value.toMap())
    } else if let value = value as? VoidResult {
      super.writeByte(136)
      super.writeValue(value.toMap())
    } else {
      super.writeValue(value)
    }
  }
}

private class DailyMessengerCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return DailyMessengerCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return DailyMessengerCodecWriter(data: data)
  }
}

class DailyMessengerCodec: FlutterStandardMessageCodec {
  static let shared = DailyMessengerCodec(readerWriter: DailyMessengerCodecReaderWriter())
}

/// This is the base class of communication with native code.
/// It's used for generating the Pigeon files
///
///Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol DailyMessenger {
  /// Join Daily call.
  func join(args: JoinArgs, completion: @escaping (JoinMessage) -> Void)
  /// Leave Daily call.
  func leave() -> VoidResult
  func setMicrophoneEnabled(enableMic: Bool) -> VoidResult
  func setCameraEnabled(enableCam: Bool) -> VoidResult
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class DailyMessengerSetup {
  /// The codec used by DailyMessenger.
  static var codec: FlutterStandardMessageCodec { DailyMessengerCodec.shared }
  /// Sets up an instance of `DailyMessenger` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: DailyMessenger?) {
    /// Join Daily call.
    let joinChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.DailyMessenger.join", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      joinChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let argsArg = args[0] as! JoinArgs
        api.join(args: argsArg) { result in
          reply(wrapResult(result))
        }
      }
    } else {
      joinChannel.setMessageHandler(nil)
    }
    /// Leave Daily call.
    let leaveChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.DailyMessenger.leave", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      leaveChannel.setMessageHandler { _, reply in
        let result = api.leave()
        reply(wrapResult(result))
      }
    } else {
      leaveChannel.setMessageHandler(nil)
    }
    let setMicrophoneEnabledChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.DailyMessenger.setMicrophoneEnabled", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setMicrophoneEnabledChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let enableMicArg = args[0] as! Bool
        let result = api.setMicrophoneEnabled(enableMic: enableMicArg)
        reply(wrapResult(result))
      }
    } else {
      setMicrophoneEnabledChannel.setMessageHandler(nil)
    }
    let setCameraEnabledChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.DailyMessenger.setCameraEnabled", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setCameraEnabledChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let enableCamArg = args[0] as! Bool
        let result = api.setCameraEnabled(enableCam: enableCamArg)
        reply(wrapResult(result))
      }
    } else {
      setCameraEnabledChannel.setMessageHandler(nil)
    }
  }
}
private class DailyCallbackCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
      case 128:
        return LocalParticipantMessage.fromMap(self.readValue() as! [String: Any])      
      case 129:
        return MediaInfoMessage.fromMap(self.readValue() as! [String: Any])      
      case 130:
        return MediaMessage.fromMap(self.readValue() as! [String: Any])      
      case 131:
        return RemoteParticipantMessage.fromMap(self.readValue() as! [String: Any])      
      case 132:
        return TrackMessage.fromMap(self.readValue() as! [String: Any])      
      default:
        return super.readValue(ofType: type)
      
    }
  }
}
private class DailyCallbackCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? LocalParticipantMessage {
      super.writeByte(128)
      super.writeValue(value.toMap())
    } else if let value = value as? MediaInfoMessage {
      super.writeByte(129)
      super.writeValue(value.toMap())
    } else if let value = value as? MediaMessage {
      super.writeByte(130)
      super.writeValue(value.toMap())
    } else if let value = value as? RemoteParticipantMessage {
      super.writeByte(131)
      super.writeValue(value.toMap())
    } else if let value = value as? TrackMessage {
      super.writeByte(132)
      super.writeValue(value.toMap())
    } else {
      super.writeValue(value)
    }
  }
}

private class DailyCallbackCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return DailyCallbackCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return DailyCallbackCodecWriter(data: data)
  }
}

class DailyCallbackCodec: FlutterStandardMessageCodec {
  static let shared = DailyCallbackCodec(readerWriter: DailyCallbackCodecReaderWriter())
}

///Generated class from Pigeon that represents Flutter messages that can be called from Swift.
class DailyCallback {
  private let binaryMessenger: FlutterBinaryMessenger
  init(binaryMessenger: FlutterBinaryMessenger){
    self.binaryMessenger = binaryMessenger
  }
  var codec: FlutterStandardMessageCodec {
    return DailyCallbackCodec.shared
  }
  func onParticipantsUpdated(localParticipantMessage localParticipantMessageArg: LocalParticipantMessage, remoteParticipantsMessage remoteParticipantsMessageArg: [RemoteParticipantMessage?], completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.DailyCallback.onParticipantsUpdated", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([localParticipantMessageArg, remoteParticipantsMessageArg]) { _ in
      completion()
    }
  }
  func onCallStateUpdated(stateCode stateCodeArg: Int32, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.DailyCallback.onCallStateUpdated", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([stateCodeArg]) { _ in
      completion()
    }
  }
}

private func wrapResult(_ result: Any?) -> [String: Any?] {
  return ["result": result]
}

private func wrapError(_ error: FlutterError) -> [String: Any?] {
  return [
    "error": [
      "code": error.code,
      "message": error.message,
      "details": error.details
    ]
  ]
}
