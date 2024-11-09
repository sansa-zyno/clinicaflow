import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/widget_extensions.dart';
import 'package:healtether_clinic_app/utils/prescription_pdf.dart';
import 'package:healtether_clinic_app/widgets/buttons/my_elevated_button.dart';

class PrescriptionPreview extends StatefulWidget {
  const PrescriptionPreview({super.key});

  @override
  State<PrescriptionPreview> createState() => _PrescriptionPreviewState();
}

class _PrescriptionPreviewState extends State<PrescriptionPreview> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // to save image bytes of widget
  Uint8List? bytes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leadingWidth: 30,
        title: Text(
          AppText.digitalPrescription,
          style: GoogleFonts.urbanist(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              height: 1.25,
              color: AppColors.lightBlueColor,
            ),
          ),
        ),
        backgroundColor: const Color(0xFFE1F9F2),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(border: Border.all(), color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                color: AppColors.lightGrey,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/homeimages/Ellipse 250.png',
                      width: 90,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kim Jones Clinic',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            'Dr. Ajit Bhaia , Neurologist',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'MBBS | FCPS (Neurology) | MRCP (Ireland) | MRCP (UK)America Board Of Electro Diagnostic Medicine',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Text(
                                'Reg. no: ',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                'G1235455',
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              //
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              'Patient details: Jane Doe, Female, 36 yrs, 9653256421',
                              style: TextStyle(fontSize: 12),
                            )),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date: 27 June, 2024, 04:37pm',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Patient ID: 100325',
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Text(
                      'Patient medical history:',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                    Divider(
                      height: 0,
                    ),
                    Row(
                      children: [
                        Text(
                          'Family history: ',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Row(
                            children: List.generate(['Asthma, ', 'Hypertension'].length,
                                (index) => Text(['Asthma, ', 'Hypertension'][index], style: TextStyle(fontSize: 12))))
                      ],
                    ),
                    Row(
                      children: [
                        Text('Medical Procedures: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        Row(
                            children:
                                List.generate(['Heart Sugery'].length, (index) => Text(['Heart Sugery'][index], style: TextStyle(fontSize: 12))))
                      ],
                    ),
                    Row(
                      children: [
                        Text('Medication: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        Row(
                            children: List.generate(['Dolo 600mg, ', 'Paracetamol'].length,
                                (index) => Text(['Dolo 600mg, ', 'Paracetamol'][index], style: TextStyle(fontSize: 12))))
                      ],
                    ),
                    Row(
                      children: [
                        Text('Allergies: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        Row(
                            children: List.generate(
                                ['Pollen, ', 'Sunlight'].length, (index) => Text(['Pollen, ', 'Sunlight'][index], style: TextStyle(fontSize: 12))))
                      ],
                    ),
                    Row(
                      children: [
                        Text('Phobias/Fears: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        Row(
                            children: List.generate(
                                ['Pollen, ', 'Sunlight'].length, (index) => Text(['Pollen, ', 'Sunlight'][index], style: TextStyle(fontSize: 12))))
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text('Vitals', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                    Divider(
                      height: 0,
                    ),
                    Row(
                      children: [
                        Text(
                          'Family history: ',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Row(
                            children: List.generate(['Asthma, ', 'Hypertension'].length,
                                (index) => Text(['Asthma, ', 'Hypertension'][index], style: TextStyle(fontSize: 12))))
                      ],
                    ),
                    Row(
                      children: [
                        Text('Medical Procedures: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        Row(
                            children:
                                List.generate(['Heart Sugery'].length, (index) => Text(['Heart Sugery'][index], style: TextStyle(fontSize: 12))))
                      ],
                    ),
                    Row(
                      children: [
                        Text('Medication: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        Row(
                            children: List.generate(['Dolo 600mg, ', 'Paracetamol'].length,
                                (index) => Text(['Dolo 600mg, ', 'Paracetamol'][index], style: TextStyle(fontSize: 12))))
                      ],
                    ),
                    Row(
                      children: [
                        Text('Allergies: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        Row(
                            children: List.generate(
                                ['Pollen, ', 'Sunlight'].length, (index) => Text(['Pollen, ', 'Sunlight'][index], style: TextStyle(fontSize: 12))))
                      ],
                    ),
                    Row(
                      children: [
                        Text('Phobias/Fears: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        Row(
                            children: List.generate(
                                ['Pollen, ', 'Sunlight'].length, (index) => Text(['Pollen, ', 'Sunlight'][index], style: TextStyle(fontSize: 12))))
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 150, child: Text('Chief Complaints', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700))),
                        SizedBox(
                          width: 50,
                        ),
                        Text('Clinical Findings', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700))
                      ],
                    ),
                    Divider(
                      height: 0,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 150, child: Text('Fever', style: TextStyle(fontSize: 12))),
                        SizedBox(
                          width: 50,
                        ),
                        Text('Notes', style: TextStyle(fontSize: 12))
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 150, child: Text('Fever')),
                        SizedBox(
                          width: 50,
                        ),
                        Text('Notes')
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text('Diagnosis', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                    Divider(
                      height: 0,
                    ),
                    Text('Pneumonia', style: TextStyle(fontSize: 12)),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 40, child: Text('Drugs', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700))),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(width: 50, child: Text('Dosage', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700))),
                        SizedBox(
                          width: 8,
                        ),
                        SizedBox(width: 40, child: Text('Time', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700))),
                        SizedBox(
                          width: 8,
                        ),
                        SizedBox(width: 70, child: Text('Frequency', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700))),
                        SizedBox(
                          width: 8,
                        ),
                        SizedBox(width: 60, child: Text('Duration', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700))),
                        SizedBox(
                          width: 8,
                        ),
                        SizedBox(width: 40, child: Text('Notes', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700))),
                      ],
                    ),
                    Divider(
                      height: 0,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 40, child: Text('Tab DOLO 500mg', style: TextStyle(fontSize: 12))),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(width: 50, child: Text('1', style: TextStyle(fontSize: 12))),
                        SizedBox(
                          width: 8,
                        ),
                        SizedBox(width: 40, child: Text('Before Meal', style: TextStyle(fontSize: 12))),
                        SizedBox(
                          width: 8,
                        ),
                        SizedBox(width: 70, child: Text('1-0-1', style: TextStyle(fontSize: 12))),
                        SizedBox(
                          width: 8,
                        ),
                        SizedBox(width: 60, child: Text('5 days', style: TextStyle(fontSize: 12))),
                        SizedBox(
                          width: 8,
                        ),
                        SizedBox(width: 40, child: Text('Notes', style: TextStyle(fontSize: 12))),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        SizedBox(width: 40, child: Text('Syp Ambrodel', style: TextStyle(fontSize: 12))),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(width: 50, child: Text('10ml', style: TextStyle(fontSize: 12))),
                        SizedBox(
                          width: 8,
                        ),
                        SizedBox(width: 40, child: Text('After Meal', style: TextStyle(fontSize: 12))),
                        SizedBox(
                          width: 8,
                        ),
                        SizedBox(width: 70, child: Text('1-0-1', style: TextStyle(fontSize: 12))),
                        SizedBox(
                          width: 8,
                        ),
                        SizedBox(width: 60, child: Text('5 days', style: TextStyle(fontSize: 12))),
                        SizedBox(
                          width: 8,
                        ),
                        SizedBox(width: 40, child: Text('Notes', style: TextStyle(fontSize: 12))),
                      ],
                    ),
                    Divider(),
                    SizedBox(
                      height: 15,
                    ),
                    Text('Advice/Instructions', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                    Divider(
                      height: 0,
                    ),
                    Text('Eat a balanced diet with lots of fibre. Drink lots of water. Drink Electrolyte Solutions to stay hydrated',
                        style: TextStyle(fontSize: 12)),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text('Follow up', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                        SizedBox(
                          width: 8,
                        ),
                        Text('None', style: TextStyle(fontSize: 12))
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 15,
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [Text('Ph: ', style: TextStyle(fontSize: 12)), Text('9659355321', style: TextStyle(fontSize: 12))],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [Text('email: ', style: TextStyle(fontSize: 12)), Text('Bhaila@gmail.com', style: TextStyle(fontSize: 12))],
                        )
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Add: ', style: TextStyle(fontSize: 12)),
                              Expanded(
                                  child: Text('123 Street near HN Market, 2nd floor, Hydrabad, Telangana, 669682', style: TextStyle(fontSize: 12)))
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Timings: ', style: TextStyle(fontSize: 12)),
                              Expanded(child: Text('8:30 am - 10:50 pm Mon-Fri', style: TextStyle(fontSize: 12)))
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 50,
                color: AppColors.lightGrey,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(children: [
        //? CLEAR
        Expanded(
            child: MyElevatedButton(
                text: "Print",
                height: 61,
                textStyle: const TextStyle(color: AppColors.eerieBlack, fontSize: 17),
                backgroundColor: AppColors.whiteSmoke,
                onPressed: () async {
                  /*try {
                    final tempDir = await getApplicationCacheDirectory();
                    File file = await File('${tempDir!.path}/image.png').create();
                    if (bytes != null) {
                      file.writeAsBytesSync(bytes);
                    }
                    log(tempDir.path);
                    final params = SaveFileDialogParams(sourceFilePath: file.path);
                    final filePath = await FlutterFileDialog.saveFile(params: params);
                  } catch (e) {
                    log(e.toString());
                  }*/
                  PrescriptionPdf().generate(context);
                })),

        const SizedBox(width: 20),

        //? CLEAR
        Expanded(
          child: MyElevatedButton(
            text: "Make Receipt",
            height: 61,
            textStyle: const TextStyle(fontSize: 17),
            onPressed: () {
              context.pushNamed(AppRoutes.paymentReceiptScreen.name);
            },
          ),
        ),
      ]).pSymmetric(vertical: 8),
    );
  }
}
