import 'dart:async';
import 'dart:convert';
import 'package:antiphrasis/src/models/group.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'gamecard_provider.dart';

class GroupProvider {
  Future<List<Group>> fetchGroupList() async {
    Box boxGroups = await Hive.openBox('groups');

    if (!boxGroups.containsKey('groupList')) {
      await _initGroupBox();
    }

    return boxGroups.get("groupList");
  }

  Future<void> _initGroupBox() async {
    Box boxGroups = await Hive.openBox('groups');
    final groupsJson = await rootBundle.loadString('assets/db/datas.json');

    List<Group> groups = List<Group>.from(json.decode(groupsJson)['groups'].map((model) => Group.fromJson(model)));

    for (Group group in groups) {
      group.nbLevelsInGroup = await GameCardProvider().countGamecardsInGroup(group.id);
    }

    boxGroups.put('groupList', groups);
  }
}
