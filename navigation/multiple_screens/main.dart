import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation',
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Click button to navigate'),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              child: Text('Page2'),
              onPressed: () {
                Random random = new Random();
                int min = -20, max = 20;
                navigateToPage(context, Page2(degreesTemp: ( min + Random().nextInt(max - min + 1) )));
              }
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              child: Text('Page3'),
              onPressed: () {
                navigateToPage(context, Page3());
              },
            )
          ],
        ),
      ),
    );
  }

  Future navigateToPage(context, pageNum) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => pageNum));
  }
}

class Page2 extends StatelessWidget {
  @override

  String smiley = '🤒';
  int degreesTemp = 45;
  Color backgroundColor = Colors.red;
  
  Page2({this.degreesTemp = 25}) {
    
    if( this.degreesTemp > 0 ) {
      if( this.degreesTemp > 25 ) {
      this.smiley = '☀️';
      this.backgroundColor = Colors.red;
      }
      else {
      this.smiley = '🌥️';
      this.backgroundColor = Colors.orange;
      }
    }
    else {
      this.smiley = '🌨️';
      this.backgroundColor = Colors.blueAccent;
    }
  }

  Widget build(BuildContext context) => Scaffold(
    backgroundColor: backgroundColor,
    appBar: AppBar(
      title: Text('Page2'),
      centerTitle: true,
    ),
    body: Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(smiley, style: TextStyle(fontSize: 100, fontWeight: FontWeight.w200, color: Colors.white)),
          const SizedBox(height: 24),
          Text('$degreesTemp°C', style: TextStyle(fontSize: 80, color: Colors.white))
        ],
      ),
    )
  );

  void goBack(context) {
    Navigator.pop(context);
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Page'),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Click button to back to Main Page'),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.redAccent,
              child: Text('Back to Main Page'),
              onPressed: () {
                goBack(context);
              },
            )
          ],
        ),
      ),
    );
  }

  void goBack(context) {
    Navigator.pop(context);
  }
}