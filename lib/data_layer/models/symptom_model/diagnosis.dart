import 'package:healtether_clinic_app/data_layer/models/symptom_model/symptom.dart';

class Diagnosis {
  String id;
  String diseaseName;
  List<Symptom> associatedSymptom;
  String color;

  Diagnosis({
    required this.id,
    required this.diseaseName,
    required this.associatedSymptom,
    required this.color,
  });

  static const colors = [
    "0xFFADD8E6", // Light blue
    "0xFFF08080", // Light Coral
    "0xFF90EE90", // Light green
    "0xFFFFFFE0", // Light yellow
    "0xFFE0FFFF", // Light cyan
    "0xFFE6E6FA", //Lavender
    "0xFFB0C4DE", //Light Steel blue
    "0xFFF5F5DC", //beige
    "0xFFF5FFFA", //Mint cream
    "0xFFF0F0F0", //Honeydew
  ];

  factory Diagnosis.fromMap(Map<String, dynamic> map, int index) {
    return Diagnosis(
      id: index.toString(),
      diseaseName: map['disease_name'],
      associatedSymptom: (map['associated_symptoms'] as List).map((item) => Symptom(name: item, type: 'Sx')).toList(),
      color: colors[index % colors.length],
    );
  }
}
