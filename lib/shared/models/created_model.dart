class Created {
  Created({required this.by, required this.on});

  final By? by;
  final DateTime? on;

  Created copyWith({By? by, DateTime? on}) {
    return Created(by: by ?? this.by, on: on ?? this.on);
  }

  factory Created.fromJson(Map<String, dynamic> json) {
    return Created(
      by: json["by"] == null ? null : By.fromJson(json["by"]),
      on: DateTime.tryParse(json["on"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() =>
      {"by": by?.toJson(), "on": on?.toIso8601String()};

  @override
  String toString() {
    return "$by, $on, ";
  }
}

class By {
  By({required this.id, required this.name});

  final String id;
  final String name;

  By copyWith({String? id, String? name}) {
    return By(id: id ?? this.id, name: name ?? this.name);
  }

  factory By.fromJson(Map<String, dynamic> json) {
    return By(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name};

  @override
  String toString() {
    return "$id, $name, ";
  }
}
