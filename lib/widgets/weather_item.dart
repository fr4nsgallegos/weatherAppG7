import 'package:flutter/material.dart';

class WeatherItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/images/windspeed.png",
          height: 50,
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "6km/h",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
