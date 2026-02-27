enum ImportSourceType { myInvestor, generic }

class ImportFileResult {
  ImportFileResult({
    required this.fileName,
    required this.imported,
    required this.duplicates,
    required this.errors,
  });

  final String fileName;
  final int imported;
  final int duplicates;
  final int errors;
}

class ImportRun {
  ImportRun({
    required this.id,
    required this.startedAtIso,
    required this.source,
    required this.files,
    required this.importedRows,
    required this.duplicateRows,
    required this.errorRows,
  });

  final String id;
  final String startedAtIso;
  final ImportSourceType source;
  final List<String> files;
  final int importedRows;
  final int duplicateRows;
  final int errorRows;
}
