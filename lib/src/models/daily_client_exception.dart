abstract class DailyClientException implements Exception {
  const DailyClientException(this.message);
  final String message;
}

class DailyJoinException implements DailyClientException {
  @override
  String get message => 'Unable to join the call';
}

class DailyInvalidUrlException implements DailyClientException {
  @override
  String get message => 'Invalid url';
}
