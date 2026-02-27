import 'package:decimal/decimal.dart';
import 'package:financial_control/features/investments/domain/performance_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const calculator = PerformanceCalculator();

  test('calcula retorno simple', () {
    final r = calculator.simpleReturn(
      initialValue: Decimal.parse('10000'),
      finalValue: Decimal.parse('14000'),
      contributions: Decimal.parse('2500'),
      withdrawals: Decimal.parse('200'),
    );
    expect(r, Decimal.parse('1700'));
  });

  test('calcula pnl no realizado', () {
    final pnl = calculator.unrealizedPnl(
      units: Decimal.parse('10'),
      averageCost: Decimal.parse('20'),
      currentPrice: Decimal.parse('25.5'),
    );
    expect(pnl, Decimal.parse('55.0'));
  });
}
