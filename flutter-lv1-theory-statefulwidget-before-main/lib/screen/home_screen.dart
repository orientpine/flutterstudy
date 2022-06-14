import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final Color color;
  HomeScreen({required this.color, Key? key}) : super(key: key) {
    print('widget Constructor 실행!');
  }

  @override
  State<HomeScreen> createState() {
    print('createStat 실행!');
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int number = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('initState 실행!');
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('didchangeDependency 실행!');
  }

  @override
  Widget build(BuildContext context) {
    print('build 실행');
    return GestureDetector(
      onTap: () {
        setState(() {
          number++;
        });
      },
      child: Container(
        width: 50.0,
        height: 50.0,
        color: widget.color,
        child: Center(
            child: Text(
          number.toString(),
          style: TextStyle(fontSize: 30, color: Colors.white),
        )),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('didupdatewidget excute!');
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('deactivate excute!');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('dispose excute!');
  }
}

// class _HomeScreen extends StatelessWidget {
//   final Color color;

//   const _HomeScreen({
//     required this.color,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 50.0,
//       height: 50.0,
//       color: color,
//     );
//   }
// }
