class Group {
  final int id;
  final String name;
  int nbLevelsInGroup = 0;

  Group(this.id, this.name);

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(json['Id'], json['Name']);
  }
}
