/*import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/symptoms_diagnosis/create_digital_presscription_screen.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/constants/app_text.dart';

class FeverAffirmatioSheet extends StatefulWidget {
  const FeverAffirmatioSheet({Key? key}) : super(key: key);

  @override
  State<FeverAffirmatioSheet> createState() => _FeverAffirmatioSheetState();
}

class _FeverAffirmatioSheetState extends State<FeverAffirmatioSheet> {
  String? selectedValue;
  final List<String> options = ['hrs', 'days', 'weeks', 'months', 'years'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6 +
              MediaQuery.of(context).viewInsets.bottom,
          color: Colors.transparent,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6 +
                      MediaQuery.of(context).viewInsets.bottom,
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 14.10,
                        offset: Offset(3, 3),
                        spreadRadius: 8,
                      )
                    ],
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16.0, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              color: const Color(0xff52CFAC),
                              child: const Center(
                                  child: Text(
                                "Sx",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              'Fever',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Temperature",
                              style: TextStyle(
                                color: AppColors.black1Color,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xffFF8F7FC),
                                    border: InputBorder.none,
                                    label: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'e.g. 95',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Spacer(),
                                        Stack(
                                          children: [
                                            Positioned(
                                              top: 0,
                                              left: 0,
                                              child: Icon(
                                                Icons.circle_outlined,
                                                size: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "F",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          "PRIVATE NOTES",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                        const Divider(
                          color: AppColors.blackColor,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Container(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color(0xffEDFFFA),
                              border: InputBorder.none,
                              labelText: 'Add your notes here.',
                              labelStyle:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                            ),
                            maxLines: null,
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    color: AppColors.greenColor,
                                    shape: BoxShape.circle),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: AppColors.greenColor,
                                    minimumSize: const Size(140, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const CreateDigitalPrescriptionScreen();
                                    }));
                                  },
                                  child: const Text(
                                    AppText.save,
                                    style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Color(0x0ff5F5F5),
                                ),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xffF5F5F5),
                                    minimumSize: const Size(140, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    AppText.clear,
                                    style: TextStyle(
                                      color: AppColors.darkGreenColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
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
            ],
          ),
        ),
      ),
    );
  }
}*/
