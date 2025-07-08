import 'package:flutter/foundation.dart';
import 'package:foodcourt/model/weather.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;


class HttpUtils {

  static const JsonDecoder decoder = JsonDecoder(); //to get a map rep

  static Future<WeatherResponse> getWeatherDetails(double lat, double long) async {
    String weatherUri = 'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid={Add your Api Token}';

    var response = await http.get(Uri.parse(weatherUri));

    if (response.statusCode == 200) {
      return compute(parseWeatherDetails,
          response.body);
    } else {
      throw Exception('Failed to lead');
    }
  }
  //lets run another thread for
  static WeatherResponse parseWeatherDetails(String responseBody) {
    return WeatherResponse.fromJson(json.decode(responseBody));
  }}
