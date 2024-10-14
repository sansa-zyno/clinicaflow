/*import 'package:flutter/material.dart';


class RelationScreen extends StatefulWidget {
  const RelationScreen({Key? key}) : super(key: key);

  @override
  State<RelationScreen> createState() => _RelationScreenState();
}

class _RelationScreenState extends State<RelationScreen> {
  final List<String> _selectedDiseases = [];
  final List<String> _diseaseOptions = [
    "Father",
    "Mother",
    "Older Brother",
    "Older Sister",
    "Younger  Brother",
    "Maternal Grandfather",
    "Paternal Grandfather",
    "Paternal Grandmother",

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16,top: 16),
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
                    Icon(Icons.search),
                    SizedBox(width: 4),
                    Flexible(
                      child: TextField(
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          height: 1.2,
                          color: Color(0xFF110C2C),
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
            child: Row(
              children: [
                Text(
                  "${_selectedDiseases.length} selected",
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    height: 1.2,
                    color: Color(0xFFA5A5A5),
                  ),
                ),
                const Spacer(),
                Container(
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
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _diseaseOptions.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    buildOption(_diseaseOptions[index]),
                    const SizedBox(height: 16),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOption(String title) {
    bool isSelected = _selectedDiseases.contains(title);
    return GestureDetector(
      onTap: () {
        if (title == "Sickle Cell") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RelationScreen()),
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
        child: Row(
          children: [
            InkWell(
              onTap: () {
                if (title == "Sickle Cell") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RelationScreen()),
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
              borderRadius: BorderRadius.circular(50),
              child:Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: const Color(0xFFA1A1A1),
                  ),
                  color: isSelected ? const Color(0xFF311FFF) : Colors.transparent,
                ),
                child: isSelected
                    ? const Icon(
                  Icons.check,
                  size: 12,
                  color: Colors.white,
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
                fontSize: 16,
                height: 1.2,
                color: Color(0xFF000000),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/


