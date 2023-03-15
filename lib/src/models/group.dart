import 'package:hive/hive.dart';

part 'group.g.dart';

@HiveType(typeId: 1)
class Group {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2, defaultValue: 0)
  int nbLevelsInGroup;

  Group(this.id, this.name, {this.nbLevelsInGroup = 0});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(json['Id'], json['Name']);
  }
}
