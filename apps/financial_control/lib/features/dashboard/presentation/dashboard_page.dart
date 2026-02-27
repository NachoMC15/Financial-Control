import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/scaffold_shell.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldShell(
      title: 'Financial Control · Dashboard',
      selectedIndex: 0,
      onDestination: (index) => _navigate(context, index),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const [
              _KpiCard(title: 'Saldo total', value: '€128.450,20'),
              _KpiCard(title: 'Cashflow mensual', value: '+€1.230,15'),
              _KpiCard(title: 'Ahorro mensual', value: '32%'),
              _KpiCard(title: 'Dividendos YTD', value: '€743,11'),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Evolución 12 meses', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 220,
            child: LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    spots: const [
                      FlSpot(1, 90), FlSpot(2, 95), FlSpot(3, 97), FlSpot(4, 102),
                      FlSpot(5, 104), FlSpot(6, 110), FlSpot(7, 113), FlSpot(8, 114),
                      FlSpot(9, 116), FlSpot(10, 118), FlSpot(11, 124), FlSpot(12, 128),
                    ],
                  )
                ],
              ),
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

class _KpiCard extends StatelessWidget {
  const _KpiCard({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Card(
        child: ListTile(title: Text(title), subtitle: Text(value, style: const TextStyle(fontSize: 20))),
      ),
    );
  }
}
