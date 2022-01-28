class CurrentWeather {
  final String cityName;
  final String country;
  final String description;
  final String iconName;
  final dynamic temp;
  final dynamic wind;
  final dynamic pressure;
  final dynamic humidity;
  final double feelsLike;
  final double maxTemp;
  final double minTemp;
  final dynamic sunrise;
  final dynamic sunset;

  CurrentWeather({
    required this.cityName,
    required this.country,
    required this.description,
    required this.iconName,
    required this.temp,
    required this.wind,
    required this.pressure,
    required this.humidity,
    required this.feelsLike,
    required this.maxTemp,
    required this.minTemp,
    required this.sunrise,
    required this.sunset,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      cityName: json['name'],
      country: json['sys']['country'],
      description: json['weather'][0]['description'],
      iconName: json['weather'][0]['icon'],
      temp: json['main']['temp'],
      wind: json['wind']['speed'],
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      feelsLike: json['main']['feels_like'],
      maxTemp: json['main']['temp_max'],
      minTemp: json['main']['temp_min'],
      sunrise: DateTime.fromMicrosecondsSinceEpoch(
              json['sys']['sunrise'] * 1000,
              isUtc: false)
          .hour,
      sunset: DateTime.fromMicrosecondsSinceEpoch(json['sys']['sunset'] * 1000,
              isUtc: false)
          .hour,
    );
  }
}
