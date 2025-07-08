class WeatherResponse {
  final Coord? coord;
  final List<Weather> weather;
  final String base;
  final MainWeather main;
  final int? visibility;
  final Wind wind;
  final Rain? rain;
  final Clouds clouds;
  final int? dt;
  final Sys? sys;
  final int? timezone;
  final int? id;
  final String name;
  final int? cod;

  WeatherResponse({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    this.visibility,
    required this.wind,
    this.rain,
    required this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    required this.name,
    this.cod,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      coord: json['coord'] != null ? Coord.fromJson(json['coord']) : null,
      weather: List<Weather>.from(json['weather'].map((x) => Weather.fromJson(x))),
      base: json['base'],
      main: MainWeather.fromJson(json['main']),
      visibility: json['visibility'],
      wind: Wind.fromJson(json['wind']),
      rain: json['rain'] != null ? Rain.fromJson(json['rain']) : null,
      clouds: Clouds.fromJson(json['clouds']),
      dt: json['dt'],
      sys: json['sys'] != null ? Sys.fromJson(json['sys']) : null,
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
    );
  }
}

class Coord {
  final double lon;
  final double lat;

  Coord({required this.lon, required this.lat});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lon: (json['lon'] as num).toDouble(),
      lat: (json['lat'] as num).toDouble(),
    );
  }

}

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }

}

class MainWeather {
  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int pressure;
  final int humidity;
  final int seaLevel;
  final int grndLevel;

  MainWeather({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
  });

  factory MainWeather.fromJson(Map<String, dynamic> json) {
    return MainWeather(
      temp: (json['temp'] as num?)?.toDouble(),
      feelsLike: (json['feels_like'] as num?)?.toDouble(),
      tempMin: (json['temp_min'] as num?)?.toDouble(),
      tempMax: (json['temp_max'] as num?)?.toDouble(),
      pressure: json['pressure'],
      humidity: json['humidity'],
      seaLevel: json['sea_level'],
      grndLevel: json['grnd_level'],
    );
  }

}

class Wind {
  final double speed;
  final int deg;
  final double? gust;

  Wind({
    required this.speed,
    required this.deg,
    this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: (json['speed'] as num).toDouble(),
      deg: json['deg'],
      gust: json['gust'] != null ? (json['gust'] as num).toDouble() : null,
    );
  }


}

class Rain {
  final double? oneHour;

  Rain({this.oneHour});

  factory Rain.fromJson(Map<String, dynamic> json) {
    return Rain(
      oneHour: (json['1h'] as num?)?.toDouble(),
    );
  }


}

class Clouds {
  final int all;

  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json['all'],
    );
  }


}
class Sys {
  final int? type;
  final int? id;
  final String country;
  final int sunrise;
  final int sunset;

  Sys({
    this.type,
    this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      type: json['type'],
      id: json['id'],
      country: json['country'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }
}