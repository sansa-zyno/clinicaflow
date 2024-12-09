import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';
import 'package:healtether_clinic_app/constants/app_text.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';

class FamilyHistoryScreen extends StatefulWidget {
  const FamilyHistoryScreen({Key? key}) : super(key: key);

  @override
  State<FamilyHistoryScreen> createState() => _FamilyHistoryScreenState();
}

class _FamilyHistoryScreenState extends State<FamilyHistoryScreen> {
  final List<String> _selectedDiseases = [];
  final List<String> _selectedRelations = [];

  final List<String> _relationOptions = [
    "Mother",
    "Older Brother",
    "Grandmother",
    "Father",
    "Older sister",
    "Grandfather",
    "opt 1",
    "opt 2",
  ];

  final List<String> _diseaseOptions = [
    "Diabetics",
    "TB",
    "Sickle Cell",
    "Cardiovascular",
    "Hepatitis-A",
    "Asthma",
    "Epilepsy",
    "Option 1",
    "Option 2",
    "Option 3",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Text(
                AppText.familyHistory,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.goNamed(AppRoutes.saveFamilyHistory.name);
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return const SaveFamilyHistoryScreen();
                // }));
              },
              child: Container(
                width: 70,
                height: 35,
                decoration: BoxDecoration(
                  color: AppColors.greenColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Center(
                  child: Text(
                    AppText.save,
                    style: TextStyle(color: AppColors.whiteColor, fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: AppColors.white1Color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 4),
                    Flexible(
                      child: TextField(
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          height: 1.2,
                          color: AppColors.blue1Color,
                        ),
                        decoration: InputDecoration.collapsed(
                          hintText: 'Search & select disease',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Text(
              "${_selectedDiseases.length} selected",
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                height: 1.2,
                color: Color(0xFFA5A5A5),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _diseaseOptions.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    buildDiseaseOption(_diseaseOptions[index]),
                    const SizedBox(height: 8),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDiseaseOption(String title) {
    bool isSelected = _selectedDiseases.contains(title);
    return Container(
      height: 50,
      color: const Color(0xffF7F7F7),
      child: GestureDetector(
        onTap: () {
          if (title == "Sickle Cell" || title == "Asthma") {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 48,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.search,
                                      color: Color(0xFFA5A5A5),
                                    ),
                                    SizedBox(width: 4),
                                    Flexible(
                                      child: TextField(
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          height: 1.2,
                                          color: Color(0xFFA5A5A5),
                                        ),
                                        decoration: InputDecoration.collapsed(
                                          hintText: 'Search & select relations',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0, right: 16),
                            child: Row(
                              children: [
                                Text(
                                  "${_selectedRelations.length} selected",
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    height: 1.2,
                                    color: Color(0xFFA5A5A5),
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: 70,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF32856E),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Done',
                                        style: TextStyle(color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: ListView.builder(
                              itemCount: _relationOptions.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    buildRelationOption(_relationOptions[index], setState),
                                    const SizedBox(height: 8),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          } else {
            setState(() {
              if (isSelected) {
                _selectedDiseases.remove(title);
              } else {
                _selectedDiseases.add(title);
              }
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedDiseases.remove(title);
                        } else {
                          _selectedDiseases.add(title);
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: const Color(0xFFA1A1A1),
                        ),
                        color: isSelected ? const Color(0xFFFEFEFE) : Colors.transparent,
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              size: 18,
                              color: Colors.black,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                      height: 1.2,
                      color: Color(0xFF000000),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRelationOption(String title, StateSetter setState) {
    bool isSelected = _selectedRelations.contains(title);
    return Container(
      height: 50,
      color: const Color(0xffF7F7F7),
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (isSelected) {
              _selectedRelations.remove(title);
            } else {
              _selectedRelations.add(title);
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: const Color(0xFFA1A1A1),
                  ),
                  borderRadius: BorderRadius.circular(6),
                  color: isSelected ? const Color(0xFFF7F7F7) : Colors.transparent,
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        size: 12,
                        color: Colors.black,
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  height: 1.2,
                  color: Color(0xFF000000),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
