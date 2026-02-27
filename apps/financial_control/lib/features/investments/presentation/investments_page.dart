import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/scaffold_shell.dart';

class InvestmentsPage extends StatelessWidget {
  const InvestmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldShell(
      title: 'Inversiones',
      selectedIndex: 2,
      onDestination: (index) => _navigate(context, index),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(
            child: ListTile(
              title: Text('Valor portfolio'),
              subtitle: Text('€91.235,44'),
              trailing: Text('+8,4%'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('MSCI World ETF'),
              subtitle: Text('120 unidades · coste medio €78,42'),
              trailing: Text('PnL +€1.245,10'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Fondo Indexado Europa'),
              subtitle: Text('320 participaciones · coste medio €12,10'),
              trailing: Text('PnL +€402,33'),
            ),
          ),
        ],
      ),
    );
  }

  void _navigate(BuildContext context, int index) {
    const routes = ['/', '/transactions', '/investments', '/import', '/settings'];
    context.go(routes[index]);
  }
}
