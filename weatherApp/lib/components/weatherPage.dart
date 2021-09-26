import 'dart:async';
import 'dart:convert';
import './weatherPage_Portrait.dart';
import './weatherPage_Landscape.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

dynamic masterWeatherData;

Future<CityData> fetchCityWeatherData(cityName) async {
  final response = await http.get(Uri.parse(
      'https://api.weatherapi.com/v1/current.json?key=c7f82562c1f34b64937131520212309&q=' +
          cityName));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return CityData.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(jsonDecode(response.body)['error']['message']);
  }
}

class CityData {
  final String name;
  final String region;
  final String country;
  final String localTime;
  final dynamic tempC;
  final String conditionText;
  final dynamic precip;
  final dynamic humidity;
  final dynamic uv;
  
  CityData({
    required this.name, 
    required this.region,
    required this.country,
    required this.localTime,
    required this.tempC,
    required this.conditionText,
    required this.precip,
    required this.humidity,
    required this.uv
  });

  factory CityData.fromJson(Map<String, dynamic> json) {
    return CityData(
      name: json['location']['name'],
      region: json['location']['region'],
      country: json['location']['country'],
      localTime: json['location']['localtime'],
      tempC: json['current']['temp_c'],
      conditionText: json['current']['condition']['text'],
      precip: json['current']['precip_mm'],
      humidity: json['current']['humidity'],
      uv: json['current']['uv']
    );
  }
}

class CityWeather extends StatefulWidget {
  final String city;

  const CityWeather(this.city);

  @override
  _CityWeatherState createState() => _CityWeatherState(this.city);
}

class _CityWeatherState extends State<CityWeather> {
  late Future<CityData> futureData;
  final String cityName;

  _CityWeatherState(this.cityName);

  @override
  void initState() {
    super.initState();
    futureData = fetchCityWeatherData(this.cityName);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather Data @ $cityName'),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<CityData>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //return Text(snapshot.data!.region);
                masterWeatherData = snapshot.data!;
                return (MediaQuery.of(context).orientation == Orientation.portrait ? WeatherPortrait() : WeatherLandscape());
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
