import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:clinica_flow/features/medication/model/drug_model.dart';
import 'package:clinica_flow/features/prescription/model/prescription_report.dart';
import 'package:clinica_flow/features/vitals/model/vital.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart' as mt;
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:clinica_flow/core/network/api_endpoints.dart';
import 'package:clinica_flow/core/constants/app_colors.dart';
import 'package:clinica_flow/core/utils/mixins/ui_info_mixin.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:flutter/services.dart' show rootBundle;

class PrescriptionPdf with UiInfoMixin {
  generate(mt.BuildContext context,
      {required PrescriptionReport prescriptionReport}) async {
    final Directory? directory;
    Vital? vital = prescriptionReport.vitals;
    final ByteData fontData =
        await rootBundle.load('assets/fonts/Outfit/OutfitRegular.ttf');
    final ttf = Font.ttf(fontData.buffer.asByteData());
    var image;
    if ((prescriptionReport.clinic?.logo ?? '') == '') {
      image = MemoryImage(
        (await rootBundle.load('assets/homeimages/Ellipse 250.png'))
            .buffer
            .asUint8List(),
      );
    } else {
      // Construct the URL
      final String imageUrl =
          "${ApiEndPoint.logoBaseUrl}${prescriptionReport.clinic!.logo}";

      try {
        // Fetch image from URL
        final http.Response response = await http.get(Uri.parse(imageUrl));
        if (response.statusCode == 200) {
          // Convert response body to Uint8List
          image = MemoryImage(response.bodyBytes);
        } else {
          throw Exception('Failed to load image: ${response.statusCode}');
        }
      } catch (e) {
        log('Error loading image: $e');
        image = MemoryImage(
          (await rootBundle.load('assets/homeimages/Ellipse 250.png'))
              .buffer
              .asUint8List(),
        );
      }
    }

    try {
      final pdf = Document();
      pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border:
                  Border.all(), /*color: PdfColor.fromInt(Colors.white.value)*/
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
                          height: 60,
                          width: 60,
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
                                prescriptionReport.clinic?.clinicName ?? 'N/A',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                'Dr. ${prescriptionReport.doctorName ?? 'N/A'}',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      prescriptionReport
                                              .doctorId?.specialization ??
                                          'N/A',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                              /* SizedBox(
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
                              )*/
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
                            'Patient details: ${prescriptionReport.patientName}, ${prescriptionReport.patientGender}, ${prescriptionReport.patientAge} yrs, ${prescriptionReport.patientMobile}',
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
                              'Date: ${DateFormat('dd MMM, yyyy, hh:mm a').format(prescriptionReport.appointmentDate!)}',
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              'Patient ID: ${prescriptionReport.clinicPatientId}',
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                /*Padding(
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
                              children: List.generate(medicalHistory?['familyHistory']?.length ?? 0,
                                  (index) => Text(medicalHistory?['familyHistory']![index].name ?? '', style: const TextStyle(fontSize: 12))))
                        ],
                      ),
                      Row(
                        children: [
                          Text('Medical Procedures: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          Row(
                              children: List.generate(medicalHistory?['pastProcedureHistory']?.length ?? 0,
                                  (index) => Text(medicalHistory?['pastProcedureHistory']![index].name ?? '', style: const TextStyle(fontSize: 12))))
                        ],
                      ),
                      Row(
                        children: [
                          Text('Medication: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          Row(
                              children: List.generate(medicalHistory?['medication']?.length ?? 0,
                                  (index) => Text(medicalHistory?['medication']![index].name ?? '', style: const TextStyle(fontSize: 12))))
                        ],
                      ),
                      Row(
                        children: [
                          Text('Allergies: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          Row(
                              children: List.generate(medicalHistory?['allergies']?.length ?? 0,
                                  (index) => Text(medicalHistory?['allergies']![index].name ?? '', style: const TextStyle(fontSize: 12))))
                        ],
                      ),
                    ])),
                SizedBox(
                  height: 15,
                ),*/
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Vitals',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          Divider(
                            height: 0,
                          ),
                          Row(
                            children: [
                              Text(
                                'Blood Pressure: ',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  (vital?.bloodPressure?.systolic ?? '') !=
                                              '' &&
                                          (vital?.bloodPressure?.diastolic ??
                                                  '') !=
                                              ''
                                      ? '${vital?.bloodPressure?.systolic}/${vital?.bloodPressure?.diastolic} mm Hg'
                                      : '',
                                  style: const TextStyle(fontSize: 12))
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'SpO2 levels: ',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  (vital?.spo2 ?? '') != ''
                                      ? '${vital?.spo2} %'
                                      : '',
                                  style: const TextStyle(fontSize: 12))
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Pulse Rate: ',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  (vital?.pulseRate ?? '') != ''
                                      ? '${vital?.pulseRate} beats/min'
                                      : '',
                                  style: const TextStyle(fontSize: 12))
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Respiratory Rate: ',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  (vital?.respiratoryRate ?? '') != ''
                                      ? '${vital?.respiratoryRate} beats/min'
                                      : '',
                                  style: const TextStyle(fontSize: 12))
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Temperature: ',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  (vital?.temperature ?? '') != ''
                                      ? '${vital?.temperature} ˚C'
                                      : '',
                                  style: TextStyle(fontSize: 12, font: ttf))
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'RBS: ',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  (vital?.rbs ?? '') != ''
                                      ? '${vital?.rbs} mg/dL'
                                      : '',
                                  style: const TextStyle(fontSize: 12))
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Height: ',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  (vital?.height ?? '') != ''
                                      ? '${vital?.height} cm'
                                      : '',
                                  style: const TextStyle(fontSize: 12))
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Weight: ',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  (vital?.weight ?? '') != ''
                                      ? '${vital?.weight} Kg'
                                      : '',
                                  style: const TextStyle(fontSize: 12))
                            ],
                          ),
                        ])),
                SizedBox(
                  height: 15,
                ),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                  width: 150,
                                  child: Text('Symptoms',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold))),
                              SizedBox(
                                width: 50,
                              ),
                              Text('Clinical Findings',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          Divider(
                            height: 0,
                          ),
                          ListView.builder(
                              itemCount: prescriptionReport
                                      .prescriptions?.symptoms?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: 150,
                                          child: Text(
                                              prescriptionReport.prescriptions
                                                      ?.symptoms?[index].name ??
                                                  '',
                                              style: TextStyle(fontSize: 12))),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Text(
                                          prescriptionReport
                                                  .prescriptions
                                                  ?.symptoms?[index]
                                                  .privateNote ??
                                              '',
                                          style: TextStyle(fontSize: 12))
                                    ],
                                  ),
                                );
                              }),
                        ])),
                SizedBox(
                  height: 15,
                ),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Diagnosis',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          Divider(
                            height: 0,
                          ),
                          ListView.builder(
                              itemCount: prescriptionReport
                                      .prescriptions?.diagnosis?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Text(
                                      prescriptionReport.prescriptions
                                              ?.diagnosis?[index].name ??
                                          '',
                                      style: TextStyle(fontSize: 12)),
                                );
                              }),
                        ])),
                SizedBox(
                  height: 15,
                ),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                  width: 100,
                                  child: Text('Drugs',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold))),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                  width: 50,
                                  child: Text('Dosage',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold))),
                              SizedBox(
                                width: 8,
                              ),
                              SizedBox(
                                  width: 70,
                                  child: Text('Time',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold))),
                              SizedBox(
                                width: 8,
                              ),
                              SizedBox(
                                  width: 70,
                                  child: Text('Frequency',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold))),
                              /*  SizedBox(
                            width: 8,
                          ),
                          SizedBox(width: 60, child: Text('Duration', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                          SizedBox(
                            width: 8,
                          ),
                          SizedBox(width: 40, child: Text('Notes', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),*/
                            ],
                          ),
                          Divider(
                            height: 0,
                          ),
                          ListView.separated(
                              itemCount: prescriptionReport.prescriptions
                                      ?.drugPrescriptions?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                Drug? drug = prescriptionReport
                                    .prescriptions?.drugPrescriptions?[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: 100,
                                          child: Text(drug?.name ?? '',
                                              style: TextStyle(fontSize: 12))),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                          width: 50,
                                          child: Text(drug?.quantity ?? '',
                                              style: TextStyle(fontSize: 12))),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      SizedBox(
                                          width: 70,
                                          child: Text(drug?.dosageTime ?? '',
                                              style: TextStyle(fontSize: 12))),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      SizedBox(
                                          width: 70,
                                          child: Text(
                                              drug?.dosageFrequency ?? '',
                                              style: TextStyle(fontSize: 12))),
                                      /*  SizedBox(
                                    width: 8,
                                  ),
                                  SizedBox(
                                      width: 60,
                                      child:
                                          Text('${drug.duration?['value'] ?? ''} ${drug.duration?['unit'] ?? ''}', style: TextStyle(fontSize: 12))),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  SizedBox(width: 40, child: Text('Notes', style: TextStyle(fontSize: 12))),*/
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => Divider()),
                        ])),
                SizedBox(
                  height: 15,
                ),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Advice/Instructions',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          Divider(
                            height: 0,
                          ),
                          Text(
                              prescriptionReport.prescriptions?.patientAdvice ??
                                  '',
                              style: TextStyle(fontSize: 12)),
                          SizedBox(height: 15),
                          Text('Follow-up',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          Divider(height: 0),
                          Row(
                            children: [
                              Text('Date:',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 8),
                              Text(
                                  prescriptionReport.prescriptions?.followUpDate
                                          ?.split('T')[0] ??
                                      '',
                                  style: TextStyle(fontSize: 12))
                            ],
                          ),
                          SizedBox(height: 6),
                          Row(
                            children: [
                              Text('Time:',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 8),
                              Text(
                                  prescriptionReport
                                          .prescriptions?.followUpTimeSlot ??
                                      '',
                                  style: TextStyle(fontSize: 12))
                            ],
                          ),
                        ])),
                SizedBox(
                  height: 15,
                ),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text('Ph: ',
                                          style: TextStyle(fontSize: 12)),
                                      Text(
                                          prescriptionReport.clinic?.adminUserId
                                                  ?.mobile ??
                                              '',
                                          style: TextStyle(fontSize: 12))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Text('email: ',
                                          style: TextStyle(fontSize: 12)),
                                      Text(
                                          prescriptionReport
                                                  .clinic?.adminUserId?.email ??
                                              '',
                                          style: TextStyle(fontSize: 12))
                                    ],
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Add: ',
                                            style: TextStyle(fontSize: 12)),
                                        Expanded(
                                            child: Text(
                                                prescriptionReport
                                                        .clinic?.address ??
                                                    '',
                                                style: TextStyle(fontSize: 12)))
                                      ],
                                    ),
                                    /* SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Timings: ', style: TextStyle(fontSize: 12)),
                                    Expanded(child: Text('8:30 am - 10:50 pm Mon-Fri', style: TextStyle(fontSize: 12)))
                                  ],
                                )*/
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
        showSnackMessage(
            context, 'Error occurred while downloading prescription');
      }
    } catch (e) {
      log("$e");
      showSnackMessage(context, 'Error occurred');
    }
  }
}
