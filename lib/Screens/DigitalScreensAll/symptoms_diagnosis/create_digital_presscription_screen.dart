/*import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/vitals_screen/vitals_screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/sx&dx_screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/symptoms_diagnosis/fever_afermative_sheet.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';

class CreateDigitalPrescriptionScreen extends StatefulWidget {
  const CreateDigitalPrescriptionScreen(
      {this.selectedSymptoms,
      this.selectedDiagnoses,
      this.symptoms,
      this.timePeriod,
      this.duration,
      this.associatedSymptoms,
      this.differentialDiagnoses,
      super.key});

  final List<String>? selectedSymptoms;
  final List<String>? selectedDiagnoses;
  final String? symptoms;
  final String? timePeriod;
  final String? duration;
  final List<String>? associatedSymptoms;
  final List<String>? differentialDiagnoses;

  @override
  State<CreateDigitalPrescriptionScreen> createState() =>
      _CreateDigitalPrescriptionScreenState();
}

class _CreateDigitalPrescriptionScreenState
    extends State<CreateDigitalPrescriptionScreen> {
  // List<Map<String, String>> symptoms = [
  //   {"name": "Fever", "duration": "Duration e.g. 1 day"}
  // ];
  List<Map<String, String>> symptoms = [];
  Set<String> tappedSymptoms = {};

  bool showPneumoniaTextField = false;
  bool showSxAndDxScreen = false;

  void addSymptom(String name, String duration) {
    setState(() {
      symptoms.add({"name": name, "duration": duration});
    });
  }

  void removeSymptom(String name) {
    setState(() {
      symptoms.removeWhere((symptom) => symptom["name"] == name);
      tappedSymptoms.remove(name);
      if (name == "Seizure") {
        symptoms.firstWhere((symptom) => symptom["name"] == "Fever",
                orElse: () => {"duration": "Duration e.g. 1 day"})["duration"] =
            "Duration e.g. 1 day";
      }
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isDrawerOpen = false;

  void _toggleDrawer() {
    if (_scaffoldKey.currentState!.isEndDrawerOpen) {
      context.pop();
    } else {
      _scaffoldKey.currentState!.openEndDrawer();
    }
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.timePeriod != null && widget.duration != null) {
      symptoms.add({
        'title': widget.symptoms!,
        'timePeriod': widget.timePeriod!,
        'duration': widget.duration!,
      });
    } else {
      symptoms.add({
        'title': 'Fever',
        'timePeriod': '',
        'duration': 'years',
      });
    }
  }

  bool _isNextScreen = false;

  void _toggleScreen() {
    setState(() {
      _isNextScreen = !_isNextScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      key: _scaffoldKey,
      appBar: AppBar(
        leadingWidth: 30,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          AppText.digitalPrescription,
          style: GoogleFonts.urbanist(
            textStyle: const TextStyle(
              fontSize: 18,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w500,
              height: 1.25,
              color: AppColors.lightBlueColor,
            ),
          ),
        ),
        backgroundColor: const Color(0xFFE1F9F2),
        actions: [
          IconButton(
            onPressed: _toggleDrawer,
            icon: Icon(_isDrawerOpen ? Icons.close : Icons.menu),
          ),
        ],
      ),
      // endDrawer: buildEndDrawer(height, context, width),
      body: _isNextScreen ? const SxAndDxScreen() : buildPadding(context),
    );
  }

  SizedBox buildEndDrawer(double height, BuildContext context, double width) {
    return SizedBox(
      height: 600,
      child: Drawer(
        width: 320,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.64,
                child: Material(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  elevation: 6,
                  shadowColor: const Color(0xffF5F5F5),
                  color: const Color(0xffF5F5F5),
                  surfaceTintColor: const Color(0xffF5F5F5),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //? VITALS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Vitals',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff0C091F)),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const VitalsScreen(
                                              appointmentId: '',
                                            )));
                              },
                              child: Column(
                                children: [
                                  const Text(
                                    'Edit',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff5351C7)),
                                  ),
                                  Container(
                                    height: 1,
                                    width: 30,
                                    decoration: const BoxDecoration(
                                      color: Color(0xff5351C7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 4),
                                height: 75,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xffF5F5F5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'SpO2',
                                      style: GoogleFonts.roboto(
                                        textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff413D56),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Center(
                                      child: Image.asset(
                                          "assets/homeimages/Vector (4).png"),
                                    ),
                                    const SizedBox(height: 4),
                                    Center(
                                      child: Text(
                                        '97',
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff0C091F),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Container(
                                height: 75,
                                padding: const EdgeInsets.only(left: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xffF5F5F5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'BP',
                                      style: GoogleFonts.roboto(
                                        textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff413D56),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Center(
                                      child: Image.asset(
                                          "assets/homeimages/Vector (5).png"),
                                    ),
                                    const SizedBox(height: 4),
                                    Center(
                                      child: Text(
                                        '80/120',
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff0C091F),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Container(
                                height: 75,
                                padding: const EdgeInsets.only(left: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xffF5F5F5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Heart rate',
                                      style: GoogleFonts.roboto(
                                        textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff413D56),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Center(
                                      child: Image.asset(
                                          "assets/homeimages/Vector (6).png"),
                                    ),
                                    const SizedBox(height: 4),
                                    Center(
                                      child: Text(
                                        '80',
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff0C091F),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Container(
                                height: 75,
                                padding: const EdgeInsets.only(left: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xffF5F5F5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'BG',
                                      style: GoogleFonts.roboto(
                                        textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff413D56),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Center(
                                      child: Image.asset(
                                          "assets/homeimages/droplet-outline.png"),
                                    ),
                                    const SizedBox(height: 4),
                                    Center(
                                      child: Text(
                                        '150',
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff0C091F),
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
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(right: 152),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 75,
                                  padding: const EdgeInsets.only(left: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xffF5F5F5),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Ht',
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff413D56),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Center(
                                        child: Image.asset(
                                            "assets/homeimages/Vector (7).png"),
                                      ),
                                      const SizedBox(height: 4),
                                      Center(
                                        child: Text(
                                          '160',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff0C091F),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Container(
                                  height: 75,
                                  padding: const EdgeInsets.only(left: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xffF5F5F5),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Wt',
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff413D56),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Center(
                                        child: Image.asset(
                                            "assets/homeimages/Vector (8).png"),
                                      ),
                                      const SizedBox(height: 4),
                                      Center(
                                        child: Text(
                                          '60',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff0C091F),
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.06),

              //? PAST HISTORY
              Material(
                elevation: 8,
                shadowColor: const Color(0xFFFFFFFF),
                surfaceTintColor: const Color(0xFFFFFFFF),
                color: const Color(0xFFFFFFFF),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Past History',
                            style: GoogleFonts.urbanist(
                              textStyle: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff0C091F),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              log("GOINT TO SYMPTOMS TEST");

                              // context.pushNamed(AppRoutes.symptomsTest.name);
                            },
                            child: Column(
                              children: [
                                const Text(
                                  'Edit',
                                  style: TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff5351C7),
                                  ),
                                ),
                                Container(
                                  height: 1,
                                  width: 30,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff5351C7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Family History',
                        style: GoogleFonts.urbanist(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff868686),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: width,
                        height: 40,
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        decoration: const BoxDecoration(
                          color: Color(0xffF7F7F7),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: const Text(
                          'Asthma, Hypertension',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff0C091F),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Medical Procedures',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff868686),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: width,
                        height: 40,
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        decoration: const BoxDecoration(
                          color: Color(0xffF7F7F7),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: const Text(
                          'Heart Surgery',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff0C091F),
                          ),
                        ),
                        // onTap: () {},
                        // contentPadding: const EdgeInsets.symmetric(
                        //     horizontal: 10.0, vertical: 2.0),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Medication',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff868686),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: width,
                        height: 40,
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        decoration: const BoxDecoration(
                          color: Color(0xffF7F7F7),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: const Text(
                          'Dolo - 650, Paracetomol',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff0C091F),
                          ),
                        ),
                        // onTap: () {},
                        // contentPadding: const EdgeInsets.symmetric(
                        //     horizontal: 8.0, vertical: 2.0),
                      ),
                      SizedBox(height: height * 0.04),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Allergies - ',
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff868686),
                              ),
                            ),
                            TextSpan(
                              text: 'Pollen, Sunlight',
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff0C091F),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Phobias/Fears - ',
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff868686),
                              ),
                            ),
                            TextSpan(
                              text: 'Pollen, Sunlight',
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff0C091F),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildPadding(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Column(
        children: [
          // ),Visibility(
          //   visible: showSxAndDxScreen,
          //   child: FutureBuilder<void>(
          //     future: Future.delayed(Duration(milliseconds: 50)),
          //     // Small delay to ensure layout completion
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.done) {
          //         return const SxAndDxScreen();
          //       } else {
          //         return const SizedBox(); // or a placeholder if needed
          //       }
          //     },
          //   ),
          // ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8, top: 8),
                    child: Text(
                      'SYMPTOMS & DIAGNOSIS',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                  const Divider(
                    color: AppColors.blackColor,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F7FC),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: GestureDetector(
                      onTap: _toggleScreen,
                      child: const TextField(
                        enabled: false,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: "Search by symptoms or diagnosis",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto',
                            color: Colors.black,
                          ),
                          border: InputBorder.none,
                          icon: Icon(Icons.search, color: AppColors.blackColor),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Symptoms',
                    style: GoogleFonts.urbanist(
                      textStyle: const TextStyle(
                        color: AppColors.black1Color,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        // fontFamily: 'Urbanist',
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Column(
                  //   children: symptoms.map((symptom) {
                  //     final selected =
                  //         tappedSymptoms.contains(symptom["name"]);
                  //     return Padding(
                  //       padding: const EdgeInsets.only(bottom: 8.0),
                  //       child: GestureDetector(
                  //         onTap: () {
                  //           if (symptom["name"] == "Fever" && !selected) {
                  //             // tappedSymptoms.add("Fever");
                  //             // setState(() {
                  //             //   symptom["duration"] = "5 hrs";
                  //             // });
                  //             // addSymptom("Seizure", "once a month");
                  //             // addSymptom("Chills", "5 hrs");
                  //           }
                  //           // else if (symptom["name"] == "Seizure" && selected) {
                  //           //   removeSymptom("Seizure");
                  //           // }
                  //         },
                  //         child: buildSymptomContainer(
                  //
                  //             widget.symptoms ?? 'Fever',
                  //             '${symptom['timePeriod']} ${symptom['duration']}',
                  //             selected),
                  //       ),
                  //     );
                  //   }).toList(),
                  // ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: symptoms.length,
                    itemBuilder: (context, index) {
                      final symptom = symptoms[index];
                      return Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFFC9F0E5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Row(
                                children: [
                                  Text(
                                    symptom['title'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    '-',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${symptom['timePeriod']} ${symptom['duration']}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.blackColor,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                                onTap: () {
                                  // showModalBottomSheet(
                                  //   backgroundColor: Colors.transparent,
                                  //   isScrollControlled: true,
                                  //   context: context,
                                  //   builder: (BuildContext context) {
                                  //     return FeverAffirmationsSheet(
                                  //       symptomName: symptom['title'] ?? '',
                                  //     );
                                  //   },
                                  // );
                                },
                                child: buildIcon(
                                    Icons.edit,
                                    const Color(0xff0B0B0B),
                                    const Color(0xffF8F7FC))),
                            const SizedBox(width: 6),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: buildIcon(
                                  Icons.close,
                                  const Color(0xffF8F7FC),
                                  const Color(0xff0B0B0B)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  if (widget.selectedSymptoms != null)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.selectedSymptoms!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFFC9F0E5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.selectedSymptoms![index],
                                    maxLines: 1,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(right: 80),
                                  child: Text(
                                    " - 1 days",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Urbanist',
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                buildIcon(Icons.edit, const Color(0xff0B0B0B),
                                    const Color(0xffF8F7FC)),
                                const SizedBox(width: 6),
                                buildIcon(Icons.close, const Color(0xffF8F7FC),
                                    const Color(0xff0B0B0B)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  const Divider(),
                  const SizedBox(height: 12),
                  Text(
                    'Diagnoses',
                    style: GoogleFonts.urbanist(
                      textStyle: const TextStyle(
                        color: AppColors.black1Color,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        // fontFamily: 'Urbanist',
                      ),
                    ),
                  ),
                  if (widget.selectedDiagnoses != null)
                    SizedBox(
                      width: double.infinity,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.selectedDiagnoses?.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xFFC9F0E5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.only(
                                  left: 4, top: 8, bottom: 8, right: 6),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.selectedDiagnoses![index],
                                      maxLines: 1,
                                    ),
                                  ),
                                  buildIcon(
                                      Icons.close,
                                      const Color(0xffF8F7FC),
                                      const Color(0xff0B0B0B)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // if (!showPneumoniaTextField) ...[
                      Text(
                        'Associated Symptoms',
                        style: GoogleFonts.urbanist(
                          textStyle: const TextStyle(
                            color: Color(0xFF1B9C85),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            // fontFamily: 'Urbanist',
                          ),
                        ),
                      ),
                      (widget.associatedSymptoms != null &&
                              widget.associatedSymptoms!.isNotEmpty)
                          ? SizedBox(
                              width: double.infinity,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.associatedSymptoms?.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.white1Color,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      height: 40,
                                      width: double.infinity,
                                      padding: const EdgeInsets.only(
                                          left: 4, top: 8, bottom: 8, right: 6),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              widget.associatedSymptoms![index],
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Row(
                              children: [
                                buildContainer(40, 140, 'Shallow breathing'),
                                const SizedBox(width: 8),
                                buildContainer(40, 90, 'Heartburn'),
                              ],
                            ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          buildContainer(40, 130, 'Sweating & chills'),
                          const SizedBox(width: 6),
                          buildContainer(40, 90, 'Headache'),
                          const SizedBox(width: 6),
                          buildContainer(40, 100, 'Muscle pain'),
                        ],
                      ),
                      const Divider(),
                      Text(
                        'Differential Diagnosis',
                        style: GoogleFonts.urbanist(
                          textStyle: const TextStyle(
                            color: Color(0xFF1B9C85),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            // fontFamily: 'Urbanist',
                          ),
                        ),
                      ),
                      (widget.differentialDiagnoses != null &&
                              widget.differentialDiagnoses!.isNotEmpty)
                          ? SizedBox(
                              width: double.infinity,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.differentialDiagnoses?.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Container(
                                      height: 40,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: AppColors.white1Color,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      padding: const EdgeInsets.only(
                                          left: 4, top: 8, bottom: 8, right: 6),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              widget.differentialDiagnoses![
                                                  index],
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Row(
                              children: [
                                buildContainer(40, 100, 'Pneumonia'),
                                const SizedBox(width: 8),
                                buildContainer(40, 90, 'Malaria'),
                                const SizedBox(width: 8),
                                buildContainer(40, 90, 'Typhoid'),
                              ],
                            ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          buildContainer(40, 110, 'Common Cold'),
                          const SizedBox(width: 8),
                          buildContainer(40, 90, 'Influneza'),
                        ],
                      ),
                    ],
                  ),
                  const Divider(),
                  const InkWell(
                    child: Text(
                      "Frequently searched Symptoms",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        color: Color(0xff767676),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      buildContainer(40, 90, 'Heartburn'),
                      const SizedBox(width: 8),
                      buildContainer(40, 90, 'Chest pain'),
                      const SizedBox(width: 8),
                      buildContainer(40, 90, 'Nausea'),
                    ],
                  ),
                  const SizedBox(height: 6),

                  Row(
                    children: [
                      buildContainer(40, 90, 'Body pain'),
                      const SizedBox(width: 8),
                      buildContainer(40, 90, 'Runny nose'),
                    ],
                  ),
                  const Divider(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    // onTap: () {
                    //   Navigator.push(context, MaterialPageRoute(builder: (context){
                    //     return DrugPrescriptionFollowupScreen();
                    //   }));
                    // },
                    child: Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xffF5F5F5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Center(
                        child: Text(
                          'Clear',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(
                      //     content: Text('Vitals have been saved successfully.'),
                      //   ),
                      // );
                      // Navigator.push(context, MaterialPageRoute(builder: (context){
                      //   return const AppointmentScreen();
                      // }));
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF32856E),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Center(
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  Container buildContainer(double height, double width, String text) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: AppColors.white1Color, borderRadius: BorderRadius.circular(8)),
      child: Center(
          child: Text(
        text,
        style: TextStyle(
            fontSize: 14,
            color: Color(0xff0C091F),
            fontWeight: FontWeight.w400,
            fontFamily: 'Roboto'),
      )),
    );
  }

  Widget buildSymptomContainer(String symptom, String duration, bool selected,
      {double width = 200}) {
    List<String> symptomsWithBlackText = [
      "Fever",
      "Seizure",
      "Chills",
      "5 hrs"
    ];
    List<String> symptomsWithBlacksText = ["5 hrs", "once a month", "5 hrs"];

    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFC9F0E5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          children: [
            Text(
              symptom,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
                fontFamily: 'Urbanist',
                color: symptomsWithBlackText.contains(symptom)
                    ? Colors.black
                    : Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "- 2 days",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
                fontFamily: 'Urbanist',
                color: symptomsWithBlackText.contains(symptom)
                    ? Colors.black
                    : Colors.black,
              ),
            ),

            // Container(
            //   height: 40,
            //   width: width,
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 10.0),
            //     // child: TextField(
            //     //   controller: TextEditingController(text: duration),
            //     //   decoration: const InputDecoration(
            //     //     border: InputBorder.none,
            //     //     hintText: 'Duration e.g. 1 day',
            //     //     hintStyle: TextStyle(
            //     //       color: Colors.grey,
            //     //       fontSize: 14,
            //     //       fontWeight: FontWeight.w500,
            //     //     ),
            //     //   ),
            //     //   style: TextStyle(
            //     //     color: symptomsWithBlacksText.contains(duration)
            //     //         ? Colors.black
            //     //         : Colors.grey,
            //     //   ),
            //     // ),
            //   ),
            // ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const FeverAffirmatioSheet();
                }));
              },
              child: GestureDetector(
                  onTap: () {
                    // showModalBottomSheet(
                    //   backgroundColor: Colors.transparent,
                    //   isScrollControlled: true,
                    //   context: context,
                    //   builder: (BuildContext context) {
                    //     return const FeverAffirmationsSheet(
                    //       symptomName: '',
                    //     );
                    //   },
                    // );
                  },
                  child: buildIcon(Icons.edit, const Color(0xff0B0B0B),
                      const Color(0xffF8F7FC))),
            ),
            const SizedBox(width: 6),
            buildIcon(
                Icons.close, const Color(0xffF8F7FC), const Color(0xff0B0B0B)),
          ],
        ),
      ),
    );
  }

  Widget buildIcon(IconData icon, Color bgColor, Color iconColor) {
    return Container(
      height: 24,
      width: 24,
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: Center(
        child: Icon(icon, size: 20, color: iconColor),
      ),
    );
  }
}*/
