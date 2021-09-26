import 'package:flutter/material.dart';
import './weatherPage.dart';

class WeatherTitleData extends StatelessWidget {
  const WeatherTitleData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('City: ' + masterWeatherData.name, style: TextStyle(fontSize: 18)),
              Text('State: ' + masterWeatherData.region, style: TextStyle(fontSize: 15)),
              Text('Country: ' + masterWeatherData.country, style: TextStyle(fontSize: 15)),
            ],
          )
    );
  }
}

class TopBottomWeatherData extends StatelessWidget {
  String img;
  String data;

  TopBottomWeatherData({required this.img, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
          child: Image.asset(img, height: 90)
          ),
          Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: Text(
            data,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            )
          )
      ],
    );
  }
}

class LeftRightWeatherData extends StatelessWidget {
  String img;
  String data;
  double size;

  LeftRightWeatherData({required this.img, required this.data, this.size = 70});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 10, 20),
          child: Image.asset(img, width: size)
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
          child: Text(
            data,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            )
        )
      ],
    );
  }
}