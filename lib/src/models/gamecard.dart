class GameCard {
  final int id;
  final String question;
  final String answer;
  final int done;
  final int groupId;

  const GameCard(this.id, this.question, this.answer, this.done, this.groupId);

  factory GameCard.fromJson(Map<String, dynamic> json) {
    return GameCard(json['Id'], json['Question'], json['Answer'], json['Done'], json['GroupId']);
  }
}