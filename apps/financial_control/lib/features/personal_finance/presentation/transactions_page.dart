import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/scaffold_shell.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldShell(
      title: 'Transacciones',
      selectedIndex: 1,
      onDestination: (index) => _navigate(context, index),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                SizedBox(width: 180, child: TextField(decoration: InputDecoration(labelText: 'Buscar texto'))),
                SizedBox(width: 150, child: TextField(decoration: InputDecoration(labelText: 'Categoría'))),
                SizedBox(width: 150, child: TextField(decoration: InputDecoration(labelText: 'Cuenta'))),
              ],
            ),
          ),
          const Expanded(child: _TransactionList())
        ],
      ),
    );
  }

  void _navigate(BuildContext context, int index) {
    const routes = ['/', '/transactions', '/investments', '/import', '/settings'];
    context.go(routes[index]);
  }
}

class _TransactionList extends StatelessWidget {
  const _TransactionList();

  @override
  Widget build(BuildContext context) {
    final items = [
      ('2026-02-25', 'Nómina', '+2.800,00 €'),
      ('2026-02-24', 'Supermercado', '-84,25 €'),
      ('2026-02-24', 'Transferencia broker', '-500,00 €'),
    ];
    return ListView.separated(
      itemBuilder: (_, i) => ListTile(
        leading: const Icon(Icons.receipt_long),
        title: Text(items[i].$2),
        subtitle: Text(items[i].$1),
        trailing: Text(items[i].$3),
      ),
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemCount: items.length,
    );
  }
}
