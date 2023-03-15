import 'package:antiphrasis/src/models/gamecard.dart';
import 'package:antiphrasis/src/models/group.dart';
import 'package:antiphrasis/src/resources/group_provider.dart';
import 'package:flutter/material.dart';
import 'src/app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(GameCardAdapter());
  Hive.registerAdapter(GroupAdapter());

  // App version from pubspec.yaml
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String appVersion = packageInfo.version;
  // App version from Hive
  Box settingBox = await Hive.openBox('settings');
  String? boxAppVersion = await settingBox.get('version');
  await settingBox.close();

  if (boxAppVersion != null && appVersion != boxAppVersion) {
    Hive.openBox('gamecards');
    Hive.openBox('groups');
    Hive.deleteFromDisk(); // Delete open boxes

    // Save new version in Hive
    (await Hive.openBox('settings')).put('version', appVersion);
  }

  // Init group box to speed up pages load
  GroupProvider().fetchGroupList();

  return runApp(const App());
}
