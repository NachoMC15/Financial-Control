import 'package:decimal/decimal.dart';

class Money {
  Money(this.value, this.currency);

  final Decimal value;
  final String currency;

  Money operator +(Money other) {
    _assertSameCurrency(other);
    return Money(value + other.value, currency);
  }

  Money operator -(Money other) {
    _assertSameCurrency(other);
    return Money(value - other.value, currency);
  }

  void _assertSameCurrency(Money other) {
    if (currency != other.currency) {
      throw ArgumentError('Currency mismatch: $currency vs ${other.currency}');
    }
  }
}
