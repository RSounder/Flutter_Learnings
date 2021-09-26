import 'package:flutter/material.dart';
import 'components/login.dart';

void main() {
  runApp(Cosmother());
}

class Cosmother extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cosmother',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(firstLogin: true)
    );
  }
}