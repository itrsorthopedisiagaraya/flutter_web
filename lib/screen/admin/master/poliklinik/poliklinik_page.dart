import 'package:flutter/material.dart';

import 'poliklinik_view.dart';

class PoliklinikPage extends StatelessWidget {
  const PoliklinikPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Poli Klinik')),
      body: Material(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: PoliklinikView(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
