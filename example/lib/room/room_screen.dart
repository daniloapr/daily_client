import 'package:flutter/material.dart';

import 'package:daily_client_example/room/widgets/dock.dart';
import 'package:daily_client_example/room/widgets/participants_grid.dart';

class RoomScreen extends StatelessWidget {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: const [
            ParticipantsGrid(),
            Dock(),
          ],
        ),
      ),
    );
  }
}
