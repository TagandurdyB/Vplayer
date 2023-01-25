import 'package:flutter/material.dart';
import 'package:local_player/ViewModel/multi_video_picker_vm.dart';
import '../../ViewModel/Providers/provider_theme.dart';
import '../../ViewModel/rout_vm.dart';
import '../../ViewModel/screen_values.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: ProviderTheme().titleMainPage),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: Screen().width),
            ElevatedButton(
                onPressed: () => MultipleVideoPicker().repick(context, 2),
                child: const Text("Local Player")),
                ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, Rout.pageDemo),
                child: const Text("Demo Page")),
          ]),
    );
  }
}
