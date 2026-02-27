import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class AppDatabase {
  Future<String> resolveDatabasePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return p.join(dir.path, 'financial_control.sqlite');
  }

  Future<File> ensureDatabaseFile() async {
    final dbPath = await resolveDatabasePath();
    final file = File(dbPath);
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
    return file;
  }
}
