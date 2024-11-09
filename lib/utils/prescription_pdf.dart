import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart' as mt;
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';
import 'package:healtether_clinic_app/utils/mixins/ui_info_mixin.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:flutter/services.dart' show rootBundle;

class PrescriptionPdf with UiInfoMixin {
  generate(mt.BuildContext context) async {
    final Directory? directory;
    //final ByteData fontData = await rootBundle.load('assets/fonts/Outfit/static/Outfit-Regular.ttf');
    //final ttf = pw.Font.ttf(fontData.buffer.asByteData());
    final image = MemoryImage(
      (await rootBundle.load('assets/homeimages/Ellipse 250.png')).buffer.asUint8List(),
    );
    try {
      final pdf = Document();
      pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(), /*color: PdfColor.fromInt(Colors.white.value)*/
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  color: PdfColor.fromInt(AppColors.lightGrey.value),
                ),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Image(
                          image,
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
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                'Dr. Ajit Bhaia , Neurologist',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
                    )),
                Divider(),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
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
                ),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(
                        'Patient medical history:',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
                    ])),
                SizedBox(
                  height: 15,
                ),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Vitals', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
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
                    ])),
                SizedBox(
                  height: 15,
                ),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(
                        children: [
                          SizedBox(width: 150, child: Text('Chief Complaints', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                          SizedBox(
                            width: 50,
                          ),
                          Text('Clinical Findings', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
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
                    ])),
                SizedBox(
                  height: 15,
                ),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Diagnosis', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      Divider(
                        height: 0,
                      ),
                      Text('Pneumonia', style: TextStyle(fontSize: 12)),
                    ])),
                SizedBox(
                  height: 15,
                ),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(
                        children: [
                          SizedBox(width: 40, child: Text('Drugs', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(width: 50, child: Text('Dosage', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                          SizedBox(
                            width: 8,
                          ),
                          SizedBox(width: 40, child: Text('Time', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                          SizedBox(
                            width: 8,
                          ),
                          SizedBox(width: 70, child: Text('Frequency', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                          SizedBox(
                            width: 8,
                          ),
                          SizedBox(width: 60, child: Text('Duration', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                          SizedBox(
                            width: 8,
                          ),
                          SizedBox(width: 40, child: Text('Notes', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
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
                    ])),
                SizedBox(
                  height: 15,
                ),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Advice/Instructions', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
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
                          Text('Follow up', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 8,
                          ),
                          Text('None', style: TextStyle(fontSize: 12))
                        ],
                      ),
                    ])),
                SizedBox(
                  height: 15,
                ),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Divider(),
                      Row(
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
                                        child:
                                            Text('123 Street near HN Market, 2nd floor, Hydrabad, Telangana, 669682', style: TextStyle(fontSize: 12)))
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
                    ])),
                Container(
                  height: 50,
                  color: PdfColor.fromInt(AppColors.lightGrey.value),
                ),
              ],
            ),
          )
        ],
      ));
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = await getDownloadsDirectory();
      }
      if (directory == null) {
        //CustomSnackbar.showBottom(context, "Document directory not available");
        return;
      }
      String path = directory.path;
      String myFile = '$path/healthether-precription.pdf';
      final file = File(myFile);
      await file.writeAsBytes(await pdf.save());
      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final filePath = await FlutterFileDialog.saveFile(params: params);
      if (filePath != null) {
        showSnackMessage(context, 'Your prescription is downloaded');
      } else {
        showSnackMessage(context, 'Error occurred while downloading prescription');
      }
    } catch (e) {
      log("$e");
      showSnackMessage(context, 'Error occurred');
    }
  }
}
