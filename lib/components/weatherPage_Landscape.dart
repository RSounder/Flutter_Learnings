import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'weatherData.dart';
import 'weatherPage.dart';

class WeatherLandscape extends StatelessWidget {
  const WeatherLandscape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            decoration: BoxDecoration(
              color: Colors.lightBlue.shade100,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)) 
            ),
            child: Row(
      children: [
        Expanded(
            flex: 30,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30)
                    ),
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/sky.jpg',
                        ),
                        fit: BoxFit.cover)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                'https://www.countries-ofthe-world.com/flags-normal/flag-of-' +
                                    masterWeatherData.country
                                        .split(' ')[0]
                                        .trim() +
                                    '.png'))),
                    Container(child: WeatherTitleData()),
                    Text(masterWeatherData.localTime,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))
                  ],
                ))),
        Expanded(
            flex: 70,
            child: Column(
              children: [
                Expanded(
                    flex: 20,
                    child: Center(
                        child: Text(
                      masterWeatherData.conditionText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ))),
                Expanded(
                    flex: 80,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 25,
                            child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Card(
                                    elevation: 10,
                                    shadowColor: Colors.lightBlue.shade100,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: TopBottomWeatherData(
                                        img: 'assets/images/thermo.png',
                                        data:
                                            masterWeatherData.tempC.toString() +
                                                '°C')))),
                        Expanded(
                            flex: 25,
                            child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Card(
                                    elevation: 10,
                                    shadowColor: Colors.lightBlue.shade100,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: TopBottomWeatherData(
                                        img: 'assets/images/uv.png',
                                        data: masterWeatherData.uv.toString() +
                                            ' ind')))),
                        Expanded(
                            flex: 50,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Card(
                                      elevation: 10,
                                      shadowColor: Colors.lightBlue.shade100,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: LeftRightWeatherData(
                                          img: 'assets/images/humid.png',
                                          data: masterWeatherData.humidity
                                                  .toString() +
                                              ' mm',
                                          size: 50),
                                    )),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Card(
                                        elevation: 10,
                                        shadowColor: Colors.lightBlue.shade100,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: LeftRightWeatherData(
                                            img: 'assets/images/precip.png',
                                            data: masterWeatherData.precip
                                                    .toString() +
                                                ' mm',
                                            size: 50))),
                              ],
                            )),
                      ],
                    )),
              ],
            )),
      ],
    )));
  }
}
