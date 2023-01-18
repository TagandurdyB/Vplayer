import 'package:flutter/material.dart';
import 'package:player/View/Widget/video_widget.dart';
import 'package:player/ViewModel/Providers/provider_theme.dart';
import 'package:player/ViewModel/screen_values.dart';
import 'package:provider/provider.dart';
import '../Scaffold/scaffold_all.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    final screen = Screen();
    return ScaffoldAll(
        body: ListView.builder(
          physics:const BouncingScrollPhysics(),
            itemCount: 10,
            itemBuilder: ((context, index) => const VideoWidget())));
  }
}
