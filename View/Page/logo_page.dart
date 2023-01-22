import 'package:flutter/material.dart';
import 'package:local_player/ViewModel/multi_video_picker_vm.dart';
import '/View/Widget/my_container.dart';
import '/ViewModel/screen_values.dart';


class LogoPage extends StatefulWidget {
  const LogoPage({super.key});

  @override
  State<LogoPage> createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  @override
  void initState() {
    super.initState();

    /* Future.delayed(const Duration(seconds: 2)).then(
        (value) => Navigator.pushReplacementNamed(context, Rout.pageMain));
    Future.delayed(const Duration(seconds: 2)).then(
        (value) => MultipleVideoPicker().pick(context));*/
  }

  @override
  Widget build(BuildContext context) {
    MultipleVideoPicker().repick(context, 2);
    final screen = Screen();
    final size = MediaQuery.of(context).size;
    screen.changeWidth(size.width);
    screen.changeHeight(size.height);
    return Scaffold(
      // appBar: AppBar(),
      body: Align(
        alignment: Alignment.center,
        child: MyContainer(
          alignment: Alignment.center,
          // color: Provider.of<ProviderTheme>(context).colorModel,
          shape: screen.width * 0.1,
          colors: const [Colors.red, Colors.black, Colors.white],
          width: screen.width * 0.5,
          height: screen.width * 0.2,
          child: Text(
            "PLAYER",
            style: TextStyle(fontSize: screen.width * 0.05),
          ),
        ),
      ),
    );
  }
}
