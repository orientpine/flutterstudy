import 'package:flutter/material.dart';
import 'package:navigation_study/layout/main_layout.dart';
import 'package:navigation_study/screen/route_three_screen.dart';

class RouteTwoScreen extends StatelessWidget {
  const RouteTwoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    return MainLayout(title: 'Route Two', children: [
      Text(
        'arguements: $arguments',
        textAlign: TextAlign.center,
      ),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Pop')),
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            '/three',
            arguments: 999,
          );
        },
        child: Text('Push named'),
      ),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => RouteThreeScreen(),
              ),
            );
          },
          child: Text('Push other way')),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/three');
          },
          child: Text('pushReplacementNamed')),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/three',
              (route) => route.settings.name == '/',
            );
          },
          child: Text('Push and Remove Until'))
    ]);
  }
}
