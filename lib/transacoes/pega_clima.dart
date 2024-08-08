//import 'dart:convert';
//
//import 'package:http/http.dart' as http;
//import 'package:klmatico/models/weather.dart';
//
//class WeatherNetworkService {
//  static Future<Weather> pegaClima(String appId, String cidade) async {
//   final client = http.Client();
//   final url = Uri.parse('http://api.openweathermap.org/data/2.5/weather?q=$cidade&appid=$appId&units=metric');
//   final response = await client.get(url);
//   final result = jsonDecode(response.body);
//
//   if (result.statusCode == 200) {
//      return Weather.fromJson(result);
//   } else {
//    throw Exception("falha");
//   }
//  }
//}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:klmatico/models/weather.dart';

class WeatherNetworkService {
  static Future<Weather> pegaClima(String appId, String cidade) async {
    final client = http.Client();
    final url = Uri.parse('http://api.openweathermap.org/data/2.5/weather?q=$cidade&appid=$appId&units=metric');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return Weather.fromJson(result);
    } else {
      throw Exception("Falha ao buscar clima: ${response.statusCode}");
    }
  }
}
