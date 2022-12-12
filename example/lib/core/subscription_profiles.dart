import 'package:daily_client/daily_client.dart';

enum SubscriptionProfiles {
  base(
    SubscriptionProfileSettingsUpdate(
      name: 'base',
      //Hack: only participants with camera subscribed are returned in call.participants.remote
      subscribeCamera: false,
      subscribeMicrophone: false,
    ),
  ),
  visible(
    SubscriptionProfileSettingsUpdate(
      name: 'visible',
      subscribeCamera: true,
      subscribeMicrophone: true,
    ),
  ),
  invisible(
    SubscriptionProfileSettingsUpdate(
      name: 'invisible',
      subscribeCamera: false,
      subscribeMicrophone: true,
    ),
  );

  const SubscriptionProfiles(this.settings);

  final SubscriptionProfileSettingsUpdate settings;
}
