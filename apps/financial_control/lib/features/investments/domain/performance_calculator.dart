import 'package:decimal/decimal.dart';

class PerformanceCalculator {
  const PerformanceCalculator();

  Decimal simpleReturn({
    required Decimal initialValue,
    required Decimal finalValue,
    required Decimal contributions,
    required Decimal withdrawals,
  }) {
    return finalValue - contributions + withdrawals - initialValue;
  }

  Decimal unrealizedPnl({
    required Decimal units,
    required Decimal averageCost,
    required Decimal currentPrice,
  }) {
    return units * (currentPrice - averageCost);
  }
}
