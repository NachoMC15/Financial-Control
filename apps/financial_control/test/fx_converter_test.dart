import 'package:decimal/decimal.dart';
import 'package:financial_control/core/money/fx_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const converter = FxConverter();

  test('convierte con la última tasa disponible', () {
    final converted = converter.convert(
      Decimal.parse('100'),
      [
        FxRatePoint(dateIso: '2026-01-01', from: 'USD', to: 'EUR', rate: Decimal.parse('0.90')),
        FxRatePoint(dateIso: '2026-01-02', from: 'USD', to: 'EUR', rate: Decimal.parse('0.91')),
      ],
    );

    expect(converted, Decimal.parse('91.00'));
  });
}
