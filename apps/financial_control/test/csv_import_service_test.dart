import 'package:financial_control/features/imports/data/csv_import_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const service = CsvImportService();

  test('detecta myinvestor por cabecera', () {
    const csv = 'Fecha;Concepto;Importe\n01/01/2026;Nómina;2800,00';
    expect(service.detectSource(csv), 'myinvestor');
  });

  test('genera hash por fila y parsea', () {
    const csv = 'date,description,amount\n2026-01-01,Salary,1000.00';
    final rows = service.parseRows(csv);
    expect(rows.length, 1);
    expect(rows.first.containsKey('__rawHash'), true);
  });
}
