import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class DataListPage<T> extends StatefulWidget {
  final Future<List<T>> Function() loader;
  final String searchHint;
  final bool Function(T item, String query) matcher;
  final Widget Function(BuildContext context, T item) itemBuilder;

  const DataListPage({
    super.key,
    required this.loader,
    required this.searchHint,
    required this.matcher,
    required this.itemBuilder,
  });

  @override
  State<DataListPage<T>> createState() => _DataListPageState<T>();
}

class _DataListPageState<T> extends State<DataListPage<T>> {
  late Future<List<T>> _future;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _future = widget.loader();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: const [
              _SkeletonSearch(),
              SizedBox(height: 12),
              _SkeletonCard(),
              SizedBox(height: 10),
              _SkeletonCard(),
              SizedBox(height: 10),
              _SkeletonCard(),
            ],
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.cloud_off, size: 48, color: Colors.redAccent),
                  const SizedBox(height: 10),
                  const Text(
                    'No se pudo obtener datos del API.',
                    style: TextStyle(fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    snapshot.error.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
          );
        }

        final items = snapshot.data ?? <T>[];
        final filtered = items.where((e) => widget.matcher(e, _query)).toList();

        return RefreshIndicator(
          onRefresh: () async {
            final updated = widget.loader();
            setState(() {
              _future = updated;
            });
            await updated;
          },
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _searchBox(),
              const SizedBox(height: 12),
              if (filtered.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 48),
                  child: Center(child: Text('No hay resultados para este filtro.')),
                )
              else
                ...filtered.asMap().entries.map(
                      (entry) => _StaggeredItem(
                        index: entry.key,
                        child: widget.itemBuilder(context, entry.value),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }

  Widget _searchBox() {
    return TextField(
      onChanged: (value) {
        setState(() {
          _query = value;
        });
      },
      decoration: InputDecoration(
        hintText: widget.searchHint,
        prefixIcon: const Icon(Icons.search, color: Color(0xFF0E4A7B)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusLg),
          borderSide: const BorderSide(color: AppTokens.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusLg),
          borderSide: const BorderSide(color: AppTokens.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusLg),
          borderSide: const BorderSide(color: AppTokens.brand700, width: 1.4),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}

class _StaggeredItem extends StatefulWidget {
  final int index;
  final Widget child;

  const _StaggeredItem({required this.index, required this.child});

  @override
  State<_StaggeredItem> createState() => _StaggeredItemState();
}

class _StaggeredItemState extends State<_StaggeredItem> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 45 * widget.index), () {
      if (mounted) {
        setState(() {
          _visible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: AppTokens.motionBase,
      offset: _visible ? Offset.zero : const Offset(0, 0.08),
      curve: Curves.easeOutCubic,
      child: AnimatedOpacity(
        duration: AppTokens.motionBase,
        opacity: _visible ? 1 : 0,
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}

class _SkeletonSearch extends StatelessWidget {
  const _SkeletonSearch();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: const Color(0xFFE7EDF5),
        borderRadius: BorderRadius.circular(AppTokens.radiusLg),
      ),
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      decoration: BoxDecoration(
        color: const Color(0xFFE7EDF5),
        borderRadius: BorderRadius.circular(AppTokens.radiusLg),
      ),
    );
  }
}

Widget recordCard({
  required IconData icon,
  required String title,
  required List<String> subtitleLines,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFD6E1EE)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x120E2B4D),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: const Color(0xFFE6F0FA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: const Color(0xFF0E4A7B)),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: subtitleLines.map((line) => Text(line)).toList(),
        ),
      ),
    ),
  );
}
