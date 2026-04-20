import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'data/models.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/theme/app_theme.dart';

const String _apiBaseUrl = 'http://134.209.126.53/phpapi/api.php';

Uri _tableApiUri(String tableName) {
  return Uri.parse('$_apiBaseUrl?table=$tableName');
}

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

Future<List<T>> _fetchTable<T>({
  required String tableName,
  required T Function(Map<String, dynamic>) parser,
}) async {
  final response = await http
      .get(_tableApiUri(tableName))
      .timeout(const Duration(seconds: 10));
  if (response.statusCode != 200) {
    throw Exception(
      'API no disponible para tabla $tableName (${response.statusCode})',
    );
  }

  final items = _extractItems(response.body);
  return items.whereType<Map<String, dynamic>>().map(parser).toList();
}

Future<List<Sexo>> getSexos() {
  return _fetchTable(tableName: 'sexo', parser: Sexo.fromJson);
}

Future<List<Telefono>> getTelefonos() {
  return _fetchTable(tableName: 'telefono', parser: Telefono.fromJson);
}

Future<List<Estadocivil>> getEstadosCiviles() {
  return _fetchTable(tableName: 'estadocivil', parser: Estadocivil.fromJson);
}

Future<List<Direccion>> getDirecciones() {
  return _fetchTable(tableName: 'direccion', parser: Direccion.fromJson);
}

Future<List<Persona>> getPersonas() {
  return _fetchTable(tableName: 'persona', parser: Persona.fromJson);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Microsoft Equi Micros 6AA',
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
