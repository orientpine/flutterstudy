import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime daywemet = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 224, 223, 215),
      // back.asset('asset/img/jayeon.jpg'),
      body: SafeArea(
        bottom: false,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              _TopPart(
                selecteddate: daywemet,
                onPressed: onHeartPressed,
              ),
            ],
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('asset/img/jayeon.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  void onHeartPressed() {
    final DateTime now = DateTime.now();
    showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              height: 300.0,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: daywemet,
                maximumDate: DateTime(
                  now.year,
                  now.month,
                  now.day,
                ),
                onDateTimeChanged: (DateTime dateTime) {
                  setState(() {
                    daywemet = dateTime;
                  });
                },
              ),
            ),
          );
        });
  }
}

class _TopPart extends StatelessWidget {
  final DateTime selecteddate;
  final DateTime now = DateTime.now();

  final VoidCallback onPressed;
  _TopPart({
    required this.selecteddate,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Stack(
            children: [
              Text(
                'U & I',
                style: TextStyle(
                  fontSize: 70,
                  fontFamily: 'Yesteryear',
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 6
                    ..color = Color.fromARGB(255, 118, 178, 228),
                ),
              ),
              // Solid text as fill.
              Text(
                'U & I',
                style: TextStyle(
                  fontSize: 70,
                  fontFamily: 'Yesteryear',
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                '우리 처음 만난 날',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontFamily: 'Sunflower',
                    fontSize: 40),
              ),
              Text(
                '${selecteddate.year}.${selecteddate.month}.${selecteddate.day}',
                style: TextStyle(
                    color: Color.fromARGB(244, 195, 245, 253),
                    fontFamily: 'Jua',
                    fontSize: 20),
              ),
            ],
          ),
          IconButton(
            iconSize: 50,
            onPressed: onPressed,
            icon: Icon(
              Icons.favorite,
              color: Color.fromARGB(255, 194, 29, 70),
            ),
          ),
          Stack(
            children: [
              Text(
                'D+${DateTime(
                      now.year,
                      now.month,
                      now.day,
                    ).difference(selecteddate).inDays + 1}',
                style: TextStyle(
                    fontFamily: 'Jua',
                    fontSize: 50,
                    fontWeight: FontWeight.w500,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 4
                      ..color = Colors.white),
              ),
              Text(
                'D+${DateTime(
                      now.year,
                      now.month,
                      now.day,
                    ).difference(selecteddate).inDays + 1}',
                style: TextStyle(
                    color: Color.fromARGB(212, 223, 57, 99),
                    fontFamily: 'Jua',
                    fontSize: 50,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
