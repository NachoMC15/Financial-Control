class MyInvestorDetector {
  const MyInvestorDetector();

  bool isMyInvestor(List<String> headers) {
    final normalized = headers.map((h) => h.toLowerCase().trim()).toSet();
    const candidates = [
      {'fecha', 'concepto', 'importe'},
      {'fecha operación', 'isin', 'importe', 'título'},
      {'fecha', 'producto', 'dividendo', 'retención'}
    ];
    for (final c in candidates) {
      if (c.every(normalized.contains)) return true;
    }
    return false;
  }
}
