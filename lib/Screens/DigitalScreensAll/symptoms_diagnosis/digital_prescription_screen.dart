/*import 'package:flutter/material.dart';
import 'create_digital_prescription_symptoms_screen.dart';

class DigitalPrescriptionScreen extends StatefulWidget {
  const DigitalPrescriptionScreen({super.key});

  @override
  State<DigitalPrescriptionScreen> createState() =>
      _DigitalPrescriptionScreenState();
}

class _DigitalPrescriptionScreenState extends State<DigitalPrescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffE1F9F2),
          title: const Text(
            "Digital Prescription",
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20, top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "SYMPTOMS & DIAGNOSIS",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const Divider(color: Colors.black),
                      const Text(
                        "Symptoms",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      buildSymptomContainer('Fever', 'Duration e.g 1 week'),
                      const SizedBox(height: 6),
                      buildSeizureContainer(
                          'Seizure', 'Occurrence e.g. once a week'),
                      const SizedBox(height: 6),
                      buildXyzContainer('XYz', 'Occurrence e.g. once a   week'),
                      const Divider(),
                      const Text(
                        "Diagnosis",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                      const SizedBox(height: 6),
                      GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 20,
                                                width: 20,
                                                color: const Color(0xff52CFAC),
                                                child: const Center(
                                                    child: Text("Sx")),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const Text(
                                                'Seizures',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          const Text(
                                            "Add Notes",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                          const Divider(
                                            color: Colors.black,
                                          ),
                                          TextFormField(
                                            decoration: const InputDecoration(
                                              filled: true,
                                              fillColor: Color(0xffEDFFFA),
                                              // Change this to your desired color
                                              border: InputBorder.none,
                                              label: Row(
                                                children: [
                                                  SizedBox(width: 8),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 80),
                                                    child: Text(
                                                      'Add your notes here.',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 16),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 50.0,
                                                      horizontal: 12.0),
                                            ),
                                          ),
                                          const Spacer(),
                                          Container(
                                            decoration: const BoxDecoration(
                                              color: Color(0xffF8F7FC),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Color(
                                                                0xff32856E),
                                                            shape: BoxShape
                                                                .circle),
                                                    child: TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xff32856E),
                                                        minimumSize:
                                                            const Size(140, 60),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return const CreateDigitalPrescriptionSymptomsScreen();
                                                        }));
                                                      },
                                                      child: const Text(
                                                        "Save",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Color(0xffF5F5F5),
                                                    ),
                                                    child: TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xffF5F5F5),
                                                        minimumSize:
                                                            const Size(140, 60),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        // Handle button press
                                                      },
                                                      child: const Text(
                                                        "Exit",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff0B1F19),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                              },
                            );
                          },
                          child: buildDiagnosisContainer('Pneumonia')),
                      const SizedBox(height: 18),
                      const Text(
                        "Private Notes",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const Divider(),
                      TextFormField(
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xffEDFFFA),
                          border: InputBorder.none,
                          label: Row(
                            children: [
                              SizedBox(width: 8),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 40),
                                  child: Text(
                                    'These notes are Private to the user.',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w400),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 12.0),
                        ),
                      ),
                      const SizedBox(height: 60),
                      //buildBottomButtons(context),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            )),
            Positioned(
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: 140,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xff32856E),
                            minimumSize: const Size(140, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Next",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Container(
                      height: 50,
                      width: 140,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xffF5F5F5),
                          minimumSize: const Size(140, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Clear",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSymptomContainer(String symptom, String details,
      {double width = 216}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff85F8D5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Text(
              symptom,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
            ),
            const SizedBox(width: 5),
            Container(
                height: 40,
                width: width,
                decoration: BoxDecoration(
                  color: const Color(0xffCDFFF0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Duration e.g. 1 week',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )),
            const SizedBox(width: 4),
            buildIcon(
                Icons.edit, const Color(0xff0B0B0B), const Color(0xffF8F7FC)),
            const SizedBox(width: 4),
            buildIcon(
                Icons.close, const Color(0xffF8F7FC), const Color(0xff0B0B0B)),
          ],
        ),
      ),
    );
  }

  Widget buildSeizureContainer(String symptom, String details,
      {double width = 200}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff85F8D5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          children: [
            Text(
              symptom,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(width: 5),
            Container(
              width: width,
              decoration: BoxDecoration(
                color: const Color(0xffCDFFF0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Occurrence e.g. once a week',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  maxLines: 2,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            const SizedBox(width: 4),
            buildIcon(
                Icons.edit, const Color(0xff0B0B0B), const Color(0xffF8F7FC)),
            const SizedBox(width: 4),
            buildIcon(
                Icons.close, const Color(0xffF8F7FC), const Color(0xff0B0B0B)),
          ],
        ),
      ),
    );
  }

  Widget buildXyzContainer(String symptom, String details,
      {double width = 228}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff85F8D5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          children: [
            Text(
              symptom,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(width: 5),
            Container(
              width: width,
              decoration: BoxDecoration(
                color: const Color(0xffCDFFF0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Occurrence e.g. once a     week',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  maxLines: 2,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            const SizedBox(width: 4),
            buildIcon(
                Icons.edit, const Color(0xff0B0B0B), const Color(0xffF8F7FC)),
            const SizedBox(width: 4),
            buildIcon(
                Icons.close, const Color(0xffF8F7FC), const Color(0xff0B0B0B)),
          ],
        ),
      ),
    );
  }

  Widget buildDiagnosisContainer(String diagnosis) {
    return Container(
      height: 38,
      width: 166,
      decoration: BoxDecoration(
        color: const Color(0xff85F8D5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            diagnosis,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          buildIcon(
              Icons.edit, const Color(0xff0B0B0B), const Color(0xffF8F7FC)),
          buildIcon(
              Icons.close, const Color(0xffF8F7FC), const Color(0xff0B0B0B)),
        ],
      ),
    );
  }

  Widget buildIcon(IconData icon, Color bgColor, Color iconColor) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: Center(
        child: Icon(icon, size: 16, color: iconColor),
      ),
    );
  }

  Widget buildBottomButton(BuildContext context, String text, Color bgColor,
      Color textColor, VoidCallback onPressed) {
    return Container(
      height: 50,
      width: 140,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: bgColor,
          minimumSize: const Size(140, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget buildBottomSheetContent(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 24,
                      width: 24,
                      color: const Color(0xff52CFAC),
                      child: const Center(child: Text("Sx")),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Seizures',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  "Add Notes",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                const Divider(color: Colors.black),
                TextFormField(
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xffEDFFFA),
                    border: InputBorder.none,
                    label: Row(
                      children: [
                        SizedBox(width: 8),
                        Padding(
                          padding: EdgeInsets.only(bottom: 80),
                          child: Text(
                            'Add your notes here.',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 50.0, horizontal: 12.0),
                  ),
                ),
                const SizedBox(height: 90),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildBottomButton(
                          context,
                          "Save",
                          const Color(0xff32856E),
                          Colors.white,
                          () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const CreateDigitalPrescriptionSymptomsScreen();
                            }));
                          },
                        ),
                        buildBottomButton(
                          context,
                          "Clear",
                          const Color(0xffFF8F7FC),
                          const Color(0xff0B1F19),
                          () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}*/
