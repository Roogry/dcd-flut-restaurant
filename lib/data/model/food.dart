class Food {
  String? name;

  Food({
    this.name,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
    };
  }
}
