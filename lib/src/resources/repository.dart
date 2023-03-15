import 'dart:async';
import 'package:antiphrasis/src/models/gamecard.dart';
import 'package:antiphrasis/src/models/group.dart';
import 'package:antiphrasis/src/resources/gamecard_provider.dart';
import 'package:antiphrasis/src/resources/group_provider.dart';

class Repository {
  final groupProvider = GroupProvider();
  final gameCardProvider = GameCardProvider();

  Future<List<Group>> fetchGroupList() => groupProvider.fetchGroupList();

  Future<List<GameCard>> fetchGamecardsForGroup(int groupId) => gameCardProvider.fetchGamecardsForGroup(groupId);
}
