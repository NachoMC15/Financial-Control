enum AssetType { stock, etf, fund, cash }
enum TradeType { buy, sell, switchIn, switchOut }
enum CorporateActionType { dividend, interest }

class Asset {
  Asset({required this.id, required this.name, required this.symbol, required this.type, this.isin});
  final String id;
  final String name;
  final String symbol;
  final AssetType type;
  final String? isin;
}

class Trade {
  Trade({
    required this.id,
    required this.accountId,
    required this.assetId,
    required this.type,
    required this.dateIso,
    required this.units,
    required this.price,
    required this.currency,
    required this.fees,
    required this.taxes,
  });

  final String id;
  final String accountId;
  final String assetId;
  final TradeType type;
  final String dateIso;
  final String units;
  final String price;
  final String currency;
  final String fees;
  final String taxes;
}
