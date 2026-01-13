import 'package:flutter/material.dart';

import 'widget/poliklinik_list.dart';
import 'widget/poliklinik_search.dart';
import 'widget/poliklinik_table.dart';

class PoliklinikView extends StatefulWidget {
  const PoliklinikView({super.key});

  @override
  State<PoliklinikView> createState() => _PoliklinikViewState();
}

class _PoliklinikViewState extends State<PoliklinikView> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _query = '';

  final List<Map<String, String>> _poliklinik = List.generate(
    21,
    (i) => {'kode': 'Kode $i', 'nama_poli': 'poli $i'},
  );

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1024;

    final filteredPoliklinik = _poliklinik.where((u) {
      final q = _query.toLowerCase();
      return u['kode']!.toLowerCase().contains(q) ||
          u['nama_poli']!.toLowerCase().contains(q);
    }).toList();

    return Column(
      children: [
        PoliklinikSearch(
          controller: _searchCtrl,
          onChanged: (v) => setState(() => _query = v),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: isDesktop
              ? PoliklinikTable(poliklinik: filteredPoliklinik)
              : PoliklinikList(poliklinik: filteredPoliklinik),
        ),
      ],
    );
  }
}
