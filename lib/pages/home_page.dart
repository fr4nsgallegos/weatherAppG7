import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherappg7/models/forecast_model.dart';
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
  ForecastModel? _forecastModel;
  TextEditingController _searhController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
    //LLENANDO EL MODELO WEATHER
    // _model = await ApiServices()
    //     .getWeatherInfo(position.latitude, position.longitude);

    //LLENANDO EL MODELO FORESCAST
    _forecastModel = await ApiServices().getForecastInfo(
      position.latitude,
      position.longitude,
    );
    setState(() {});
  }

  Future<void> getForecastSearch(String cityName) async {
    ForecastModel? _forecastModelAux;
    _forecastModelAux = await ApiServices().getForecastInfoFromSearch(cityName);
    if (_forecastModelAux == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Hubo un inconveniente, intenta ingresar otra ciudad",
          ),
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      _forecastModel = _forecastModelAux;
      _searhController.clear();
      setState(() {});
    }
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
            onPressed: () {
              getDataLocation();
            },
            icon: Icon(
              Icons.location_on_outlined,
            ),
          )
        ],
      ),
      body: _forecastModel == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: formKey,
              child: ListView(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                    child: TextFormField(
                      controller: _searhController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              getForecastSearch(_searhController.text);
                            }
                          },
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                        hintText: "Ingresa la ciudad",
                        fillColor: Colors.white.withOpacity(0.08),
                        filled: true,
                        hintStyle: TextStyle(
                          color: Colors.white54,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return "El campo es obligatorio";
                        }
                        return null;
                      },
                    ),
                  ),
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
                          "${_forecastModel?.location.name}, ${_forecastModel?.location.country}",
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
                          "${_forecastModel!.current.tempC}°",
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
                              value: _forecastModel!.current.windKph.toString(),
                              unit: "km/h",
                              imagePath: "windspeed",
                            ),
                            WeatherItem(
                              value:
                                  _forecastModel!.current.humidity.toString(),
                              unit: "%",
                              imagePath: "humidity",
                            ),
                            WeatherItem(
                              value: _forecastModel!.current.cloud.toString(),
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
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Row(
                        children: List.generate(
                          _forecastModel!.forecast.forecastday[0].hour.length,
                          (index) => ForecastItem(
                            isDay: _forecastModel!
                                .forecast.forecastday[0].hour[index].isDay,
                            value: _forecastModel!
                                .forecast.forecastday[0].hour[index].tempC
                                .toString(),
                            time: _forecastModel!
                                .forecast.forecastday[0].hour[index].time
                                .toString()
                                .substring(11, 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
