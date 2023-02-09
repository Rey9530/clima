import 'package:clima_app/models/ciudades_model.dart';
import 'package:clima_app/models/clima_model.dart';
import 'package:clima_app/providers/conexiondes_provider.dart';
import 'package:flutter/material.dart';

class ShearchPlacesProvider extends ChangeNotifier {
  final conection = ConexionesProvider();
  List<Ciudad> listaCiudades = [];
  List<String> listaDias = [
    "Dom",
    "Lun",
    "Mar",
    "Mié",
    "Jue",
    "Vie",
    "Sáb",
    "Dom"
  ];
  RespClima? respClima;
  bool loading = false;
  obtenerCiudades(String query) async {
    if (query.isEmpty) {
      listaCiudades = [];
      notifyListeners();
      return;
    }
    loading = true;
    notifyListeners();
    Uri uri =
        Uri.parse("https://geocoding-api.open-meteo.com/v1/search?name=$query");
    final jsonData = await conection.customer_(uri);
    if (jsonData.statusCode == 200) {
      final resp = listadoCiudadesFromJson(jsonData.body);
      listaCiudades = resp.results ?? [];
      if (listaCiudades.length > 9) {
        listaCiudades = listaCiudades.sublist(0, 9);
      }
    }

    loading = false;
    notifyListeners();
    return jsonData.body;
  }

  Future<RespClima?> getDataClimate(Ciudad ciudad) async {
    String variables = "latitude=${ciudad.latitude}";
    variables = "$variables&longitude=${ciudad.longitude}";
    variables =
        "$variables&hourly=temperature_2m,relativehumidity_2m,apparent_temperature,precipitation,rain,showers";
    variables =
        "$variables&daily=weathercode,temperature_2m_max,temperature_2m_min,apparent_temperature_max,apparent_temperature_min,sunrise,sunset,precipitation_sum,rain_sum,showers_sum,snowfall_sum,precipitation_hours,windspeed_10m_max,windgusts_10m_max,winddirection_10m_dominant,shortwave_radiation_sum";
    variables = "$variables&current_weather=true";
    variables = "$variables&timezone=auto";

    Uri uri = Uri.parse("https://api.open-meteo.com/v1/forecast?$variables");
    final jsonData = await conection.customer_(uri);
    if (jsonData.statusCode == 200) {
      respClima = respClimaFromJson(jsonData.body);
      return respClima;
    }

    return null;
  }
}
