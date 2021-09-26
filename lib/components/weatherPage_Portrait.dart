import 'dart:ui';

import 'package:cosmother/components/weatherData.dart';
import 'package:cosmother/components/weatherPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherPortrait extends StatelessWidget {
  const WeatherPortrait({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/sky.jpg',
            ),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 20,
                child: Row(
                  children: [
                    Expanded(
                        flex: 30,
                        child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                'https://www.countries-ofthe-world.com/flags-normal/flag-of-' +
                                    masterWeatherData.country
                                        .split(' ')[0]
                                        .trim() +
                                    '.png'))),
                    Expanded(flex: 70, child: WeatherTitleData())
                  ],
                )),
            Expanded(
                flex: 10,
                child: Center(
                    child: Text(
                  masterWeatherData.localTime,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ))),
            Expanded(
                flex: 30,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(50),
                        topRight: const Radius.circular(50)),
                    color: Colors.lightBlue.shade50,
                  ),
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 35,
                          child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Card(
                                  elevation: 10,
                                  shadowColor: Colors.lightBlue.shade100,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: TopBottomWeatherData(
                                      img: 'assets/images/thermo.png',
                                      data: masterWeatherData.tempC.toString() +
                                          '°C')))),
                      Expanded(
                          flex: 65,
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Card(
                                  elevation: 10,
                                  shadowColor: Colors.lightBlue.shade100,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: LeftRightWeatherData(
                                      img: 'assets/images/humid.png',
                                      data: masterWeatherData.humidity
                                              .toString() +
                                          ' gm/cu'))))
                    ],
                  ),
                )),
            Expanded(
                flex: 10,
                child: Container(
                    color: Colors.lightBlue.shade50,
                    child: Center(
                        child: Text(masterWeatherData.conditionText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ))))),
            Expanded(
                flex: 30,
                child: Container(
                  color: Colors.lightBlue.shade50,
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 65,
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Card(
                                  elevation: 10,
                                  shadowColor: Colors.lightBlue.shade100,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: LeftRightWeatherData(
                                      img: 'assets/images/precip.png',
                                      data:
                                          masterWeatherData.precip.toString() +
                                              ' mm')))),
                      Expanded(
                          flex: 35,
                          child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Card(
                                  elevation: 10,
                                  shadowColor: Colors.lightBlue.shade100,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: TopBottomWeatherData(
                                      img: 'assets/images/uv.png',
                                      data: masterWeatherData.uv.toString() +
                                          ' ind')))),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
