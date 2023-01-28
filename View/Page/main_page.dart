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
                const Divider(height: 20,color: Colors.white,),
                ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, Rout.pageDemoAnimArrow),
                child: const Text("Anim Arrows")),
                ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, Rout.pageDemoVideoSheed),
                child: const Text("Video Sheed")),
                ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, Rout.pageDemoNexPlayer),
                child: const Text("Next Player")),
                  ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, Rout.pageDemoQualityPlayer),
                child: const Text("Quality Player")),
          ]),
    );
  }
}
