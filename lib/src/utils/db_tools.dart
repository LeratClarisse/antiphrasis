import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbTools {
  static Future<Database> initDB() async {
    Directory applicationDirectory = await getApplicationDocumentsDirectory();

    String dbPath = path.join(applicationDirectory.path, "app_db.db");

    bool dbExists = await File(dbPath).exists();

    if (!dbExists) {
      // Copy from asset
      ByteData data = await rootBundle.load(path.join("assets", "db", "app_db.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(dbPath).writeAsBytes(bytes, flush: true);
    }

    return openDatabase(dbPath);
  }

  static Future deleteDB() async {
    Directory applicationDirectory = await getApplicationDocumentsDirectory();

    String dbPath = path.join(applicationDirectory.path, "app_db.db");
    File dbFile = File(dbPath);

    await dbFile.delete();
  }
}
