class WeatherModel {
  Location location;
  Current current;

  WeatherModel({
    required this.location,
    required this.current,
  });
}

class Location {
  String name;
  String country;
  Location({
    required this.name,
    required this.country,
  });
}

class Current {
  int humidity;
  int cloud;
  double wind_kph;
  Current({
    required this.humidity,
    required this.cloud,
    required this.wind_kph,
  });
}
