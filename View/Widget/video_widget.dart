import 'package:flutter/material.dart';
import 'package:player/View/Widget/my_container.dart';
import 'package:player/ViewModel/rout_vm.dart';
import 'package:player/ViewModel/screen_values.dart';

class VideoWidget extends StatelessWidget {
  const VideoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = Screen();
    return MyContainer(
      onTap: (){
        print("salmaasa asasa  ");
        debugPrint("I am work");
        Navigator.pushNamed(context, Rout.pagePlayer);
      },
 
      child: Column(
        children: [
          Container(
            color: Colors.black,
            width: screen.width,
            height: screen.width * 0.7,
          ),
          Container(
            color:  Colors.grey[800],
            width: screen.width,
            height: screen.width * 0.2,
            padding:const EdgeInsets.all(16),
            child:  Row(
              children:const [
                CircleAvatar(
                  child: Icon(Icons.ac_unit_rounded)),
                Text("salam"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
