import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/components/current_weather.dart';
import 'package:weather_app/components/current_weather_info.dart';
import 'package:weather_app/model/current_weather_model.dart';
import 'package:weather_app/services/currrent_weather_api.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<CurrentWeather> currentWeather;
  Location location = Location();

  bool isLoading = true;

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  @override
  void initState() {
    super.initState();
    getLocation();
    // currentWeather = fetchCurrentWeather();
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
        child: isLoading
            ? SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : FutureBuilder<CurrentWeather>(
                future: currentWeather,
                builder: (context, snapshot) {
                  // print(snapshot.data!);
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
                  }
                  //else if (snapshot.hasError) {
                  //   return SizedBox(
                  //     height: MediaQuery.of(context).size.height / 1.3,
                  //     child: AlertDialog(
                  //       title: const Text("Alert!!"),
                  //       content: const Text("No internet connection"),
                  //       actions: [
                  //         ElevatedButton(
                  //           child: const Text("OK"),
                  //           onPressed: () {
                  //             SystemChannels.platform
                  //                 .invokeMethod('SystemNavigator.pop');
                  //           },
                  //         ),
                  //       ],
                  //     ),
                  //   );
                  // }
                  else {
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

  getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    print("Step 1");
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      print("Step 2");

      if (!_serviceEnabled) {
        print("Step 3");
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      }
    }

    _permissionGranted = await location.hasPermission();
    print("Step 4");

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      print("Step 5");

      if (_permissionGranted != PermissionStatus.granted) {
        print("Step 6");

        // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        showAlertDialog(context);
      }
    }

    _locationData = await location.getLocation();
    // print(_locationData.longitude);

    currentWeather =
        fetchCurrentWeather(_locationData.latitude, _locationData.longitude);
    setState(() {
      isLoading = false;
    });
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = ElevatedButton(
      child: const Text("OK"),
      onPressed: () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Alert"),
      content: const Text("Please allow location manually"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
