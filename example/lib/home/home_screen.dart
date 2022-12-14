import 'package:daily_client_example/audio_video/av_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../audio_video/av_cubit.dart';
import '../room/room_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _urlController = TextEditingController();
  final _tokenController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _enableCamera = false;
  bool _enableMicrophone = false;

  void _join(BuildContext context) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    context.read<AvCubit>().join(
          url: _urlController.text,
          token: _tokenController.text,
          enableCamera: _enableCamera,
          enableMicrophone: _enableMicrophone,
        );
  }

  Future<void> _navigateToRoomScreen(BuildContext context) async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: context.read<AvCubit>(),
        child: const RoomScreen(),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AvCubit>(
      create: (context) => AvCubit(),
      child: BlocConsumer<AvCubit, AvState>(
        listenWhen: (previous, current) =>
            previous.runtimeType != current.runtimeType,
        listener: (context, state) {
          if (state is AvConnectedState) {
            _navigateToRoomScreen(context);
          }

          if (state is AvErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: ((context, state) {
          final isLoading = state is AvLoadingState;
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
                    value: _enableMicrophone,
                    title: const Text('Enable microphone'),
                    onChanged: ((value) {
                      setState(() => _enableMicrophone = value);
                    }),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: isLoading ? null : () => _join(context),
                    child: const Text('Join'),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
