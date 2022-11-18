import 'package:flutter/material.dart';

class EmptyRoom extends StatelessWidget {
  const EmptyRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          'You are the only one here',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
