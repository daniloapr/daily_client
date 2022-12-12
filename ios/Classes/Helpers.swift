import Daily

func getParticipantsMessage(
    fromParticipants participants: Daily.Participants
) -> (local: LocalParticipantMessage, remote: [RemoteParticipantMessage]) {
    let localParticipantMessage = mapLocalParticipantToMessage(fromParticipant: participants.local)
    
    print("DailyClient [getParticipantsMessage]: participants count = \(participants.remote.count) ")
    
    let remoteParticipantsMessage = participants.remote.map{ (participantMap) -> RemoteParticipantMessage in
        let participant = mapRemoteParticipantToMessage(fromParticipant: participantMap.value)
        printParticipant(participantMessage: participant)
        return participant
    }
    
    return (localParticipantMessage, remoteParticipantsMessage)
}

func mapLocalParticipantToMessage(fromParticipant participant: Daily.Participant) -> LocalParticipantMessage {
    return LocalParticipantMessage(
        id: participant.id.uuid.uuidString,
        userId: participant.info.userId ?? "",
        media: getMediaMessage(fromMedia: participant.media)
    )
}

func mapRemoteParticipantToMessage(fromParticipant participant: Daily.Participant) -> RemoteParticipantMessage {
    return RemoteParticipantMessage(
        id: participant.id.uuid.uuidString,
        userId: participant.info.userId ?? "",
        userName: participant.info.username ?? "",
        media: getMediaMessage(fromMedia: participant.media),
        joinedAtIsoString: Date.ISOStringFromDate(date: participant.info.joinedAt) ?? ""
    )
}

func printParticipant(participantMessage: RemoteParticipantMessage) {
    let cameraState = mapMediaStateMessageToString(mediaState: participantMessage.media?.camera.state)
    let micState = mapMediaStateMessageToString(mediaState: participantMessage.media?.microphone.state)
    let cameraTrackState = mapTrackStateMessageToString(trackState: participantMessage.media?.camera.subscribed)
    let micTrackState = mapTrackStateMessageToString(trackState: participantMessage.media?.microphone.subscribed)
    print("""
        DailyClient [participant]:
            id = \(participantMessage.id)
            userId = \(participantMessage.userId)
            name = \(participantMessage.userName)
            joinedAt = \(participantMessage.joinedAtIsoString)
            camera = \(cameraState), \(cameraTrackState)
            mic = \(micState), \(micTrackState)
    """
    )
}

func mapMediaStateMessageToString(mediaState: MediaStateMessage?) -> String {
    switch(mediaState){
    case .blocked:
        return "blocked"
    case .off:
        return "off"
    case .receivable:
        return "receivable"
    case .loading:
        return "loading"
    case .playable:
        return "playable"
    case .interrupted:
        return "interrupted"
    case .unknown:
        return "unknown"
    default:
        return "nil"
    }
}

func mapTrackStateMessageToString(trackState: TrackSubscriptionStateMessage?) -> String {
    switch(trackState) {
        
    case .subscribed:
        return "subscribed"
    case .staged:
        return "staged"
    case .unsubscribed:
        return "unsubscribed"
    case .unknown:
        return "unknown"
    default:
        return "nil"
    }
}

func mapCallStateToCode(callState: Daily.CallState) -> Int32 {
    switch callState {
    case .initialized:
        return 0
    case .joining:
        return 1
    case .joined:
        return 2
    case .leaving:
        return 3
    case .left:
        return 4
    @unknown default:
        return -1
    }
}

private func getMediaMessage(fromMedia media: Daily.ParticipantMedia?) -> MediaMessage? {
    if let media {
        return MediaMessage(
            camera: getVideoMediaInfoMessage(fromVideoInfo: media.camera),
            microphone: getAudioMediaInfoMessage(fromAudioInfo: media.microphone),
            screenVideo: getVideoMediaInfoMessage(fromVideoInfo: media.screenVideo),
            screenAudio: getAudioMediaInfoMessage(fromAudioInfo: media.screenAudio)
        )
    }
    
    return nil
}

private func getVideoMediaInfoMessage(fromVideoInfo info: Daily.ParticipantVideoInfo) -> MediaInfoMessage {
    return MediaInfoMessage(
        state: mapMediaStateToMessage(mediaState: info.state),
        subscribed: mapTrackSubscriptionStateToMessage(subscriptionState: info.subscribed),
        track: TrackMessage(id: info.track?.id ?? "", isEnabled: info.track?.isEnabled ?? false)
    )
}

private func getAudioMediaInfoMessage(fromAudioInfo info: Daily.ParticipantAudioInfo) -> MediaInfoMessage {
    return MediaInfoMessage(
        state: mapMediaStateToMessage(mediaState: info.state),
        subscribed: mapTrackSubscriptionStateToMessage(subscriptionState: info.subscribed),
        track: TrackMessage(id: info.track?.id ?? "", isEnabled: info.track?.isEnabled ?? false)
    )
}

private func mapMediaStateToMessage(mediaState: Daily.MediaState) -> MediaStateMessage {
    switch mediaState {
        
    case .blocked:
        return .blocked
    case .off:
        return .off
    case .receivable:
        return .receivable
    case .loading:
        return .loading
    case .playable:
        return .playable
    case .interrupted:
        return .interrupted
    @unknown default:
        return .unknown
    }
}

private func mapTrackSubscriptionStateToMessage(subscriptionState: Daily.TrackSubscriptionState) -> TrackSubscriptionStateMessage{
    switch subscriptionState {
        
    case .subscribed:
        return .subscribed
    case .staged:
        return .staged
    case .unsubscribed:
        return .unsubscribed
    @unknown default:
        return .unknown
    }
}
