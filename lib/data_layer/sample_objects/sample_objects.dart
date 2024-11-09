import 'package:healtether_clinic_app/data_layer/models/allergies/allergies.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_models/appointment_model.dart';
import 'package:healtether_clinic_app/data_layer/models/lab_tests/lab_tests.dart';
import 'package:healtether_clinic_app/data_layer/models/patient_records_model/appointments_model.dart';
// import 'package:healtether_clinic_app/data_layer/models/appointmentdata.dart';
import 'package:healtether_clinic_app/data_layer/models/patient_records_model/patient_model.dart';
import 'package:healtether_clinic_app/data_layer/models/symptom_model/symptom.dart';
import 'package:healtether_clinic_app/data_layer/models/drug_model/drug_model.dart';
import 'package:uuid/uuid.dart';

class SampleObjects {
  static final List<LabTest> availableTests = [
    const LabTest(name: "CBC"),
    const LabTest(name: "Hemoglobin"),
    const LabTest(name: "TSH"),
    const LabTest(name: "TSH, T1, T2, T3"),
    const LabTest(name: "CMC"),
    const LabTest(name: "Lipid profile"),
    const LabTest(name: "KIR"),
    const LabTest(name: "KIDNEY"),
    const LabTest(name: "Heart"),
    const LabTest(name: "Liver"),
    const LabTest(name: "Lungs"),
    const LabTest(name: "Sugar level"),
  ];

  static List<String> dosageFrequency = ['SOS', 'Stat', '1-1-1', '1-0-1', '1-0-0', '0-0-1', '0-1-0', '0-1-1', 'Other'];

  static final List<Allergy> allergies = [
    Allergy(id: const Uuid().v4(), name: 'Peanut Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Shellfish Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Egg Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Milk Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Wheat Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Soy Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Tree Nut Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Fish Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Latex Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Insect Sting Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Penicillin Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Pollen Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Mold Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Pet Dander Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Dust Mite Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Fragrance Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Nickel Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Gluten Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Sulfite Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Red Meat Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Histamine Intolerance'),
    Allergy(id: const Uuid().v4(), name: 'Sesame Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Corn Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Garlic Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Citrus Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Alcohol Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Sunflower Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Chocolate Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Caffeine Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Dye Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Banana Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Avocado Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Kiwi Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Tomato Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Strawberry Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Potato Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Rice Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Oat Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Lentil Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Mustard Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Spice Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Mint Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Celery Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Carrot Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Pork Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Beef Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Chicken Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Turkey Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Blueberry Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Raspberry Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Grape Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Pineapple Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Coconut Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Melon Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Apple Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Pear Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Peach Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Plum Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Cherry Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Apricot Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Cucumber Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Pumpkin Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Squash Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Zucchini Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Eggplant Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Radish Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Broccoli Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Cauliflower Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Asparagus Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Spinach Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Kale Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Lettuce Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Mushroom Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Onion Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Shallot Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Leek Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Chive Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Ginger Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Pepper Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Olive Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Artichoke Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Beet Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Parsley Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Basil Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Rosemary Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Thyme Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Oregano Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Fennel Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Clove Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Cinnamon Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Vanilla Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Nutmeg Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Paprika Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Turmeric Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Cardamom Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Cilantro Allergy'),
    Allergy(id: const Uuid().v4(), name: 'Saffron Allergy'),
  ];

  static List<String> dosageTime = [
    'After meal',
    'Before meal',
    'Empty stomach',
  ];

  /*static final List<Drug> drugs = [
    Drug(
      name: "Paracetamol",
      contents: "Acetaminophen 500mg",
      type: "tab",
    ),
    Drug(
      name: "Ibuprofen",
      contents: "Ibuprofen 200mg",
      type: "tab",
    ),
    Drug(
      name: "Amoxicillin",
      contents: "Amoxicillin 500mg",
      type: "cap",
      quantity: 21,
      dosageFrequency: "3 times daily",
      dosageTime: "before meal",
      duration: "7 days",
    ),
    Drug(
      name: "Ciprofloxacin",
      contents: "Ciprofloxacin 500mg",
      type: "tab",
    ),
    Drug(
      name: "Metformin",
      contents: "Metformin 500mg",
      type: "tab",
    ),
    Drug(
      name: "Omeprazole",
      contents: "Omeprazole 20mg",
      type: "cap",
    ),
    Drug(
      name: "Aspirin",
      contents: "Aspirin 81mg",
      type: "tab",
    ),
    Drug(
      name: "Lorazepam",
      contents: "Lorazepam 2mg",
      type: "tab",
    ),
    Drug(
      name: "Lisinopril",
      contents: "Lisinopril 10mg",
      type: "tab",
    ),
    Drug(
      name: "Atorvastatin",
      contents: "Atorvastatin 20mg",
      type: "tab",
    ),
    Drug(
      name: "Furosemide",
      contents: "Furosemide 40mg",
      type: "tab",
    ),
    Drug(
      name: "Metronidazole",
      contents: "Metronidazole 500mg",
      type: "tab",
    ),
    Drug(
      name: "Clopidogrel",
      contents: "Clopidogrel 75mg",
      type: "tab",
    ),
    Drug(
      name: "Prednisone",
      contents: "Prednisone 5mg",
      type: "tab",
    ),
    Drug(
      name: "Azithromycin",
      contents: "Azithromycin 250mg",
      type: "tab",
    ),
    Drug(
      name: "Fluoxetine",
      contents: "Fluoxetine 20mg",
      type: "cap",
    ),
    Drug(
      name: "Hydrochlorothiazide",
      contents: "Hydrochlorothiazide 25mg",
      type: "tab",
    ),
    Drug(
      name: "Warfarin",
      contents: "Warfarin 5mg",
      type: "tab",
    ),
    Drug(
      name: "Doxycycline",
      contents: "Doxycycline 100mg",
      type: "cap",
    ),
    Drug(
      name: "Tramadol",
      contents: "Tramadol 50mg",
      type: "tab",
    ),
    Drug(
      name: "Salbutamol",
      contents: "Salbutamol 2mg",
      type: "syr",
    ),
    Drug(
      name: "Cetirizine",
      contents: "Cetirizine 10mg",
      type: "tab",
    ),
    Drug(
      name: "Levothyroxine",
      contents: "Levothyroxine 50mcg",
      type: "tab",
    ),
    Drug(
      name: "Morphine",
      contents: "Morphine 10mg",
      type: "inj",
    ),
    Drug(
      name: "Gliclazide",
      contents: "Gliclazide 80mg",
      type: "tab",
    ),
  ];*/

  static final appointmentResponseObject = Appointment.fromJson({
    "_id": "668d61afdbdcdf6632e7a792",
    "mobile": "9784511000",
    "name": "TstAdmin TA",
    "gender": "Male",
    "age": 26,
    "appointmentDate": "2024-07-10T00:00:00.000Z",
    "timeSlot": "3:00 PM - 5:59 PM",
    "virtualConsultation": false,
    "doctorName": "Mansoor Alikhan",
    "patientId": "668d6129dbdcdf6632e7a73a",
    "id": "668d61afdbdcdf6632e7a792",
    "appointmentLogs": [
      {'time': "2023-07-23T09:40:00", 'message': "Appointment of 25 July, 2023 at 6:30pm in the evening has been cancelled."},
      {'time': "2023-07-12T10:28:00", 'message': "Appointment of 12 July, 2023 is rescheduled to 25 July, 2023 at 6:30pm in the evening."},
      {'time': "2023-07-10T11:43:00", 'message': "Follow-up appointment scheduled on 12 July, 2023 at 3:20pm in the afternoon."},
      {'time': "2023-07-05T12:26:00", 'message': "Appointment scheduled on 10 July, 2023 at 3:20pm in the afternoon."},
    ].map((map) => AppointmentLog.fromMap(map)).toList()
  });

  static PatientOverviewModel patient = PatientOverviewModel(
      patientId: "668d6129dbdcdf6632e7a73a",
      firstName: "Ramesh",
      lastName: "Carlo",
      sId: "668d6129dbdcdf6632e7a73a",
      id: "668d61afdbdcdf6632e7a792",
      mobile: "9784511000",
      appointments: [
        Appointments.fromJson({
          "_id": "668d61afdbdcdf6632e7a792",
          "mobile": "9784511000",
          "name": "TstAdmin TA",
          "gender": "Male",
          "age": 26,
          "appointmentDate": "2024-07-10T00:00:00.000Z",
          "timeSlot": "3:0 PM - 5:59 PM",
          "virtualConsultation": false,
          "doctorName": "Mansoor Alikhan",
          "patientId": "668d6129dbdcdf6632e7a73a",
          "id": "668d61afdbdcdf6632e7a792"
        })
      ]);

  static List<Symptom> symptoms = [
    Symptom(
      name: 'Fever',
      type: 'Sx',
    ),
    Symptom(
      name: 'Cough',
      type: 'Sx',
    ),
    Symptom(
      name: 'Headache',
      type: 'Sx',
    ),
    Symptom(
      name: 'Fatigue',
      type: 'Sx',
    ),
    Symptom(
      name: 'Sore throat',
      type: 'Sx',
    ),
    Symptom(
      name: 'Runny nose',
      type: 'Sx',
    ),
    Symptom(
      name: 'Nausea',
      type: 'Sx',
    ),
    Symptom(
      name: 'Vomiting',
      type: 'Sx',
    ),
    Symptom(
      name: 'Diarrhea',
      type: 'Sx',
    ),
    Symptom(
      name: 'Shortness of breath',
      type: 'Sx',
    ),
    Symptom(
      name: 'Chest pain',
      type: 'Sx',
    ),
    Symptom(
      name: 'Chills',
      type: 'Sx',
    ),
    Symptom(
      name: 'Sweating',
      type: 'Sx',
    ),
    Symptom(
      name: 'Muscle aches',
      type: 'Sx',
    ),
    Symptom(
      name: 'Joint pain',
      type: 'Sx',
    ),
    Symptom(
      name: 'Loss of appetite',
      type: 'Sx',
    ),
    Symptom(
      name: 'Rash',
      type: 'Sx',
    ),
    Symptom(
      name: 'Dizziness',
      type: 'Sx',
    ),
    Symptom(
      name: 'Confusion',
      type: 'Sx',
    ),
    Symptom(
      name: 'Blurred vision',
      type: 'Sx',
    ),
    Symptom(
      name: 'Sore muscles',
      type: 'Sx',
    ),
    Symptom(
      name: 'Tremors',
      type: 'Sx',
    ),
    Symptom(
      name: 'Swelling',
      type: 'Sx',
    ),
    Symptom(
      name: 'Numbness',
      type: 'Sx',
    ),
    Symptom(
      name: 'Tingling',
      type: 'Sx',
    ),
  ];

  static List<Symptom> diagnosis = [
    Symptom(
      name: 'Diabetes',
      type: 'Dx',
    ),
    Symptom(
      name: 'Hypertension',
      type: 'Dx',
    ),
    Symptom(
      name: 'Asthma',
      type: 'Dx',
    ),
    Symptom(
      name: 'Cancer',
      type: 'Dx',
    ),
    Symptom(
      name: 'Heart disease',
      type: 'Dx',
    ),
    Symptom(
      name: 'Arthritis',
      type: 'Dx',
    ),
    Symptom(
      name: 'Alzheimer\'s disease',
      type: 'Dx',
    ),
    Symptom(
      name: 'Parkinson\'s disease',
      type: 'Dx',
    ),
    Symptom(
      name: 'Chronic kidney disease',
      type: 'Dx',
    ),
    Symptom(
      name: 'Liver disease',
      type: 'Dx',
    ),
    Symptom(
      name: 'Stroke',
      type: 'Dx',
    ),
    Symptom(
      name: 'Epilepsy',
      type: 'Dx',
    ),
    Symptom(
      name: 'HIV/AIDS',
      type: 'Dx',
    ),
    Symptom(
      name: 'Chronic obstructive pulmonary disease',
      type: 'Dx',
    ),
    Symptom(
      name: 'Osteoporosis',
      type: 'Dx',
    ),
    Symptom(
      name: 'Multiple sclerosis',
      type: 'Dx',
    ),
    Symptom(
      name: 'Crohn\'s disease',
      type: 'Dx',
    ),
    Symptom(
      name: 'Celiac disease',
      type: 'Dx',
    ),
    Symptom(
      name: 'Depression',
      type: 'Dx',
    ),
    Symptom(
      name: 'Anxiety',
      type: 'Dx',
    ),
    Symptom(
      name: 'Bipolar disorder',
      type: 'Dx',
    ),
    Symptom(
      name: 'Schizophrenia',
      type: 'Dx',
    ),
    Symptom(
      name: 'Tuberculosis',
      type: 'Dx',
    ),
    Symptom(
      name: 'Anemia',
      type: 'Dx',
    ),
    Symptom(
      name: 'Hyperthyroidism',
      type: 'Dx',
    ),
  ];
}
