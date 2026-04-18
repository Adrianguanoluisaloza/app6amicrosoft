import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models.dart';

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

class ApiRepository {
  Future<List<T>> _fetch<T>({
    required Uri uri,
    required T Function(Map<String, dynamic>) parser,
  }) async {
    final response = await http.get(uri).timeout(const Duration(seconds: 10));
    if (response.statusCode != 200) {
      throw Exception('API no disponible (${response.statusCode})');
    }

    return _extractItems(response.body)
        .whereType<Map<String, dynamic>>()
        .map(parser)
        .toList();
  }

  Future<List<Sexo>> getSexos() {
    return _fetch(uri: _tableApiUri('sexo'), parser: Sexo.fromJson);
  }

  Future<List<Telefono>> getTelefonos() {
    return _fetch(uri: _tableApiUri('telefono'), parser: Telefono.fromJson);
  }

  Future<List<Estadocivil>> getEstadosCiviles() {
    return _fetch(uri: _tableApiUri('estadocivil'), parser: Estadocivil.fromJson);
  }

  Future<List<Direccion>> getDirecciones() {
    return _fetch(uri: _tableApiUri('direccion'), parser: Direccion.fromJson);
  }

  Future<List<Persona>> getPersonas() {
    return _fetch(uri: _tableApiUri('persona'), parser: Persona.fromJson);
  }
}
