import 'package:flutter/material.dart';

class ScaffoldShell extends StatelessWidget {
  const ScaffoldShell({
    super.key,
    required this.title,
    required this.body,
    required this.selectedIndex,
    required this.onDestination,
  });

  final String title;
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestination;

  static const destinations = [
    NavigationDestination(icon: Icon(Icons.dashboard_outlined), label: 'Dashboard'),
    NavigationDestination(icon: Icon(Icons.receipt_long_outlined), label: 'Transacciones'),
    NavigationDestination(icon: Icon(Icons.trending_up_outlined), label: 'Inversiones'),
    NavigationDestination(icon: Icon(Icons.upload_file_outlined), label: 'Importar'),
    NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Ajustes'),
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.sizeOf(context).width >= 900;
    if (isDesktop) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: onDestination,
              labelType: NavigationRailLabelType.all,
              destinations: destinations
                  .map((d) => NavigationRailDestination(icon: d.icon, label: Text(d.label)))
                  .toList(),
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: Column(
                children: [
                  AppBar(title: Text(title)),
                  Expanded(child: body),
                ],
              ),
            )
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestination,
        destinations: destinations,
      ),
    );
  }
}
