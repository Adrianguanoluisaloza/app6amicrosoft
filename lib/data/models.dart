class Sexo {
  final String idsexo;
  final String nombre;

  const Sexo({required this.idsexo, required this.nombre});

  factory Sexo.fromJson(Map<String, dynamic> json) {
    return Sexo(
      idsexo: (json['idsexo'] ?? json['id'] ?? '').toString(),
      nombre: (json['nombre'] ?? 'N/A').toString(),
    );
  }
}

class Telefono {
  final String idtelefono;
  final String numero;

  const Telefono({required this.idtelefono, required this.numero});

  factory Telefono.fromJson(Map<String, dynamic> json) {
    return Telefono(
      idtelefono: (json['idtelefono'] ?? '').toString(),
      numero: (json['numero'] ?? 'N/A').toString(),
    );
  }
}

class Estadocivil {
  final String idestadocivil;
  final String nombre;

  const Estadocivil({required this.idestadocivil, required this.nombre});

  factory Estadocivil.fromJson(Map<String, dynamic> json) {
    return Estadocivil(
      idestadocivil: (json['idestadocivil'] ?? '').toString(),
      nombre: (json['nombre'] ?? 'N/A').toString(),
    );
  }
}

class Direccion {
  final String iddireccion;
  final String nombre;
  final String personaNombre;

  const Direccion({
    required this.iddireccion,
    required this.nombre,
    required this.personaNombre,
  });

  factory Direccion.fromJson(Map<String, dynamic> json) {
    final personaNombre = (json['persona_nombre'] ?? '').toString();
    final personaNombres = (json['persona_nombres'] ?? '').toString();
    final personaApellidos = (json['persona_apellidos'] ?? '').toString();
    final personaFallback = '$personaNombres $personaApellidos'.trim();

    return Direccion(
      iddireccion: (json['iddireccion'] ?? '').toString(),
      nombre: (json['nombre'] ?? 'N/A').toString(),
      personaNombre: personaNombre.isNotEmpty
          ? personaNombre
          : (personaFallback.isNotEmpty ? personaFallback : 'N/A'),
    );
  }
}

class Persona {
  final String idpersona;
  final String nombres;
  final String apellidos;
  final String elsexo;
  final String elestadocivil;
  final String fechanacimiento;

  const Persona({
    required this.idpersona,
    required this.nombres,
    required this.apellidos,
    required this.elsexo,
    required this.elestadocivil,
    required this.fechanacimiento,
  });

  factory Persona.fromJson(Map<String, dynamic> json) {
    return Persona(
      idpersona: (json['idpersona'] ?? '').toString(),
      nombres: (json['nombres'] ?? 'N/A').toString(),
      apellidos: (json['apellidos'] ?? 'N/A').toString(),
      elsexo: (json['sexo_nombre'] ?? json['elsexo'] ?? 'N/A').toString(),
      elestadocivil:
          (json['estadocivil_nombre'] ?? json['elestadocivil'] ?? 'N/A')
              .toString(),
      fechanacimiento: (json['fechanacimiento'] ?? 'N/A').toString(),
    );
  }
}
