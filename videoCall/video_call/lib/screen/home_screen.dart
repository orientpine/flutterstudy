// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:video_call/screen/cam_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: _Logo(),
              ),
              Expanded(
                child: _Image(),
              ),
              Expanded(
                child: _EntryButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(
              18.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade300,
                blurRadius: 12.0,
                spreadRadius: 2.0,
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Icon(
                Icons.videocam,
                color: Colors.white,
                size: 50.0,
              ),
              SizedBox(width: 13.0),
              Text(
                'LIVE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  letterSpacing: 5.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset('asset/img/home_img.png'));
  }
}

class _EntryButton extends StatelessWidget {
  const _EntryButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CamScreen(),
              ),
            );
          },
          child: Text('입장하기'),
        ),
      ],
    );
  }
}
