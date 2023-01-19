import 'package:flutter/material.dart';
import 'package:player/View/Widget/video_widget.dart';
import '../Scaffold/scaffold_all.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return ScaffoldAll(
        body: ListView.builder(
          physics:const BouncingScrollPhysics(),
            itemCount: 10,
            itemBuilder: ((context, index) => const VideoWidget())));
  }
}
