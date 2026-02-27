import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/scaffold_shell.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldShell(
      title: 'Ajustes',
      selectedIndex: 4,
      onDestination: (index) => _navigate(context, index),
      body: ListView(
        children: const [
          ListTile(title: Text('Base currency'), subtitle: Text('EUR')),
          ListTile(title: Text('Idioma'), subtitle: Text('Español / English')),
          ListTile(title: Text('Seguridad'), subtitle: Text('PIN / biometría')),
          ListTile(title: Text('Exportar backup'), subtitle: Text('CSV / JSON cifrado')),
        ],
      ),
    );
  }

  void _navigate(BuildContext context, int index) {
    const routes = ['/', '/transactions', '/investments', '/import', '/settings'];
    context.go(routes[index]);
  }
}
