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
      itemBuilder: (context, item) => recordCard(
        icon: Icons.wc,
        title: item.nombre,
        subtitleLines: ['ID: ${item.idsexo}'],
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
      itemBuilder: (context, item) => recordCard(
        icon: Icons.person,
        title: '${item.nombres} ${item.apellidos}',
        subtitleLines: [
          'ID: ${item.idpersona}',
          'Fecha: ${item.fechanacimiento}',
          'Sexo: ${item.elsexo}',
          'Estado civil: ${item.elestadocivil}',
        ],
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
