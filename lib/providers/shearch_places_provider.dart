import 'package:clima_app/models/ciudades_model.dart';
import 'package:clima_app/providers/conexiondes_provider.dart';
import 'package:flutter/material.dart';

class ShearchPlacesProvider extends ChangeNotifier {
  final conection = ConexionesProvider();
  List<Ciudad> listaCiudades = [];
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
    }

    loading = false;
    notifyListeners();
    return jsonData.body;
  }
}
