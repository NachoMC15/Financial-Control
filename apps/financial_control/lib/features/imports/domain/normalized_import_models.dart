enum NormalizedImportKind {
  bankTransaction,
  investmentTrade,
  interest,
  dividend,
  deposit,
  unknown,
}

class NormalizedImportRow {
  NormalizedImportRow({
    required this.kind,
    required this.date,
    required this.description,
    required this.amount,
    required this.currency,
    this.isin,
    this.units,
    this.price,
    this.sourceFile,
    this.rawHash,
  });

  final NormalizedImportKind kind;
  final DateTime date;
  final String description;
  final String amount;
  final String currency;
  final String? isin;
  final String? units;
  final String? price;
  final String? sourceFile;
  final String? rawHash;
}
