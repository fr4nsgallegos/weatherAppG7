import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:weatherappg7/models/forecast_model.dart';
import 'package:weatherappg7/models/weather_model.dart';

class ApiServices {
  Future<WeatherModel?> getWeatherInfo(double lat, double lang) async {
    Uri url = Uri.parse(
        "http://api.weatherapi.com/v1/current.json?key=70866d7ade244a3c9ca20142230509&q=$lat,$lang&aqi=no");
    http.Response response = await http.get(url);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      WeatherModel weatherModel = WeatherModel.fromJson(data);
      return weatherModel;
    }
    return null;
  }

  Future<ForecastModel?> getForecastInfo(double lat, double lang) async {
    Uri url = Uri.parse(
        "http://api.weatherapi.com/v1/forecast.json?key=70866d7ade244a3c9ca20142230509&q=$lat,$lang&days=1&aqi=no&alerts=no");
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      ForecastModel forecastModel = ForecastModel.fromJson(data);
      return forecastModel;
    }
    return null;
  }

  Future<ForecastModel?> getForecastInfoFromSearch(String cityName) async {
    Uri url = Uri.parse(
        "http://api.weatherapi.com/v1/forecast.json?key=70866d7ade244a3c9ca20142230509&q=$cityName&days=1&aqi=no&alerts=no");

    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      ForecastModel forecastModel = ForecastModel.fromJson(data);
      return forecastModel;
    }
    return null;
  }
}
