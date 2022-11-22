import 'package:daily_client_example/audio_video/av_cubit.dart';
import 'package:daily_client_example/audio_video/av_state.dart';
import 'package:daily_client_example/room/widgets/video_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalVideo extends StatelessWidget {
  const LocalVideo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvCubit, AvState>(
      buildWhen: (previous, current) {
        if (previous is AvConnectedState && current is AvConnectedState) {
          return previous.localParticipant.isCameraEnabled !=
              current.localParticipant.isCameraEnabled;
        }

        return true;
      },
      builder: (context, state) {
        if (state is! AvConnectedState) return Container();
        final localParticipant = state.localParticipant;

        return Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 28.0, bottom: 100.0),
            child: SizedBox(
              height: 128,
              width: 96,
              child: VideoTile(
                participant: localParticipant,
                isScreenShare: false,
              ),
            ),
          ),
        );
      },
    );
  }
}
