# daily_client

A Flutter plugin for the [Daily mobile SDK](https://docs.daily.co/guides/products/mobile).

This plugin is currently under development. There may be some missing features compared to the mobile SDKs. PRs are welcome.

Note that the Daily mobile SDKs are still in Beta for both Android and iOS. Thus, it's not recommended for using in production apps.

Prefer running in a real device instead of emulators.

:warning: This plugin is depending on an unstable and not fully tested version of Daily iOS SDK, so, you should expect some crashes. It will be updated as soon as Daily releases the next SDK version 0.6.0.

## Minimum OS version

iOS >= 13.0

Android: Not supported yet.

## Getting started

### Joining a call

To get an URL for testing your app, create your account at [daily.co](daily.co), then create a room in the [dashboard](https://dashboard.daily.co/). Public room's don't require token, so you should avoid them in production.

```dart
// Import the package
import 'package:daily_client/daily_client.dart' as daily;

// Instantiate the DailyClient
final _dailyClient = daily.DailyClient();

// Join the call
try {
    final result = await _dailyClient.join(
        url: url,
        token: token, // Can be empty
        enableCamera: true,
        enableMicrophone: true,
    );
    print(result.localParticipant);
    print(result.remoteParticipants);
} on daily.DailyClientException catch (e) {
    print(e.message);
}
```

### Leave the call

```dart
await _dailyClient.leave();
```

### Events

This plugin uses streams to inform about changes in the call. You can listen to them _before_ the `join()` method.

```dart
import 'package:daily_client/daily_client.dart' as daily;

StreamSubscription? _eventsSubscription;
StreamSubscription? _callStateSubscription;
// Start listeners before `join()`
_startListeners();

void _startListeners() {
    _eventsSubscription = _dailyClient.events.listen((event) {
        if (event is daily.ParticipantJoinedEvent) {
        _onParticipantJoined(event.remoteParticipant);
        }
        if (event is daily.ParticipantLeftEvent) {
        _onParticipantLeft(event.remoteParticipant);
        }
        if (event is daily.ParticipantUpdatedEvent) {
        _onParticipantUpdated(event.remoteParticipant);
        }
        if (event is daily.LocalParticipantUpdatedEvent) {
        _onLocalParticipantUpdated(event.localParticipant);
        }
        if (event is daily.ActiveSpeakerChangedEvent) {
        _onActiveSpeakerChanged(event.remoteParticipant);
        }
    });

    _callStateSubscription = _dailyClient.callState.listen(_onCallStateChanged);
}

void dispose(){
    _eventsSubscription?.cancel();
    _callStateSubscription?.cancel();
}
```

### Toggle camera and microphone

```dart
    await _dailyClient.setMicrophoneEnabled(true);
    await _dailyClient.setCameraEnabled(true);

    // You should receive a [LocalParticipantUpdatedEvent] after each change. Use it to update the local participant state.
```

### Video widget

To show the participants video, use the `VideoRenderer` widget with the `Participant` as argument.

```dart
@override
Widget build(BuildContext context) {
    return VideoRenderer(
        participant: participant, //local or remote
        isScreenShare: false, // false for camera, true for screen share video
        videoScaleMode: daily.VideoScaleMode.fill,
    );
}
```

### Participants subscription

The participants subscriptions are handled by Daily using profiles. They allow us to define manually whether we should subscribe to video and/or audio. For example: you can subscribe to audio and video for all the visible participants, and keep the other participants who are not in the screen with audio only, to save some resources.

By the default, the `base` profile subscribe to both audio and video, so you shouldn't worry with that in your first implementation.

#### Creating or updating the subscription profiles

```dart
await _dailyClient.updateSubscriptionProfiles(const [
    daily.SubscriptionProfileSettingsUpdate(
        name: 'visible',
        subscribeCamera: true,
        subscribeMicrophone: true,
    ),
    daily.SubscriptionProfileSettingsUpdate(
        name: 'invisible',
        subscribeCamera: false,
        subscribeMicrophone: true,
    ),
    // Here we are overriding the base profile to NOT subscribe by default
    daily.SubscriptionProfileSettingsUpdate(
        name: 'base',
        subscribeCamera: false,
        subscribeMicrophone: false,
    ),
]);
```

#### Assigning participants to a profile

```dart
void _onParticipantJoined(daily.RemoteParticipant participant) {
    // This is setting the `visible` profile as default. It's not necessary
    // unless you need to handle custom subscriptions.
    _dailyClient.updateSubscriptions([
        daily.UpdateSubscriptionOptions(
        participantId: participant.id,
        profileName: SubscriptionProfiles.visible.name,
        )
    ]);
}

```

## iOS

Add these values to the `info.plist`:

```xml
<key>NSMicrophoneUsageDescription</key>
<string>Daily example uses the microphone on a call</string>
<key>NSCameraUsageDescription</key>
<string>Daily example uses the camera on a call</string>
```

## Android

In progress

## Example app

To run the example app:

1. Install Flutter
2. Run `flutter pub get` to update the dependencies
3. Run `make` to generate the Pigeon file
4. `cd example` and then `flutter run` to

If you are running on iOS from a Mac with Apple Silicon, enter the `example/ios` and run `make` to run the `pod_install` and update the native dependencies.
