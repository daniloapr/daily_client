import 'package:daily_client/daily_client.dart';

class DailyEvent {
  const DailyEvent();
}

class ParticipantUpdatedEvent extends DailyEvent {
  const ParticipantUpdatedEvent(this.remoteParticipant);

  final RemoteParticipant remoteParticipant;
}

class LocalParticipantUpdatedEvent extends DailyEvent {
  const LocalParticipantUpdatedEvent(this.localParticipant);

  final LocalParticipant localParticipant;
}

class ParticipantJoinedEvent extends DailyEvent {
  const ParticipantJoinedEvent(this.remoteParticipant);

  final RemoteParticipant remoteParticipant;
}

class ParticipantLeftEvent extends DailyEvent {
  const ParticipantLeftEvent(this.remoteParticipant);

  final RemoteParticipant remoteParticipant;
}

class ActiveSpeakerChangedEvent extends DailyEvent {
  const ActiveSpeakerChangedEvent(this.remoteParticipant);

  final RemoteParticipant? remoteParticipant;
}
