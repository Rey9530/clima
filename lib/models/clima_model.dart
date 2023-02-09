import 'dart:convert';

RespClima respClimaFromJson(String str) => RespClima.fromJson(json.decode(str));

class RespClima {
  RespClima({
    required this.latitude,
    required this.longitude,
    required this.generationtimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.currentWeather,
    required this.dailyUnits,
    required this.daily,
  });

  final double latitude;
  final double longitude;
  final double generationtimeMs;
  final int utcOffsetSeconds;
  final String timezone;
  final String timezoneAbbreviation;
  final double elevation;
  final CurrentWeather currentWeather;
  final DailyUnits dailyUnits;
  final Daily daily;

  factory RespClima.fromJson(Map<String, dynamic> json) => RespClima(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        generationtimeMs: json["generationtime_ms"].toDouble(),
        utcOffsetSeconds: json["utc_offset_seconds"],
        timezone: json["timezone"],
        timezoneAbbreviation: json["timezone_abbreviation"],
        elevation: json["elevation"].toDouble(),
        currentWeather: CurrentWeather.fromJson(json["current_weather"]),
        dailyUnits: DailyUnits.fromJson(json["daily_units"]),
        daily: Daily.fromJson(json["daily"]),
      );
}

class CurrentWeather {
  CurrentWeather({
    required this.temperature,
    required this.windspeed,
    required this.winddirection,
    required this.weathercode,
    required this.time,
  });

  final double temperature;
  final double windspeed;
  final double winddirection;
  final int weathercode;
  final String time;

  factory CurrentWeather.fromJson(Map<String, dynamic> json) => CurrentWeather(
        temperature: json["temperature"].toDouble(),
        windspeed: json["windspeed"].toDouble(),
        winddirection: json["winddirection"].toDouble(),
        weathercode: json["weathercode"],
        time: json["time"],
      );
}

class Daily {
  Daily({
    required this.time,
    required this.weathercode,
    required this.temperature2MMax,
    required this.temperature2MMin,
    required this.apparentTemperatureMax,
    required this.apparentTemperatureMin,
    required this.sunrise,
    required this.sunset,
    required this.precipitationSum,
    required this.rainSum,
    required this.showersSum,
    required this.snowfallSum,
    required this.precipitationHours,
    required this.windspeed10MMax,
    required this.windgusts10MMax,
    required this.winddirection10MDominant,
    required this.shortwaveRadiationSum,
  });

  final List<DateTime> time;
  final List<int> weathercode;
  final List<double> temperature2MMax;
  final List<double> temperature2MMin;
  final List<double> apparentTemperatureMax;
  final List<double> apparentTemperatureMin;
  final List<String> sunrise;
  final List<String> sunset;
  final List<double> precipitationSum;
  final List<double> rainSum;
  final List<double> showersSum;
  final List<double> snowfallSum;
  final List<double> precipitationHours;
  final List<double> windspeed10MMax;
  final List<double> windgusts10MMax;
  final List<int> winddirection10MDominant;
  final List<double> shortwaveRadiationSum;

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        time: List<DateTime>.from(json["time"].map((x) => DateTime.parse(x))),
        weathercode: List<int>.from(json["weathercode"].map((x) => x)),
        temperature2MMax: List<double>.from(
            json["temperature_2m_max"].map((x) => x.toDouble())),
        temperature2MMin: List<double>.from(
            json["temperature_2m_min"].map((x) => x.toDouble())),
        apparentTemperatureMax: List<double>.from(
            json["apparent_temperature_max"].map((x) => x.toDouble())),
        apparentTemperatureMin: List<double>.from(
            json["apparent_temperature_min"].map((x) => x.toDouble())),
        sunrise: List<String>.from(json["sunrise"].map((x) => x)),
        sunset: List<String>.from(json["sunset"].map((x) => x)),
        precipitationSum:
            List<double>.from(json["precipitation_sum"].map((x) => x)),
        rainSum: List<double>.from(json["rain_sum"].map((x) => x)),
        showersSum: List<double>.from(json["showers_sum"].map((x) => x)),
        snowfallSum: List<double>.from(json["snowfall_sum"].map((x) => x)),
        precipitationHours:
            List<double>.from(json["precipitation_hours"].map((x) => x)),
        windspeed10MMax: List<double>.from(
            json["windspeed_10m_max"].map((x) => x.toDouble())),
        windgusts10MMax: List<double>.from(
            json["windgusts_10m_max"].map((x) => x.toDouble())),
        winddirection10MDominant:
            List<int>.from(json["winddirection_10m_dominant"].map((x) => x)),
        shortwaveRadiationSum: List<double>.from(
            json["shortwave_radiation_sum"].map((x) => x.toDouble())),
      );
}

class DailyUnits {
  DailyUnits({
    required this.time,
    required this.weathercode,
    required this.temperature2MMax,
    required this.temperature2MMin,
    required this.apparentTemperatureMax,
    required this.apparentTemperatureMin,
    required this.sunrise,
    required this.sunset,
    required this.precipitationSum,
    required this.rainSum,
    required this.showersSum,
    required this.snowfallSum,
    required this.precipitationHours,
    required this.windspeed10MMax,
    required this.windgusts10MMax,
    required this.winddirection10MDominant,
    required this.shortwaveRadiationSum,
  });

  final String time;
  final String weathercode;
  final String temperature2MMax;
  final String temperature2MMin;
  final String apparentTemperatureMax;
  final String apparentTemperatureMin;
  final String sunrise;
  final String sunset;
  final String precipitationSum;
  final String rainSum;
  final String showersSum;
  final String snowfallSum;
  final String precipitationHours;
  final String windspeed10MMax;
  final String windgusts10MMax;
  final String winddirection10MDominant;
  final String shortwaveRadiationSum;

  factory DailyUnits.fromJson(Map<String, dynamic> json) => DailyUnits(
        time: json["time"],
        weathercode: json["weathercode"],
        temperature2MMax: json["temperature_2m_max"],
        temperature2MMin: json["temperature_2m_min"],
        apparentTemperatureMax: json["apparent_temperature_max"],
        apparentTemperatureMin: json["apparent_temperature_min"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        precipitationSum: json["precipitation_sum"],
        rainSum: json["rain_sum"],
        showersSum: json["showers_sum"],
        snowfallSum: json["snowfall_sum"],
        precipitationHours: json["precipitation_hours"],
        windspeed10MMax: json["windspeed_10m_max"],
        windgusts10MMax: json["windgusts_10m_max"],
        winddirection10MDominant: json["winddirection_10m_dominant"],
        shortwaveRadiationSum: json["shortwave_radiation_sum"],
      );
}
