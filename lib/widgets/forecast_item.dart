import 'package:flutter/material.dart';

class ForecastItem extends StatelessWidget {
  String time;
  String value;
  int isDay;

  ForecastItem({
    required this.time,
    required this.value,
    required this.isDay,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
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
            time,
            style: TextStyle(
              color: Colors.white38,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Image.asset(
            "assets/images/${isDay == 1 ? 'sunny' : 'overcast'}.png",
            height: 50,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "$value °C",
            style: TextStyle(fontSize: 18, color: Colors.white),
          )
        ],
      ),
    );
  }
}
