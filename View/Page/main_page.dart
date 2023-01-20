import 'package:flutter/material.dart';
import 'package:player/View/Widget/video_card_widget.dart';
import '../../Model/data_obj.dart';
import '../Scaffold/scaffold_all.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return ScaffoldAll(
        body: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: Data.list.length,
            itemBuilder: ((context, index) {
              final obj = Data.list[index];
              return VideoCardWidget(
                aboutText: obj.videoText,
              );
            })));
  }
}
