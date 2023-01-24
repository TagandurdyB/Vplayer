import 'package:flutter/material.dart';

import '../../ViewModel/screen_values.dart';

class SettingsSheed extends StatelessWidget {
  const SettingsSheed({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: Screen().width * 0.05, horizontal: Screen().width * 0.1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildPX(context),
          build2Widget(context),
          build3Widget(context),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget buildPX(context) {
    return ListTile(
      onTap: () {
        Navigator.pop(context);
      },
      leading: const Icon(Icons.hd),
      title: const Text("HD"),
    );
  }

  Widget build2Widget(context) {
    return ListTile(
      onTap: () {
         Navigator.pop(context);
      },
      leading: const Icon(Icons.one_x_mobiledata),
      title: const Text("Speed"),
    );
  }

  Widget build3Widget(context) {
    return ListTile(
      onTap: () {
         Navigator.pop(context);
      },
      leading: const Icon(Icons.color_lens),
      title: const Text("Colors"),
    );
  }
}
