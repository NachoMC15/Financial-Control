import 'investment_models.dart';

abstract class InvestmentRepository {
  Future<void> addTrade(Trade trade);
  Future<List<Trade>> listTrades();
}
