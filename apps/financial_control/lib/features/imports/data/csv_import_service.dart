import 'dart:convert';

import 'package:csv/csv.dart';

class CsvImportService {
  const CsvImportService();

  String detectSource(String content) {
    final lower = content.toLowerCase();
    if (lower.contains('fecha contable') && lower.contains('saldo') && lower.contains('divisa')) {
      return 'bankinter';
    }
    if (lower.contains('mercado') && lower.contains('isin') && lower.contains('importe neto')) {
      return 'myinvestor';
    }
    if (lower.contains('date;type;isin;name;shares;amount;currency')) {
      return 'myinvestor';
    }
    if (lower.contains('fecha') && lower.contains('concepto') && lower.contains('importe')) {
      return 'myinvestor';
    }
    return 'generic';
  }

  List<Map<String, String>> parseRows(String csvContent) {
    final normalized = csvContent.replaceAll('\r\n', '\n').replaceAll('\r', '\n');
    final delimiter = _detectDelimiter(normalized);
    final parsed = CsvToListConverter(
      shouldParseNumbers: false,
      fieldDelimiter: delimiter,
      eol: '\n',
    ).convert(normalized);

    if (parsed.isEmpty) return const [];

    final headers = _dedupeHeaders(parsed.first.map((e) => e.toString().trim()).toList());
    final rows = <Map<String, String>>[];

    for (var i = 1; i < parsed.length; i++) {
      final row = parsed[i];
      if (row.every((cell) => cell.toString().trim().isEmpty)) {
        continue;
      }
      final mapped = <String, String>{};
      for (var j = 0; j < headers.length && j < row.length; j++) {
        mapped[headers[j]] = row[j].toString().replaceAll('\u00A0', ' ').trim();
      }
      mapped['__rawHash'] = _rowHash(mapped);
      rows.add(mapped);
    }
    return rows;
  }

  String normalizeAmount(String raw) {
    final cleaned = raw
        .replaceAll('€', '')
        .replaceAll(r'$', '')
        .replaceAll('£', '')
        .replaceAll(' ', '')
        .trim();

    if (cleaned.contains(',') && cleaned.contains('.')) {
      return cleaned.replaceAll('.', '').replaceAll(',', '.');
    }
    if (cleaned.contains(',')) {
      return cleaned.replaceAll(',', '.');
    }
    return cleaned;
  }

  DateTime? parseDate(String raw) {
    final value = raw.replaceAll('\u00A0', ' ').trim();
    if (value.isEmpty) return null;

    final dmy = RegExp(r'^(\d{2})\/(\d{2})\/(\d{4})$').firstMatch(value);
    if (dmy != null) {
      return DateTime(
        int.parse(dmy.group(3)!),
        int.parse(dmy.group(2)!),
        int.parse(dmy.group(1)!),
      );
    }

    final ymd = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$').firstMatch(value);
    if (ymd != null) {
      return DateTime(
        int.parse(ymd.group(1)!),
        int.parse(ymd.group(2)!),
        int.parse(ymd.group(3)!),
      );
    }

    return DateTime.tryParse(value);
  }

  String _detectDelimiter(String content) {
    final firstLine = content.split('\n').firstWhere((line) => line.trim().isNotEmpty, orElse: () => '');
    final semicolon = ';'.allMatches(firstLine).length;
    final comma = ','.allMatches(firstLine).length;
    return semicolon >= comma ? ';' : ',';
  }

  List<String> _dedupeHeaders(List<String> headers) {
    final seen = <String, int>{};
    return headers.map((header) {
      final normalized = header.isEmpty ? 'column' : header;
      final count = (seen[normalized] ?? 0) + 1;
      seen[normalized] = count;
      if (count == 1) return normalized;
      return '$normalized#$count';
    }).toList();
  }

  String _rowHash(Map<String, String> row) {
    final normalized = row.entries
        .where((e) => !e.key.startsWith('__'))
        .map((e) => '${e.key.toLowerCase()}:${e.value.toLowerCase().trim()}')
        .toList()
      ..sort();
    return base64Encode(utf8.encode(normalized.join('|')));
  }
}
