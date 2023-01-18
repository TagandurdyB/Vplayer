import 'package:flutter/material.dart';
import 'package:player/View/Widget/my_container.dart';
import 'package:player/ViewModel/screen_values.dart';

import '../../ViewModel/rout_vm.dart';

class LogoPage extends StatefulWidget {
  const LogoPage({super.key});

  @override
  State<LogoPage> createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then(
        (value) => Navigator.pushReplacementNamed(context, Rout.pageMain));
  }

  @override
  Widget build(BuildContext context) {
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
         shape: screen.width*0.1,
         colors:const [Colors.red,Colors.black,Colors.white],
          width: screen.width * 0.5,
          height: screen.width * 0.2,
      child: Text("PLAYER",style: TextStyle(fontSize: screen.width*0.05),),
        ),
      ),
    );
  }
}
