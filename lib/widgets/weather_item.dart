import 'package:flutter/material.dart';

class WeatherItem extends StatelessWidget {
  String value;
  String unit;
  String imagePath;
  WeatherItem({
    required this.value,
    required this.unit,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/images/$imagePath.png",
          height: 50,
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "$value $unit",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
