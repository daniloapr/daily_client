class JoinOptions {
  final String url;
  final String token;
  final bool enableCamera;
  final bool enableMicrophone;
  final bool autoSubscribe;

  JoinOptions({
    required this.url,
    this.token = '',
    this.enableCamera = false,
    this.enableMicrophone = false,
    this.autoSubscribe = true,
  });
}
