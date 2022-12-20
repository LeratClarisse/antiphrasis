import 'dart:async';
import 'package:antiphrasis/src/models/group.dart';
import 'package:antiphrasis/src/utils/db_tools.dart';
import 'package:sqflite/sqflite.dart';

class GroupProvider {
  Future<List<Group>> fetchGroupList() async {
    Database db = await DbTools.initDB();
    final List<Map<String, dynamic>> maps;

    maps = await db.query('Group');

    List<Group> groups = List.generate(maps.length, (i) {
      return Group.fromJson(maps[i]);
    });

    DbTools.deleteDB();
    return groups;
  }
}
