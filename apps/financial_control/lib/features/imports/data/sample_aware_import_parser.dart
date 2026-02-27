import 'dart:io';

import 'package:excel/excel.dart';

import '../domain/normalized_import_models.dart';
import 'csv_import_service.dart';

class SampleAwareImportParser {
  SampleAwareImportParser({CsvImportService? csvService}) : _csvService = csvService ?? const CsvImportService();

  final CsvImportService _csvService;

  Future<List<NormalizedImportRow>> parseFile(String filePath) async {
    final extension = filePath.toLowerCase();
    if (extension.endsWith('.xlsx')) {
      final bytes = await File(filePath).readAsBytes();
      return _parseBankinterXlsx(bytes, sourceFile: filePath);
    }

    final content = await File(filePath).readAsString();
    final source = _csvService.detectSource(content);
    final rows = _csvService.parseRows(content);

    if (source == 'myinvestor') {
      return _parseMyInvestorRows(rows, sourceFile: filePath);
    }
    if (source == 'bankinter') {
      return _parseBankinterRows(rows, sourceFile: filePath);
    }
    return _parseGenericRows(rows, sourceFile: filePath);
  }

  List<NormalizedImportRow> _parseMyInvestorRows(
    List<Map<String, String>> rows, {
    required String sourceFile,
  }) {
    final result = <NormalizedImportRow>[];

    for (final row in rows) {
      final type = (row['Type'] ?? row['Operación#3'] ?? row['Operación'] ?? '').toLowerCase();
      final dateRaw = row['Date'] ?? row['Operación'] ?? row['Fecha'] ?? '';
      final date = _csvService.parseDate(dateRaw);
      if (date == null) continue;

      final amountRaw = row['Amount'] ?? row['Importe neto'] ?? '0';
      final currency = row['Currency'] ?? row['Divisa'] ?? 'EUR';

      final kind = switch (type) {
        'compra' || 'suscripcion' => NormalizedImportKind.investmentTrade,
        'venta' || 'reembolso' => NormalizedImportKind.investmentTrade,
        'intereses' => NormalizedImportKind.interest,
        'depósito' || 'deposito' => NormalizedImportKind.deposit,
        _ => NormalizedImportKind.unknown,
      };

      result.add(
        NormalizedImportRow(
          kind: kind,
          date: date,
          description: row['Name'] ?? row['Valor'] ?? type,
          amount: _csvService.normalizeAmount(amountRaw),
          currency: currency,
          isin: row['ISIN'],
          units: row['Shares'] ?? row['Títulos/NOMINAL'],
          price: row['Precio Neto'],
          sourceFile: sourceFile,
          rawHash: row['__rawHash'],
        ),
      );
    }

    return result;
  }

  List<NormalizedImportRow> _parseBankinterRows(
    List<Map<String, String>> rows, {
    required String sourceFile,
  }) {
    final result = <NormalizedImportRow>[];
    for (final row in rows) {
      final date = _csvService.parseDate(row['Fecha contable'] ?? row['Fecha'] ?? '');
      if (date == null) continue;
      final amount = row['Importe'] ?? '0';
      result.add(
        NormalizedImportRow(
          kind: NormalizedImportKind.bankTransaction,
          date: date,
          description: row['Descripción'] ?? row['Concepto'] ?? 'Movimiento',
          amount: _csvService.normalizeAmount(amount),
          currency: row['Divisa'] ?? 'EUR',
          sourceFile: sourceFile,
          rawHash: row['__rawHash'],
        ),
      );
    }
    return result;
  }

  List<NormalizedImportRow> _parseGenericRows(
    List<Map<String, String>> rows, {
    required String sourceFile,
  }) {
    final result = <NormalizedImportRow>[];
    for (final row in rows) {
      final date = _csvService.parseDate(row['date'] ?? row['Date'] ?? row['fecha'] ?? row['Fecha'] ?? '');
      if (date == null) continue;

      result.add(
        NormalizedImportRow(
          kind: NormalizedImportKind.unknown,
          date: date,
          description: row['description'] ?? row['Description'] ?? row['concept'] ?? 'Movimiento',
          amount: _csvService.normalizeAmount(row['amount'] ?? row['Amount'] ?? row['importe'] ?? '0'),
          currency: row['currency'] ?? row['Currency'] ?? row['divisa'] ?? 'EUR',
          sourceFile: sourceFile,
          rawHash: row['__rawHash'],
        ),
      );
    }
    return result;
  }

  List<NormalizedImportRow> _parseBankinterXlsx(
    List<int> bytes, {
    required String sourceFile,
  }) {
    final excel = Excel.decodeBytes(bytes);
    final sheet = excel.tables.values.first;
    final result = <NormalizedImportRow>[];

    for (final row in sheet.rows.skip(9)) {
      if (row.length < 6) continue;
      final dateRaw = row[0]?.value?.toString() ?? '';
      final description = row[2]?.value?.toString() ?? '';
      final amountRaw = row[3]?.value?.toString() ?? '';
      final currency = row[5]?.value?.toString() ?? 'EUR';

      final date = _csvService.parseDate(dateRaw);
      if (date == null || description.isEmpty) continue;

      result.add(
        NormalizedImportRow(
          kind: NormalizedImportKind.bankTransaction,
          date: date,
          description: description,
          amount: _csvService.normalizeAmount(amountRaw),
          currency: currency,
          sourceFile: sourceFile,
          rawHash: '${date.toIso8601String()}|$description|$amountRaw',
        ),
      );
    }

    return result;
  }
}
