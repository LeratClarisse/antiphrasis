class Group {
  final int id;
  final String name;

  const Group(this.id, this.name);

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(json['Id'], json['Name']);
  }
}