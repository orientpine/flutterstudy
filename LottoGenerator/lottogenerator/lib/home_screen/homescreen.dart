import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  final Color color1;
  final Color color2;
  final Color color3;
  final Color color4;
  final Color color5;
  final Color color6;
  HomeScreen(this.color1, this.color2, this.color3, this.color4, this.color5,
      this.color6,
      {Key? key})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Set<int> set_num = {};
    while (set_num.length < 6) {
      Random random = new Random();
      int randomNumber = random.nextInt(42) + 1;
      set_num.add(randomNumber);
    }
    List<int> sortedlist = set_num.toList();
    sortedlist.sort();
    // print(set_num);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 70.0,
                height: 70.0,
                // margin: EdgeInsets.all(50.0),
                decoration:
                    BoxDecoration(color: widget.color1, shape: BoxShape.circle),
                child: Center(
                    child: Text(
                  sortedlist[0].toString(),
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                )),
              ),
              Container(
                width: 70.0,
                height: 70.0,
                // margin: EdgeInsets.all(50.0),
                decoration:
                    BoxDecoration(color: widget.color2, shape: BoxShape.circle),
                child: Center(
                    child: Text(
                  sortedlist[1].toString(),
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                )),
              ),
              Container(
                width: 70.0,
                height: 70.0,
                // margin: EdgeInsets.all(50.0),
                decoration:
                    BoxDecoration(color: widget.color3, shape: BoxShape.circle),
                child: Center(
                    child: Text(
                  sortedlist[2].toString(),
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                )),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 70.0,
                height: 70.0,
                // margin: EdgeInsets.all(50.0),
                decoration:
                    BoxDecoration(color: widget.color4, shape: BoxShape.circle),
                child: Center(
                    child: Text(
                  sortedlist[3].toString(),
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                )),
              ),
              Container(
                width: 70.0,
                height: 70.0,
                // margin: EdgeInsets.all(50.0),
                decoration:
                    BoxDecoration(color: widget.color5, shape: BoxShape.circle),
                child: Center(
                    child: Text(
                  sortedlist[4].toString(),
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                )),
              ),
              Container(
                width: 70.0,
                height: 70.0,
                // margin: EdgeInsets.all(50.0),
                decoration:
                    BoxDecoration(color: widget.color6, shape: BoxShape.circle),
                child: Center(
                    child: Text(
                  sortedlist[5].toString(),
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
