import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/config/api_config.dart';
import 'package:weather_app/model/current_weather_model.dart';

Future<CurrentWeather> fetchCurrentWeather() async {
  try {
    final response = await http.get(
      Uri.parse(
        weatherUrl,
      ),
    );

    if (response.statusCode == 200) {
      return CurrentWeather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch current weather");
    }
  } on Exception catch (e) {
    return throw Exception("No internet connection");
  }
}
