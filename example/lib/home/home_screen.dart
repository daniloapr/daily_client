import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:daily_client/daily_client.dart' as daily;

import 'package:daily_client_example/audio_video/av_cubit.dart';
import 'package:daily_client_example/dependencies.dart';
import 'package:daily_client_example/room/room_screen.dart';

import '../core/subscription_profiles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _urlController = TextEditingController();
  final _tokenController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _enableCamera = false;
  bool _enabledMicrophone = false;

  final _dailyClient = getIt<daily.DailyClient>();

  void _join(BuildContext context) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);
    try {
      // final profiles =
      //     SubscriptionProfiles.values.map((e) => e.settings).toList();
      // await _dailyClient.updateSubscriptionProfiles(profiles);

      final result = await _dailyClient.join(
        daily.JoinOptions(
          url: _urlController.text,
          token: _tokenController.text,
          enableCamera: _enableCamera,
          enableMicrophone: _enabledMicrophone,
        ),
      );
      if (!mounted) return;

      _navigateToRoomScreen(
        context,
        result.localParticipant,
        result.remoteParticipants,
      );
    } catch (e) {
      if (!mounted) return;
      final errorMessage =
          e is daily.DailyClientException ? e.message : 'Something is wrong';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _navigateToRoomScreen(
    BuildContext context,
    daily.LocalParticipant localParticipant,
    List<daily.RemoteParticipant> remoteParticipants,
  ) async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => AvCubit(
          localParticipant: localParticipant,
          remoteParticipants: remoteParticipants,
        ),
        child: const RoomScreen(),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                key: const Key('Url form'),
                controller: _urlController,
                decoration: const InputDecoration(
                  labelText: 'URL',
                  border: OutlineInputBorder(),
                ),
                autocorrect: false,
                autofocus: true,
                keyboardType: TextInputType.url,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter URL';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              key: const Key('Token form'),
              controller: _tokenController,
              decoration: const InputDecoration(
                labelText: 'Token',
                border: OutlineInputBorder(),
              ),
              autocorrect: false,
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              value: _enableCamera,
              title: const Text('Enable camera'),
              onChanged: ((value) {
                setState(() => _enableCamera = value);
              }),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              value: _enabledMicrophone,
              title: const Text('Enable microphone'),
              onChanged: ((value) {
                setState(() => _enabledMicrophone = value);
              }),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : () => _join(context),
              child: const Text('Join'),
            ),
          ],
        ),
      ),
    );
  }
}
