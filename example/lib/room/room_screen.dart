import 'package:daily_client_example/audio_video/av_cubit.dart';
import 'package:daily_client_example/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../audio_video/av_state.dart';
import 'widgets/participants_grid.dart';
import 'widgets/dock.dart';

class RoomScreen extends StatelessWidget {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AvCubit, AvState>(
      listener: (context, state) {
        if (state is AvLeftState) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.darkBackground,
        body: SafeArea(
          child: Center(
            child: Column(
              children: const [
                SizedBox(height: 16),
                Expanded(child: ParticipantsGrid()),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Dock(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
