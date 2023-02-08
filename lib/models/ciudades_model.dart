import 'dart:convert';

ListadoCiudades listadoCiudadesFromJson(String str) =>
    ListadoCiudades.fromJson(json.decode(str));

class ListadoCiudades {
  ListadoCiudades({
    required this.results,
    required this.generationtimeMs,
  });

  final List<Ciudad>? results;
  final double generationtimeMs;

  factory ListadoCiudades.fromJson(Map<String, dynamic> json) =>
      ListadoCiudades(
        results: json["results"] != null
            ? List<Ciudad>.from(json["results"].map((x) => Ciudad.fromJson(x)))
            : null,
        generationtimeMs: json["generationtime_ms"].toDouble(),
      );
}

class Ciudad {
  Ciudad({
    this.id,
    this.name,
    this.latitude,
    this.longitude,
    this.elevation,
    this.featureCode,
    this.countryCode,
    this.admin1Id,
    this.timezone,
    this.population,
    this.countryId,
    this.country,
    this.admin1,
    this.admin2Id,
    this.admin3Id,
    this.postcodes,
    this.admin2,
    this.admin3,
  });

  final int? id;
  final String? name;
  final double? latitude;
  final double? longitude;
  final double? elevation;
  final String? featureCode;
  final String? countryCode;
  final int? admin1Id;
  final String? timezone;
  final int? population;
  final int? countryId;
  final String? country;
  final String? admin1;
  final int? admin2Id;
  final int? admin3Id;
  final List<String>? postcodes;
  final String? admin2;
  final String? admin3;

  factory Ciudad.fromJson(Map<String, dynamic> json) => Ciudad(
        id: json["id"],
        name: json["name"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        elevation: json["elevation"],
        featureCode: json["feature_code"],
        countryCode: json["country_code"],
        admin1Id: json["admin1_id"],
        timezone: json["timezone"],
        population: json["population"],
        countryId: json["country_id"],
        country: json["country"],
        admin1: json["admin1"],
        admin2Id: json["admin2_id"],
        admin3Id: json["admin3_id"],
        postcodes: json["postcodes"] != null
            ? List<String>.from(json["postcodes"].map((x) => x))
            : [],
        admin2: json["admin2"],
        admin3: json["admin3"],
      );
}
