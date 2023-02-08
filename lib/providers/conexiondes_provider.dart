import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CodeResponseHttp {
  CodeResponseHttp({
    required this.statusCode,
    required this.body,
  });

  dynamic body;
  int statusCode;

  factory CodeResponseHttp.fromJson(Map<String, dynamic> json) =>
      CodeResponseHttp(
        statusCode: json["statusCode"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "body": body,
      };
}

class ConexionesProvider extends ChangeNotifier {
  Map<String, String> requestHeaders = {'Accept': '*/*'};
  CodeResponseHttp errorConexion = CodeResponseHttp(
    body:
        ' { "status": 401, "message": "No se ha detectado conexión a internet", "info": {"data": null} }',
    statusCode: 401,
  );
  bool conected = true;
  ConexionesProvider() {
    verifyConection();
  }

  customer_(Uri uri,
      [Map<String, dynamic>? queryParameters,
      Map<String, String>? headers]) async {
    http.Response response;

    try {
      response = await http
          .get(uri, headers: requestHeaders)
          .timeout(const Duration(seconds: 30));
    } on TimeoutException catch (_) {
      throw ('Tiempo de espera alcanzado');
    } on SocketException {
      throw ('Sin internet  o falla de servidor ');
    } on HttpException {
      throw ("No se encontro esa peticion");
    } on FormatException {
      throw ("Formato erroneo ");
    }
    return response;
  }

  verifyConection() async {
    conected = true;
    // var connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.mobile) {
    //   conected = true;
    //   // I am connected to a mobile network.
    // } else if (connectivityResult == ConnectivityResult.wifi) {
    //   conected = true;
    //   // I am connected to a wifi network.
    // } else {
    //   conected = false;
    //   notifyListeners();
    // }
    return conected;
  }
}
