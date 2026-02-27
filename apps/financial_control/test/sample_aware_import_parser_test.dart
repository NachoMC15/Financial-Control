import 'dart:io';

import 'package:financial_control/features/imports/data/sample_aware_import_parser.dart';
import 'package:financial_control/features/imports/domain/normalized_import_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final parser = SampleAwareImportParser();

  test('parsea cartera de fondos de MyInvestor', () async {
    final rows = await parser.parseFile('../../samples/cartera_fondos_hasta_27febrero2026.csv');
    expect(rows.isNotEmpty, true);
    expect(rows.first.kind, NormalizedImportKind.investmentTrade);
    expect(rows.first.isin?.isNotEmpty, true);
  });

  test('parsea depósitos e intereses de MyInvestor', () async {
    final rows = await parser.parseFile('../../samples/depositos comisiones y demás.csv');
    expect(rows.any((r) => r.kind == NormalizedImportKind.interest), true);
    expect(rows.any((r) => r.kind == NormalizedImportKind.deposit), true);
  });

  test('parsea xlsx de movimientos bankinter', () async {
    final file = File('../../samples/Movimientos_bankinter hasta 27 febrero 2026.xlsx');
    expect(await file.exists(), true);
    final rows = await parser.parseFile(file.path);
    expect(rows.isNotEmpty, true);
    expect(rows.first.kind, NormalizedImportKind.bankTransaction);
  });
}
