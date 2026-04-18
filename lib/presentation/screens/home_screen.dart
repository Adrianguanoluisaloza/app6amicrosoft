import 'package:flutter/material.dart';

import '../../data/api_repository.dart';
import '../../data/models.dart';
import '../theme/app_theme.dart';
import '../widgets/data_list_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ApiRepository _repository = ApiRepository();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Equipo Microsoft 6AA'),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppTokens.brand700.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                'Equipo Microsoft',
                style: TextStyle(
                  color: AppTokens.brand700,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ],
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Sexo'),
              Tab(text: 'Telefonos'),
              Tab(text: 'Personas'),
              Tab(text: 'Estado Civil'),
              Tab(text: 'Direcciones'),
              Tab(text: 'Info'),
            ],
          ),
        ),
        body: Column(
          children: [
            _DashboardStrip(repository: _repository),
            Expanded(
              child: TabBarView(
                children: [
                  SexoPage(repository: _repository),
                  TelefonoPage(repository: _repository),
                  PersonaPage(repository: _repository),
                  EstadocivilPage(repository: _repository),
                  DireccionPage(repository: _repository),
                  const AboutPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardStrip extends StatelessWidget {
  final ApiRepository repository;

  const _DashboardStrip({required this.repository});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
      future: Future.wait<int>([
        repository.getSexos().then((v) => v.length),
        repository.getPersonas().then((v) => v.length),
        repository.getDirecciones().then((v) => v.length),
        repository.getTelefonos().then((v) => v.length),
        repository.getEstadosCiviles().then((v) => v.length),
      ]),
      builder: (context, snapshot) {
        final values = snapshot.data ?? [0, 0, 0, 0, 0];

        return SizedBox(
          height: 98,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            scrollDirection: Axis.horizontal,
            children: [
              _MetricCard(label: 'Sexos', value: values[0], icon: Icons.wc),
              _MetricCard(label: 'Personas', value: values[1], icon: Icons.people),
              _MetricCard(label: 'Direcciones', value: values[2], icon: Icons.location_city),
              _MetricCard(label: 'Telefonos', value: values[3], icon: Icons.phone),
              _MetricCard(label: 'Estados', value: values[4], icon: Icons.badge),
            ],
          ),
        );
      },
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final int value;
  final IconData icon;

  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 164,
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTokens.radiusLg),
        border: Border.all(color: AppTokens.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppTokens.brand700.withValues(alpha: 0.12),
            child: Icon(icon, size: 18, color: AppTokens.brand700),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '$value',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SexoPage extends StatelessWidget {
  final ApiRepository repository;

  const SexoPage({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return DataListPage<Sexo>(
      loader: repository.getSexos,
      searchHint: 'Buscar sexo por nombre o ID',
      matcher: (item, query) {
        final q = query.toLowerCase();
        return item.nombre.toLowerCase().contains(q) || item.idsexo.contains(q);
      },
      itemBuilder: (context, item) => _SexoCard(sexo: item),
    );
  }
}

class _SexoCard extends StatelessWidget {
  final Sexo sexo;

  const _SexoCard({required this.sexo});

  Color get _tone {
    final value = sexo.nombre.toLowerCase();
    if (value.contains('mas') || value.contains('hom')) return const Color(0xFF1C6BB0);
    if (value.contains('fem') || value.contains('muj')) return const Color(0xFFB0456B);
    return const Color(0xFF0EA5A5);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFFFFF), Color(0xFFF7FAFE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFD7E3F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A123A61),
            blurRadius: 14,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: _tone.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(Icons.wc, color: _tone),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sexo.nombre,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF142B3F),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Codigo: ${sexo.idsexo}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF5E7388),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: _tone.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: _tone.withValues(alpha: 0.35)),
              ),
              child: Text(
                sexo.idsexo,
                style: TextStyle(
                  color: _tone,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TelefonoPage extends StatelessWidget {
  final ApiRepository repository;

  const TelefonoPage({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return DataListPage<Telefono>(
      loader: repository.getTelefonos,
      searchHint: 'Buscar telefono por numero o ID',
      matcher: (item, query) {
        final q = query.toLowerCase();
        return item.numero.toLowerCase().contains(q) || item.idtelefono.contains(q);
      },
      itemBuilder: (context, item) => recordCard(
        icon: Icons.phone,
        title: item.numero,
        subtitleLines: ['ID: ${item.idtelefono}'],
      ),
    );
  }
}

class EstadocivilPage extends StatelessWidget {
  final ApiRepository repository;

  const EstadocivilPage({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return DataListPage<Estadocivil>(
      loader: repository.getEstadosCiviles,
      searchHint: 'Buscar estado civil por nombre o ID',
      matcher: (item, query) {
        final q = query.toLowerCase();
        return item.nombre.toLowerCase().contains(q) || item.idestadocivil.contains(q);
      },
      itemBuilder: (context, item) => recordCard(
        icon: Icons.favorite,
        title: item.nombre,
        subtitleLines: ['ID: ${item.idestadocivil}'],
      ),
    );
  }
}

class DireccionPage extends StatelessWidget {
  final ApiRepository repository;

  const DireccionPage({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return DataListPage<Direccion>(
      loader: repository.getDirecciones,
      searchHint: 'Buscar direccion, persona o ID',
      matcher: (item, query) {
        final q = query.toLowerCase();
        return item.nombre.toLowerCase().contains(q) ||
            item.personaNombre.toLowerCase().contains(q) ||
            item.iddireccion.contains(q);
      },
      itemBuilder: (context, item) => recordCard(
        icon: Icons.location_on,
        title: item.nombre,
        subtitleLines: ['ID: ${item.iddireccion}', 'Persona: ${item.personaNombre}'],
      ),
    );
  }
}

class PersonaPage extends StatelessWidget {
  final ApiRepository repository;

  const PersonaPage({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return DataListPage<Persona>(
      loader: repository.getPersonas,
      searchHint: 'Buscar persona por nombre, apellido o fecha',
      matcher: (item, query) {
        final q = query.toLowerCase();
        return item.nombres.toLowerCase().contains(q) ||
            item.apellidos.toLowerCase().contains(q) ||
            item.fechanacimiento.toLowerCase().contains(q);
      },
      // ── Diseño mejorado por Tadeo Ballesteros ──
      itemBuilder: (context, item) => _PersonaCard(persona: item),
    );
  }
}

class _PersonaCard extends StatelessWidget {
  final Persona persona;

  const _PersonaCard({required this.persona});

  // Iniciales del avatar
  String get _initials {
    final n = persona.nombres.isNotEmpty ? persona.nombres[0] : '';
    final a = persona.apellidos.isNotEmpty ? persona.apellidos[0] : '';
    return '$n$a'.toUpperCase();
  }

  // Color según sexo
  Color get _avatarColor {
    final sexo = persona.elsexo.toLowerCase();
    if (sexo.contains('mas') || sexo.contains('hom')) return const Color(0xFF1C6BB0);
    if (sexo.contains('fem') || sexo.contains('muj')) return const Color(0xFFB0456B);
    return const Color(0xFF0EA5A5);
  }

  // Color chip estado civil
  Color get _estadoColor {
    final e = persona.elestadocivil.toLowerCase();
    if (e.contains('solt')) return const Color(0xFF0EA5A5);
    if (e.contains('cas'))  return const Color(0xFF2E7D32);
    if (e.contains('divor')) return const Color(0xFFB0456B);
    return const Color(0xFF16548A);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFD6E1EE)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x180E2B4D),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar con iniciales
            CircleAvatar(
              radius: 26,
              backgroundColor: _avatarColor,
              child: Text(
                _initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nombre completo
                  Text(
                    '${persona.nombres} ${persona.apellidos}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: Color(0xFF13283A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // ID y fecha
                  Text(
                    'ID: ${persona.idpersona}  ·  Nac: ${persona.fechanacimiento}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF5A6D80),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Chips sexo + estado civil
                  Wrap(
                    spacing: 6,
                    children: [
                      _Chip(label: persona.elsexo, color: _avatarColor),
                      _Chip(label: persona.elestadocivil, color: _estadoColor),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final Color color;

  const _Chip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppTokens.brand700, AppTokens.accent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppTokens.radiusXl),
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(22),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppTokens.radiusLg),
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.auto_awesome, size: 56),
                SizedBox(height: 12),
                Text(
                  'EQUIPO MICROSOFT 6A',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Integrantes:\nFranco Alex Guanoluisa\nAdrian Lely Alvarado\nDavid Corozo\nAngel Ballesteros',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
