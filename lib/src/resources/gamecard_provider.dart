import 'dart:async';
import 'dart:convert';
import 'package:antiphrasis/src/models/gamecard.dart';
import 'package:antiphrasis/src/utils/db_tools.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class GameCardProvider {
  Future<List<GameCard>> fetchGameCardListForGroup(int groupdId) async {
    if (!kIsWeb) {
      Database db = await DbTools.initDB();
      final List<Map<String, dynamic>> maps;

      maps = await db.query('GameCard', where: 'GroupId = ?', whereArgs: [groupdId]);

      List<GameCard> gamecards = List.generate(maps.length, (i) {
        return GameCard.fromJson(maps[i]);
      });

      DbTools.deleteDB();
      return gamecards;
    } else {
      final gamecardJson = await rootBundle.loadString('assets/db/gamecards.json');

      if (gamecardJson.isNotEmpty) {
        Iterable l = json.decode(gamecardJson)['gamecards'];
        List<GameCard> gamecards = List<GameCard>.from(l.map((model) => GameCard.fromJson(model)));

        gamecards = gamecards.where((q) => q.groupId == groupdId).toList();

        return gamecards;
      } else {
        throw Exception('Failed to load game cards');
      }
    }
  }
}
