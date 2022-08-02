class ContacModel {
  ContacModel({
    this.id = 0,
    required this.name,
    required this.number,
  });

  int id;
  String name;
  String number;

  Map<String, dynamic> toJson() => {
        "name": name,
        "number": number,
      };
}
