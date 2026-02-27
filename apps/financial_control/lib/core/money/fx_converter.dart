import 'package:decimal/decimal.dart';

class FxRatePoint {
  FxRatePoint({required this.dateIso, required this.from, required this.to, required this.rate});
  final String dateIso;
  final String from;
  final String to;
  final Decimal rate;
}

class FxConverter {
  const FxConverter();

  Decimal convert(Decimal amount, List<FxRatePoint> rates) {
    if (rates.isEmpty) throw ArgumentError('No FX rates available');
    final sorted = [...rates]..sort((a, b) => a.dateIso.compareTo(b.dateIso));
    final latest = sorted.last;
    return amount * latest.rate;
  }
}
