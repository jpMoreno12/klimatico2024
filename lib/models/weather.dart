//class Weather {
//  final String name;
//  final double temperature;
//  final double temperatureFeeling;
//
//  Weather (
//    {
//      required this.name,
//      required this.temperature,
//      required this.temperatureFeeling,
//    }
//  );
//
//  factory Weather.fromJson(Map<String, dynamic> jsonResponse) => Weather(
//    name: jsonResponse['name'], 
//    temperature: jsonResponse['main']['temperature'], 
//    temperatureFeeling: jsonResponse['main']['feels_like'],
//    );
//}


class Weather {
  final String name;
  final num minTemp;
  final num maxTemp;
  final num temperature;
  final num temperatureFeeling;
  final String weatherDescription;
  final String weatherIcon;
  final num humidity;
  


  Weather({
    required this.name,
    required this.temperature,
    required this.temperatureFeeling,
    required this.weatherDescription,
    required this.weatherIcon,
    required this.humidity,
    required this.minTemp,
    required this.maxTemp,
  });

  factory Weather.fromJson(Map<String, dynamic> jsonResponse) => Weather(
    name: jsonResponse['name'],
    temperature: jsonResponse['main']['temp'].toDouble(),
    temperatureFeeling: jsonResponse['main']['feels_like'].toDouble(),
    weatherDescription: jsonResponse['weather'][0]['description'],
    weatherIcon: jsonResponse['weather'][0]['icon'],
    humidity: jsonResponse['main']['humidity'].toDouble(),
    minTemp: jsonResponse['main']['temp_min'].toDouble(),
    maxTemp: jsonResponse['main']['temp_max'].toDouble(),
  );
}
