import 'package:flutter/material.dart';

import '../View/Scaffold/scaffold_all.dart';
import '../ViewModel/screen_values.dart';

class MyVideoSheed extends StatefulWidget {
  const MyVideoSheed({super.key});

  @override
  State<MyVideoSheed> createState() => _MyVideoSheedState();
}

class _MyVideoSheedState extends State<MyVideoSheed>
    with TickerProviderStateMixin {
  bool isSheedShow = false;
  bool isFull = true;

  @override
  Widget build(BuildContext context) {
    return ScaffoldAll(body: buildScreens());
  }

  Widget buildScreens() => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          buildFirstScreen(),
          Offstage(
            offstage: !isSheedShow,
            child: buildSecendScreen(),
          ),
        ],
      );

  Widget buildFirstScreen() => Column(
        children: [
          buildMainList(),
          Visibility(
              visible: isSheedShow && !isFull,
              child: SizedBox(height: Screen().width * 0.25)),
        ],
      );

  Widget buildSecendScreen() => GestureDetector(
      onTap: () {
        changeFull(true);
      },
      onDoubleTap: () {
        changeFull(false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: isFull ? Screen().height : Screen().width * 0.25,
        width: Screen().width,
        color: Colors.blue,
        //   alignment: Alignment.topLeft,
        child: buildSheedDetal(),
      ));

  Widget buildSheedDetal() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildPlayer(),
          Expanded(
              child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) => buildCard(index)))
        ],
      );

  Widget buildPlayer() => Stack(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          alignment: Alignment.topRight,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: isFull ? Screen().width : Screen().width * 0.4,
                  height: isFull ? Screen().width * 0.6 : Screen().width * 0.25,
                  color: Colors.red,
                ),
              ],
            ),
            Positioned.fill(
              child: Visibility(
                visible: !isFull,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () => changeShow(false),
                      icon: const Icon(Icons.close)),
                ),
              ),
            ),
          ]);

  Widget buildMainList() => Expanded(
      flex: !isFull || !isSheedShow ? 1 : -1,
      child: SizedBox(
        height: 0,
        width: double.infinity,
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 10,
            itemBuilder: ((context, index) => buildCard(index))),
      ));

  void changeFull(bool isF) {
    isFull = isF;
    setState(() {});
  }

  void changeShow(bool isS) {
    isSheedShow = isS;
    setState(() {});
  }

  Widget buildCard(int index) => GestureDetector(
        onTap: () {
          changeShow(true);
          changeFull(true);
        },
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: Screen().width,
              height: Screen().width * 0.6,
              color: Colors.black,
              child: Text(
                "$index",
                style: const TextStyle(fontSize: 100),
              ),
            ),
            Container(
              width: Screen().width,
              height: Screen().width * 0.2,
              color: Colors.green,
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
}
