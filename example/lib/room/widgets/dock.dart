import 'package:daily_client_example/audio_video/av_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../audio_video/av_cubit.dart';
import '../../core/colors.dart';

class Dock extends StatelessWidget {
  const Dock({super.key});

  ButtonStyle _setButtonStyle(Color color) {
    return ButtonStyle(
      backgroundColor:
          MaterialStateProperty.resolveWith<Color>((states) => color),
      shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
        (states) => const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
          (states) => EdgeInsets.zero),
      minimumSize: MaterialStateProperty.resolveWith<Size>(
          (states) => const Size(56, 56)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final defaultStyle = _setButtonStyle(AppColors.darkItemBgColor);
    const spacing = SizedBox(width: 24);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Builder(
              key: const Key('Toggle camera button'),
              builder: (context) {
                final isCameraEnabled = context.select(
                  (AvCubit cubit) => (cubit.state as AvConnectedState)
                      .localParticipant
                      .isCameraEnabled,
                );

                return TextButton(
                  style: defaultStyle,
                  onPressed: () => context.read<AvCubit>().toggleCamera(),
                  child: Icon(
                    isCameraEnabled ? Icons.videocam : Icons.videocam_off,
                    size: 32,
                    color: AppColors.darkForeground,
                  ),
                );
              },
            ),
            spacing,
            Builder(
              key: const Key('Toggle mic button'),
              builder: (context) {
                final isMicEnabled = context.select(
                  (AvCubit cubit) => (cubit.state as AvConnectedState)
                      .localParticipant
                      .isMicrophoneEnabled,
                );

                return TextButton(
                  style: defaultStyle,
                  onPressed: () => context.read<AvCubit>().toggleMic(),
                  child: Icon(
                    isMicEnabled ? Icons.mic : Icons.mic_off,
                    size: 32,
                    color: AppColors.darkForeground,
                  ),
                );
              },
            ),
            spacing,
            TextButton(
              key: const Key('Leave call button'),
              style: _setButtonStyle(AppColors.hangUpRed),
              onPressed: () => context.read<AvCubit>().leave(),
              child: const Icon(
                Icons.call_end,
                size: 32,
                color: AppColors.darkForeground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
