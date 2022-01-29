import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/components/current_weather.dart';
import 'package:weather_app/components/current_weather_info.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<CurrentWeather>(
          future: currentWeather,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  currentWeatherWidget(
                    snapshot.data!.iconName.toString(),
                    snapshot.data!.temp.toString(),
                    snapshot.data!.cityName.toString(),
                    snapshot.data!.country.toString(),
                    snapshot.data!.description.toString(),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  currentWeatherInfo(
                    "Wind",
                    "Pressure",
                    "Humidity",
                    "Feels like",
                    snapshot.data!.wind.toString(),
                    snapshot.data!.pressure.toString(),
                    snapshot.data!.humidity.toString(),
                    snapshot.data!.feelsLike.toString(),

                    "m/s",
                    "hPa",
                    "%",
                    "℃",
                  ),
                  currentWeatherInfo(
                    "Min Temp",
                    "Max Temp",
                    "Sunrise",
                    "Sunset",
                    snapshot.data!.minTemp.toString(),
                    snapshot.data!.maxTemp.toString(),
                    snapshot.data!.sunrise.toString(),
                    snapshot.data!.sunset.toString(),
                    "℃",
                    "℃",
                    "am",
                    "pm",
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
