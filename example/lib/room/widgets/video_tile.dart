import 'package:daily_client/daily_client.dart' as daily;
import 'package:flutter/material.dart';

import '../../core/colors.dart';

class VideoTile extends StatelessWidget {
  const VideoTile({Key? key, required this.participant}) : super(key: key);

  final daily.Participant participant;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Card(
          key: const Key('Video'),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          margin: EdgeInsets.zero,
          color: AppColors.darkItemBgColor,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            child: Builder(builder: (context) {
              final isCameraEnabled = participant.isCameraEnabled;
              if (isCameraEnabled) {
                //TODO: implement daily.VideoRenderer
                return Container();

                // return daily.VideoRenderer(
                //   participant: participant,
                //   isScreenShare: false,
                // );
              }

              final isLocalParticipant = participant is daily.LocalParticipant;
              final placeholderSize = isLocalParticipant ? 40.0 : 60.0;

              return Center(
                child: Icon(
                  Icons.person,
                  size: placeholderSize,
                  color: AppColors.darkForeground,
                ),
              );
            }),
          ),
        )),
      ],
    );
  }
}
