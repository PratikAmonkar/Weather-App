import 'package:flutter/material.dart';
import 'package:weather_app/model/current_weather_model.dart';
import 'package:weather_app/services/currrent_weather_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<CurrentWeather> currentWeather;

  @override
  void initState() {
    super.initState();
    currentWeather = fetchCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
