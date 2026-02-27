import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import '../dashboard/presentation/dashboard_page.dart';
import '../imports/presentation/import_page.dart';
import '../investments/presentation/investments_page.dart';
import '../personal_finance/presentation/transactions_page.dart';
import '../settings/presentation/settings_page.dart';

class FinancialControlApp extends StatelessWidget {
  const FinancialControlApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => const DashboardPage()),
        GoRoute(path: '/transactions', builder: (context, state) => const TransactionsPage()),
        GoRoute(path: '/investments', builder: (context, state) => const InvestmentsPage()),
        GoRoute(path: '/import', builder: (context, state) => const ImportPage()),
        GoRoute(path: '/settings', builder: (context, state) => const SettingsPage()),
      ],
    );

    return MaterialApp.router(
      title: 'Financial Control',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0066CC)),
        useMaterial3: true,
      ),
      routerConfig: router,
      supportedLocales: const [Locale('es'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
