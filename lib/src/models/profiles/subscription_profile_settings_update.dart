class SubscriptionProfileSettingsUpdate {
  /// Simplified settings for subscription profiles
  const SubscriptionProfileSettingsUpdate({
    required this.name,
    required this.subscribeCamera,
    required this.subscribeMicrophone,
  });

  /// Profile name. The default profile is "base"
  final String name;
  final bool subscribeCamera;
  final bool subscribeMicrophone;
}
