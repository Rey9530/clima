// ignore_for_file: depend_on_referenced_packages, unused_import, avoid_print

import 'package:clima_app/models/ciudades_model.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

class DataBaseProvider extends ChangeNotifier {
  // Get a location using getDatabasesPath
  String databasesPath = "";
  String path = "";
  int version = 1;
  bool loading = false;
  List<Map> listadoCiudades = [];

  DataBaseProvider() {
    prepararVariables();
  }

  void prepararVariables() async {
    databasesPath = await getDatabasesPath();
    path = join(databasesPath, 'appclima.db');

    // open the database
    Database database = await openDatabase(path, version: version,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE ciudades (id_ciudad INTEGER PRIMARY KEY, id TEXT, name TEXT, latitude TEXT, longitude TEXT, elevation TEXT, featureCode TEXT, countryCode TEXT,admin1Id TEXT, timezone TEXT, population TEXT, countryId TEXT, country TEXT, admin1 TEXT,admin2Id TEXT,admin3Id TEXT, postcodes TEXT, admin2 TEXT,admin3 TEXT );');
    });
    await database.close();
    await obtenerCiudades();
  }

  Future<bool> insertarCiudad(
    Ciudad ciudad,
  ) async {
    loading = true;
    notifyListeners();

    Database database = await openDatabase(path, version: version);
    bool procesado = false;
    List<Map> list = await database.query('ciudades', where: "id=${ciudad.id}");
    if (list.isNotEmpty) {
      loading = false;
      notifyListeners();
      return false;
    }

    await database.transaction((txn) async {
      int id = 0;
      try {
        id = await txn.insert('ciudades', ciudad.toJson());
      } catch (e) {
        print(e.toString());
      }
      procesado = id > 0;
    });
    await database.close();
    await obtenerCiudades();
    loading = false;
    notifyListeners();
    return procesado;
  }

  Future<List<Map>> obtenerCiudades() async {
    Database database = await openDatabase(path, version: version);
    listadoCiudades = await database.query('ciudades');
    await database.close();
    notifyListeners();
    return listadoCiudades;
  }

  eliminarFavorito(String id) async {
    Database database = await openDatabase(path, version: version);
    final resp = await database.delete('ciudades', where: "id=$id");
    await database.close();
    await obtenerCiudades();
    return resp > 0;
  }
}
