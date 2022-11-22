import Flutter
import UIKit
import Daily

class DailyVideoRendererFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger
    private var call: Daily.CallClient
    
    init(
        messenger: FlutterBinaryMessenger,
        call: Daily.CallClient
    ) {
        self.messenger = messenger
        self.call = call
        super.init()
    }
    
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return DailyVideoRenderer(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger,
            call: call
        )
    }
    
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

class DailyVideoRenderer: NSObject, FlutterPlatformView {
    private var _view: UIView
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?,
        call: Daily.CallClient
    ) {
        let map = args as! [String: Any]
        let id = map["participantId"] as! String
        let isLocal = map["isLocal"] as! Bool
        let isScreenShare = map["isScreenShare"] as! Bool
        let videoScaleModeCode = map["videoScaleMode"] as! Int32
        let participant = getParticipant(
            participants: call.participants,
            participantId: id,
            isLocal: isLocal
        )
        
        let videoView = Daily.VideoView(frame: frame)
        
        if (isScreenShare) {
            if let track = participant?.media?.screenVideo.track {
                videoView.track = track
            }
        } else {
            if let track = participant?.media?.camera.track {
                videoView.track = track
            }
        }
        
        
        videoView.videoScaleMode = mapCodeToVideoScale(code: videoScaleModeCode)
        _view = videoView
        
        super.init()
    }
    
    func view() -> UIView {
        return _view
    }
}

private func getParticipant(
    participants: Participants,
    participantId id: String,
    isLocal: Bool
) -> Participant? {
    if (isLocal) {
        return participants.local
    }
    
    if let uuid = UUID(uuidString: id) {
        return participants.remote[ParticipantId(uuid: uuid)]
    } else {
        return nil
    }
}

private func mapCodeToVideoScale(code: Int32) -> Daily.VideoView.VideoScaleMode {
    switch code {
    case 0:
        return Daily.VideoView.VideoScaleMode.fit
    case 1:
        return Daily.VideoView.VideoScaleMode.fill
    default:
        return Daily.VideoView.VideoScaleMode.fit
    }
}
