import 'package:daily_client/daily_client.dart';
import 'package:daily_client_example/room/room_screen.dart';
import 'package:flutter/material.dart';

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
  final _dailyClient = DailyClient();

  void _join(BuildContext context) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);
    try {
      await _dailyClient.join(
        JoinOptions(
          url: _urlController.text,
          token: _tokenController.text,
          enableCamera: false,
          enableMicrophone: false,
        ),
      );
      if (!mounted) return;
      _navigateToRoomScreen(context);
    } catch (e) {
      if (!mounted) return;
      final errorMessage =
          e is DailyClientException ? e.message : 'Something is wrong';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _navigateToRoomScreen(context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const RoomScreen(),
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
