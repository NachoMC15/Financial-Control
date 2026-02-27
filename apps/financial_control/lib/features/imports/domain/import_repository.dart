import 'import_models.dart';

abstract class ImportRepository {
  Future<ImportRun> importCsvBatch(List<String> filePaths);
}
