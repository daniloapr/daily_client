# daily_client

A Flutter plugin for the [Daily mobile SDK](https://docs.daily.co/guides/products/mobile).

This plugin is currently under development. There may be some missing features compared to the mobile SDKs. PRs are welcome.

Note that the Daily mobile SDKs are still in Beta for both Android and iOS. Thus, it's not recommended for using in production apps.

## Minimum OS version
iOS >= 13.0
Android: `minSdkVersion` >= 24 

## Getting started

### Setting up the call client

## iOS
### Add values to the Info.plist

```xml
<key>NSMicrophoneUsageDescription</key>
<string>Daily example uses the microphone on a call</string>
<key>NSCameraUsageDescription</key>
<string>Daily example uses the camera on a call</string>
```

## Example app

To run the example app:

1. Install Flutter
2. Run `flutter pub get` to update the dependencies
3. Run `make` to generate the Pigeon file
4. `cd example` and then `flutter run` to 

If you are running on iOS from a Mac with Apple Silicon, enter the `example/ios` and run `make` to run the `pod_install` and update the native dependencies.
