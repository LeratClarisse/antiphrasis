import 'package:hive/hive.dart';

part 'gamecard.g.dart';

@HiveType(typeId: 0)
class GameCard {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String question;
  @HiveField(2)
  final String answer;
  @HiveField(3)
  final int done;
  @HiveField(4)
  final int groupId;

  const GameCard(this.id, this.question, this.answer, this.done, this.groupId);

  factory GameCard.fromJson(Map<String, dynamic> json) {
    return GameCard(json['Id'], json['Question'], json['Answer'], json['Done'], json['GroupId']);
  }
}
