import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/scaffold_shell.dart';

class ImportPage extends StatelessWidget {
  const ImportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldShell(
      title: 'Importación CSV',
      selectedIndex: 3,
      onDestination: (index) => _navigate(context, index),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Arrastra o selecciona múltiples CSV/XLSX', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Detección automática de MyInvestor y Bankinter; asistente de mapeo para formato genérico.'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Card(
            child: ListTile(
              title: Text('Última importación'),
              subtitle: Text('Importadas: 120 · Duplicadas: 4 · Errores: 2'),
            ),
          )
        ],
      ),
    );
  }

  void _navigate(BuildContext context, int index) {
    const routes = ['/', '/transactions', '/investments', '/import', '/settings'];
    context.go(routes[index]);
  }
}
