class WeatherModel {
  Location location;
  Current current;

  WeatherModel({
    required this.location,
    required this.current,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        location: Location.fromJson(json["location"]),
        current: Current.fromJson(json["current"]),
      );
}

class Location {
  String name;
  String country;
  Location({
    required this.name,
    required this.country,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        country: json["contry"],
      );
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

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        humidity: json["humidity"],
        cloud: json["cloud"],
        wind_kph: json["wind_kph"],
      );
}
