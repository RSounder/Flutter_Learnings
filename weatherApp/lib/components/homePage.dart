import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './weatherPage.dart';

String authToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJfZW1haWwiOiJlbWFpbHRvcnNvdW5kZXJAZ21haWwuY29tIiwiYXBpX3Rva2VuIjoiWFZ0MDMzOENTWGx0NDJYcEYzTlNHbHVYY3cwMWJxMzkySC1wdHBzNjgtY3c2Zjlud3V1U0djRzcxdGxKWXVUWlZWZyJ9LCJleHAiOjE2MzI2NTEzMzF9.5zlqVhrHbs89SgmWqv62oJKE4__xBPu8VdEqPOGhvv0';

Future <List<CountryData>> fetchCountriesData() async {
  final  Map<String, String> header = {
       'Authorization': 'Bearer ' + authToken,
       'Accept': 'application/json',
  };
  final response =
      await http.get(
            Uri.parse('https://www.universal-tutorial.com/api/countries/'),
            headers: header
      );
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => new CountryData.fromJson(data)).toList();
  } else {
    throw Exception(json.decode(response.body)['error']['name']);
  }
}

class CountryData {
  final String placeName;
  final int placeCode;
  final String placeNickName;

  CountryData({ required this.placeName,required this.placeCode,required this.placeNickName});

  factory CountryData.fromJson(Map<String, dynamic> json) {
    return CountryData(
      placeName: json['country_name'],
      placeCode: json['country_phone_code'],
      placeNickName: json['country_short_name'],
    );
  }
}

Future <List<StateData>> fetchStatesData(countryName) async {
  final  Map<String, String> header = {
       'Authorization': 'Bearer ' + authToken,
       'Accept': 'application/json',
  };
  final response =
      await http.get(
            Uri.parse('https://www.universal-tutorial.com/api/states/' + countryName),
            headers: header
      );
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => new StateData.fromJson(data)).toList();
  } else {
    throw Exception(json.decode(response.body)['error']['name']);
  }
}

class StateData {
  final String placeName;

  StateData({required this.placeName});

  factory StateData.fromJson(Map<String, dynamic> json) {
    return StateData(
      placeName: json['state_name']
    );
  }
}

Future <List<CitiesData>> fetchCitiesData(stateName) async {
  final  Map<String, String> header = {
       'Authorization': 'Bearer ' + authToken,
       'Accept': 'application/json',
  };
  final response =
      await http.get(
            Uri.parse('https://www.universal-tutorial.com/api/cities/' + stateName),
            headers: header
      );
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => new CitiesData.fromJson(data)).toList();
  } else {
    throw Exception(json.decode(response.body)['error']['name']);
  }
}

class CitiesData {
  final String placeName;

  CitiesData({required this.placeName});

  factory CitiesData.fromJson(Map<String, dynamic> json) {
    return CitiesData(
      placeName: json['city_name']
    );
  }
}

class HomePage extends StatefulWidget {

  HomePage(localAuthToken) {
    authToken = localAuthToken;
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future <List<CountryData>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchCountriesData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Countries'),
      ),
      body: Center(
        child: FutureBuilder <List<CountryData>>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<CountryData> data = snapshot.data!;
              return 
              ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: 
                        NetworkImage(
                          'https://www.countries-ofthe-world.com/flags-normal/flag-of-' + data[index].placeName.split(' ')[0].trim() + '.png'
                        )
                      ),
                    title: Text(data[index].placeName),
                    subtitle: Text(data[index].placeNickName + ' ' + data[index].placeCode.toString()),
                    onTap: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => States(data[index].placeName)
                        ),
                      );
                    },
                    trailing: Icon(Icons.chevron_right_rounded),                   
                  ),
                );
              }
            );
            } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
            }
            // By default show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class States extends StatefulWidget {
  String countryName;
  States(this.countryName);

  @override
  _StatesState createState() => _StatesState(this.countryName);
}

class _StatesState extends State<States> {
  late Future <List<StateData>> futureData;
  String countryName;

  _StatesState(this.countryName);

  @override
  void initState() {
    super.initState();
    futureData = fetchStatesData(this.countryName);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('States')),
      body: Center(
        child: FutureBuilder <List<StateData>>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<StateData> data = snapshot.data!;
              return 
              ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(data[index].placeName),
                    onTap: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => Cities(data[index].placeName)
                        ),
                      );                      
                    },
                    trailing: Icon(Icons.star),                   
                  ),
                );
              }
            );
            } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
            }
            // By default show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class Cities extends StatefulWidget {
  String stateName;
  Cities(this.stateName);

  @override
  _CitiesState createState() => _CitiesState(this.stateName);
}

class _CitiesState extends State<Cities> {
  late Future <List<CitiesData>> futureData;
  String stateName;

  _CitiesState(this.stateName);

  @override
  void initState() {
    super.initState();
    futureData = fetchCitiesData(this.stateName);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cities')),
      body: Center(
        child: FutureBuilder <List<CitiesData>>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<CitiesData> data = snapshot.data!;
              return 
              ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(data[index].placeName),
                    onTap: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => CityWeather(data[index].placeName)
                        ),
                      );     
                    },
                    trailing: Icon(Icons.star),                   
                  ),
                );
              }
            );
            } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
            }
            // By default show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}