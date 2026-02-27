import 'personal_finance_models.dart';

abstract class TransactionRepository {
  Future<void> upsert(TransactionEntry entry);
  Future<List<TransactionEntry>> list();
}
