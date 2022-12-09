import 'package:daily_client/daily_client.dart';

class DailyEvent {
  const DailyEvent();
}

class ParticipantUpdatedEvent extends DailyEvent {
  final RemoteParticipant remoteParticipant;

  const ParticipantUpdatedEvent(this.remoteParticipant);
}

class LocalParticipantUpdatedEvent extends DailyEvent {
  final LocalParticipant localParticipant;

  const LocalParticipantUpdatedEvent(this.localParticipant);
}

class ParticipantJoinedEvent extends DailyEvent {
  final RemoteParticipant remoteParticipant;

  const ParticipantJoinedEvent(this.remoteParticipant);
}

class ParticipantLeftEvent extends DailyEvent {
  final RemoteParticipant remoteParticipant;

  const ParticipantLeftEvent(this.remoteParticipant);
}
