abstract class DailyClientException implements Exception {
  const DailyClientException(this.message);
  final String message;
}

class DailyJoinException implements DailyClientException {
  @override
  String get message => 'Unable to join the call';
}

class DailyNullParticipantsException implements DailyClientException {
  @override
  String get message => 'Unable to join the call. Participants fields are null';
}

class DailyInvalidUrlException implements DailyClientException {
  @override
  String get message => 'Invalid url';
}

class DailyUpdateCameraException implements DailyClientException {
  @override
  String get message => 'Unable to update the camera url';
}

class DailyUpdateMicException implements DailyClientException {
  @override
  String get message => 'Unable to update the microphone url';
}
