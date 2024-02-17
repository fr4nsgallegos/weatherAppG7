import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherappg7/widgets/weather_item.dart';

class HomePage extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff282B30),

      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   getLocation().then((value) {
      //     print(value.latitude);
      //     print(value.longitude);
      //   });
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
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(24),
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 32,
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
                  "Lima, Perú",
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
                  "16.1°",
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
                    WeatherItem(),
                    WeatherItem(),
                    WeatherItem(),
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
          Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Color(0xff3E4145),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.7),
                  blurRadius: 4,
                  offset: Offset(4, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  "01:00",
                  style: TextStyle(
                    color: Colors.white38,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Image.asset(
                  "assets/images/overcast.png",
                  height: 50,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "5.6 °C",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
