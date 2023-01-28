import 'package:flutter/material.dart';
import 'package:local_player/View/Widget/pop_up_widget.dart';
import 'package:local_player/ViewModel/Providers/provider_controller.dart';
import 'package:provider/provider.dart';

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
    void speed() {
      Provider.of<ControlVideo>(context, listen: false).getSpeed;
      PopUpWidget(
          content: SpeedBar(),
          textColor: Colors.black,
          Theme: PopTheme.light,
          bgColor: Colors.green,
          title: "Speeds",
          actionsTeam: [ActionsTeam(text: "Tamam")]).popUpCupertino(context);
    }

    return ListTile(
      onTap: speed,
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

// ignore: must_be_immutable
class SpeedBar extends StatelessWidget {
  SpeedBar({super.key});
  late BuildContext contextM;

  @override
  Widget build(BuildContext context) {
    contextM = context;
    return Column(
        children: ControlVideo.allSpeeds
            .map(
              (e) => buildSpibCheck(e),
            )
            .toList());
  }

  Widget buildSpibCheck(double speed) => ListTile(
        onTap: ()=>_changeSpeed(speed),
        leading: Text("${speed}X"),
        trailing: Provider.of<ControlVideo>(contextM).selectSpeed == speed
            ? const Icon(Icons.radio_button_checked)
            : const Icon(Icons.radio_button_off),
      );

  void _changeSpeed(double speed) {
    final providC=
    Provider.of<ControlVideo>(contextM, listen: false);
    providC.changeSpeed(speed);
    providC.control.setPlaybackSpeed(speed);
    Navigator.pop(contextM);
    Navigator.pop(contextM);
  }
}
