enum TransactionType { income, expense, transfer, fee, adjustment }

class Account {
  Account({required this.id, required this.name, required this.currency});
  final String id;
  final String name;
  final String currency;
}

class TransactionEntry {
  TransactionEntry({
    required this.id,
    required this.accountId,
    required this.dateIso,
    required this.description,
    required this.amount,
    required this.currency,
    required this.type,
    this.categoryId,
    this.importedSource,
    this.importedRowHash,
  });

  final String id;
  final String accountId;
  final String dateIso;
  final String description;
  final String amount;
  final String currency;
  final TransactionType type;
  final String? categoryId;
  final String? importedSource;
  final String? importedRowHash;
}
