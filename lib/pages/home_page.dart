import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherappg7/models/weather_model.dart';
import 'package:weatherappg7/services/api_services.dart';
import 'package:weatherappg7/widgets/forecast_item.dart';
import 'package:weatherappg7/widgets/weather_item.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel? _model;

  Future<Position> getLocation() async {
    bool _serviceEnabled;
    LocationPermission _permission;
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!_serviceEnabled) {
      return Future.error("Servicios de geolocalización estan deshabilitados");
    }

    _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
      if (_permission == LocationPermission.denied) {
        return Future.error("Los permisos han sido denegados");
      }
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<void> getDataLocation() async {
    Position position = await getLocation();
    _model = await ApiServices()
        .getWeatherInfo(position.latitude, position.longitude);
    setState(() {});
  }

  @override
  void initState() {
    // getWeatherInfo(-11.240446, -77.626040).then((value) {
    //   _model = value;
    //   setState(() {});
    // });
    getDataLocation();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff282B30),
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   getWeatherInfo(-11.240446, -77.626040);
      //   // getLocation().then((value) {
      //   //   print(value.latitude);
      //   //   print(value.longitude);
      //   // });
      // }),
      appBar: AppBar(
        title: Text("Weather App"),
        centerTitle: true,
        backgroundColor: Color(0xff282B30),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.location_on_outlined,
            ),
          )
        ],
      ),
      body: _model == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Container(
                  margin: EdgeInsets.all(24),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  // height: MediaQuery.of(context).size.height * .6,
                  // width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [
                        Color(0xff6b9dfc),
                        Color(0xff205cf1),
                      ],
                      stops: [0.0, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${_model?.location.name}, ${_model?.location.country}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Image.asset(
                        "assets/images/heavycloudy.png",
                        height: 100,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "${_model!.current.tempC}°",
                        style: TextStyle(
                          fontSize: 100,
                          color: Colors.white,
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          WeatherItem(
                            value: _model!.current.windKph.toString(),
                            unit: "km/h",
                            imagePath: "windspeed",
                          ),
                          WeatherItem(
                            value: _model!.current.humidity.toString(),
                            unit: "%",
                            imagePath: "humidity",
                          ),
                          WeatherItem(
                            value: _model!.current.cloud.toString(),
                            unit: "%",
                            imagePath: "cloud",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  "Forecast",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      ForecastItem(),
                      ForecastItem(),
                      ForecastItem(),
                      ForecastItem(),
                      ForecastItem(),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
