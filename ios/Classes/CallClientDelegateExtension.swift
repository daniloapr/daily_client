import Daily

extension SwiftDailyClientPlugin: CallClientDelegate {
    
    /// The call state changed, normally as a consequence of invocations to
    /// `CallClient.join()` or `CallClient.leave()`.
    public func callClient(_ callClient: Daily.CallClient, callStateUpdated state: Daily.CallState) {
        let code = mapCallStateToCode(callState: state)
        self.callback.onCallStateUpdated(
            stateCode: code,
            completion: {}
        )
    }
    
    /// The input settings are updated, normally as a consequence of invocations to
    /// `CallClient.join()`, `CallClient.updateInputs()` or `CallClient.updatePublishing()`.
    public func callClient(_ callClient: Daily.CallClient, inputsUpdated inputs: Daily.InputSettings) {}
    
    /// The publishing settings are updated, normally as a consequence of invocations to
    /// `CallClient.join()` or `CallClient.updatePublishing()`.
    public func callClient(_ callClient: Daily.CallClient, publishingUpdated publishing: Daily.PublishingSettings) {
        print("DailyClient: publishingUpdated")
    }
    
    /// A participant has joined the call.
    @MainActor public func callClient(_ callClient: Daily.CallClient, participantJoined participant: Daily.Participant) {
        self.onParticipantJoined(participant: participant)
//        self.onParticipantsUpdated()
    }
    
    /// A participant was updated, normally as a consequence of
    /// a participant's metadata getting updated, or its tracks changing.
    @MainActor public func callClient(_ callClient: Daily.CallClient, participantUpdated participant: Daily.Participant) {
        self.onParticipantUpdated(participant: participant)
//        self.onParticipantsUpdated()
    }
    
    /// A participant has left the call.
    @MainActor public func callClient(
        _ callClient: Daily.CallClient,
        participantLeft participant: Daily.Participant,
        withReason reason: Daily.ParticipantLeftReason
    ) {
        self.onParticipantLeft(participant: participant)
//        self.onParticipantsUpdated()
    }
    
    /// The active speaker has changed.
    @MainActor public func callClient(_ callClient: Daily.CallClient, activeSpeakerChanged activeSpeaker: Daily.Participant?) {
        self.onActiveSpeakerChanged(participant: activeSpeaker)
//        self.onParticipantsUpdated()
    }
    
    /// The subscription settings are updated, as a consequence of invocations to
    /// `CallClient.updateSubscriptions()`.
    public func callClient(_ callClient: Daily.CallClient, subscriptionsUpdated subscriptions: Daily.SubscriptionSettingsById) {
        print("DailyClient: subscriptionsUpdated")
    }
    
    /// The subscription profile settings are updated, as a consequence of invocations to
    /// `CallClient.updateSubscriptionProfiles()`.
    public func callClient(_ callClient: Daily.CallClient, subscriptionProfilesUpdated subscriptionProfiles: Daily.SubscriptionProfileSettingsByProfile) {
        print("DailyClient: subscriptionProfilesUpdated")
    }
    
    /// An audio device is plugged or unplugged.
    public func callClient(_ callClient: Daily.CallClient, availableDevicesUpdated availableDevices: Daily.Devices) {
        print("DailyClient: availableDevicesUpdated")
    }
    
    /// An error occurred.
    public func callClient(_ callClient: Daily.CallClient, error: Daily.CallClientError) {
        print("DailyClientError: \(error.localizedDescription)")
    }
}
