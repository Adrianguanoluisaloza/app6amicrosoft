import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'data/models.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/theme/app_theme.dart';

const String _sexoApiUrl = 'http://134.209.126.53/phpapi/api.php?table=sexo';
const String _telefonoApiUrl =
  'http://134.209.126.53/phpapi/api.php?table=telefono';
const String _estadocivilApiUrl =
  'http://134.209.126.53/phpapi/api.php?table=estadocivil';
const String _direccionApiUrl =
  'http://134.209.126.53/phpapi/api.php?table=direccion';
const String _personaApiUrl = 'http://134.209.126.53/phpapi/api.php?table=persona';

List<dynamic> _extractItems(String responseBody) {
  final decoded = json.decode(responseBody);
  if (decoded is List) {
    return decoded;
  }
  if (decoded is Map<String, dynamic>) {
    final items = decoded['items'];
    if (items is List) {
      return items;
    }
  }
  return <dynamic>[];
}

Future<List<T>> _fetchFromUrl<T>({
  required String url,
  required String tableLabel,
  required T Function(Map<String, dynamic>) parser,
}) async {
  http.Response response;
  try {
    response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
  } on TimeoutException {
    throw Exception('Tiempo de espera agotado para tabla $tableLabel');
  }

  if (response.statusCode != 200) {
    throw Exception(
      'API no disponible para tabla $tableLabel (${response.statusCode})',
    );
  }

  final items = _extractItems(response.body);
  return items.whereType<Map<String, dynamic>>().map(parser).toList();
}

Future<List<Sexo>> getSexos() {
  return _fetchFromUrl(url: _sexoApiUrl, tableLabel: 'sexo', parser: Sexo.fromJson);
}

Future<List<Telefono>> getTelefonos() {
  return _fetchFromUrl(
    url: _telefonoApiUrl,
    tableLabel: 'telefono',
    parser: Telefono.fromJson,
  );
}

Future<List<Estadocivil>> getEstadosCiviles() {
  return _fetchFromUrl(
    url: _estadocivilApiUrl,
    tableLabel: 'estadocivil',
    parser: Estadocivil.fromJson,
  );
}

Future<List<Direccion>> getDirecciones() {
  return _fetchFromUrl(
    url: _direccionApiUrl,
    tableLabel: 'direccion',
    parser: Direccion.fromJson,
  );
}

Future<List<Persona>> getPersonas() {
  return _fetchFromUrl(url: _personaApiUrl, tableLabel: 'persona', parser: Persona.fromJson);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Equipo micrisof 6A',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: MainScreen(
        getSexos: getSexos,
        getTelefonos: getTelefonos,
        getPersonas: getPersonas,
        getEstadosCiviles: getEstadosCiviles,
        getDirecciones: getDirecciones,
      ),
    );
  }
}
