// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:uuid/uuid.dart';

class HistoryItem {
  final String id;
  final String name;
  final String year;
  HistoryItem({
    required this.id,
    required this.name,
    required this.year,
  });

  HistoryItem copyWith({
    String? name,
    String? year,
  }) {
    return HistoryItem(
      id: id,
      name: name ?? this.name,
      year: year ?? this.year,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      "duration": () {
        if (year.isNotEmpty) {
          return {"value": int.parse(year), "unit": int.parse(year) == 1 ? "Year" : "Years"};
        } else {
          return {"value": 0, "unit": ""};
        }
      }(),
      "notes": ""
    };
  }

  factory HistoryItem.fromMap(Map<String, dynamic> map) {
    return HistoryItem(
      id: map['_id'],
      name: map['name'],
      year: map['duration']?['value']?.toString() ?? '',
    );
  }

  factory HistoryItem.empty() {
    return HistoryItem(id: const Uuid().v4(), name: '', year: '');
  }

  @override
  String toString() => 'HistoryItem(name: $name, year: $year)';

  @override
  bool operator ==(covariant HistoryItem other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
