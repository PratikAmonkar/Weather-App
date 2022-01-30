import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/config/api_config.dart';
import 'package:weather_app/model/current_weather_model.dart';

Future<CurrentWeather> fetchCurrentWeather(latitute,longitute) async {
  try {
    final response = await http.get(
      Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitute&lon=$longitute&units=metric&appid=$weatherUrl",
      ),
    );

    if (response.statusCode == 200) {
      // print(response.body);
      return CurrentWeather.fromJson(jsonDecode(response.body));
    } else {
      return throw Exception("Failed to fetch current weather");
    }
  } on Exception catch (e) {
    return throw Exception("No internet connection");
  }
}
