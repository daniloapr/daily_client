import 'package:daily_client/daily_client.dart' as daily;
import 'package:daily_client_example/audio_video/av_cubit.dart';
import 'package:daily_client_example/audio_video/av_state.dart';
import 'package:daily_client_example/room/widgets/empty_room.dart';
import 'package:daily_client_example/room/widgets/video_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'fixed_grid.dart';

class ParticipantsGrid extends StatelessWidget {
  const ParticipantsGrid({super.key});

  static const double spacing = 16.0;

  @override
  Widget build(BuildContext context) {
    final remoteParticipants = context.select((AvCubit cubit) {
      final state = cubit.state;
      if (state is! AvConnectedState) return [];
      return state.remoteParticipants;
    });

    if (remoteParticipants.isEmpty) {
      return const EmptyRoom();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: spacing),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final height = constraints.maxHeight;
          final width = constraints.maxWidth;
          final isLandscape = width > height;
          final aspectRatio =
              remoteParticipants.length <= 1 ? width / height : 1.0;

          final int? crossAxisCount;
          final int? mainAxisCount;
          final axisCount = remoteParticipants.length <= 3 ? 1 : 2;

          if (isLandscape) {
            crossAxisCount = null;
            mainAxisCount = axisCount;
          } else {
            crossAxisCount = axisCount;
            mainAxisCount = null;
          }

          return FixedGrid(
            spacing: spacing,
            crossAxisCount: crossAxisCount,
            mainAxisCount: mainAxisCount,
            childAspectRatio: aspectRatio,
            children: remoteParticipants
                .map(
                  (participant) => VideoTile(participant: participant),
                )
                .toList(),
          );
        },
      ),
    );
  }
}