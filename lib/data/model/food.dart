class Food {
  String? name;

  Food({
    this.name,
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
