abstract class Participant {
  /// ID defined by the Daily server.
  final String id;

  /// ID defined by the client side.
  final String userId;
  final bool isCameraEnabled;
  final bool isMicrophoneEnabled;

  const Participant({
    required this.id,
    required this.userId,
    required this.isCameraEnabled,
    required this.isMicrophoneEnabled,
  });
}
