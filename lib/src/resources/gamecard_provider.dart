import 'dart:async';
import 'package:antiphrasis/src/models/gamecard.dart';
import 'package:antiphrasis/src/utils/db_tools.dart';
import 'package:sqflite/sqflite.dart';

class GameCardProvider {
  Future<List<GameCard>> fetchGameCardListForGroup(int groupdId) async {
    Database db = await DbTools.initDB();
    final List<Map<String, dynamic>> maps;

    maps = await db.query('Group', where: 'GroupId = ?', whereArgs: [groupdId]);

    List<GameCard> gamecards = List.generate(maps.length, (i) {
      return GameCard.fromJson(maps[i]);
    });

    DbTools.deleteDB();
    return gamecards;
  }
}
