import 'dart:async';
import 'dart:convert';
import 'package:antiphrasis/src/models/gamecard.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GameCardProvider {
  Future<List<GameCard>> fetchGamecardsForGroup(int groupId) async {
    List<GameCard> gamecards = await _fetchGameCardList();
    return gamecards.where((g) => g.groupId == groupId).toList();
  }

  Future<int> countGamecardsInGroup(int groupId) async {
    List<GameCard> gamecards = await _fetchGameCardList();
    return gamecards.where((g) => g.groupId == groupId).length;
  }

  Future<List<GameCard>> _fetchGameCardList() async {
    Box boxGamecards = await Hive.openBox('gamecards');

    if (!boxGamecards.containsKey('gamecardList')) {
      await _initGamecardBox();
    }

    return boxGamecards.get("gamecardList");
  }

  Future<void> _initGamecardBox() async {
    Box boxGamecards = await Hive.openBox('gamecards');
    final gamecardsJson = await rootBundle.loadString('assets/db/datas.json');

    List<GameCard> groups = List<GameCard>.from(json.decode(gamecardsJson)['gamecards'].map((model) => GameCard.fromJson(model)));

    boxGamecards.put('gamecardList', groups);
  }
}
