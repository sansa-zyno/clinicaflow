import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clinica_flow/core/network/api_endpoints.dart';
import 'package:clinica_flow/features/prescription/model/prescription_report.dart';
import 'package:clinica_flow/features/vitals/model/vital.dart';
import 'package:clinica_flow/core/utils/enums/route_enums.dart';
import 'package:clinica_flow/core/utils/extensions.dart/widget_extensions.dart';
import 'package:clinica_flow/core/utils/prescription_pdf.dart';
import 'package:clinica_flow/shared/widgets/buttons/my_elevated_button.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text.dart';
import '../../medication/model/drug_model.dart';

class PrescriptionPreview extends StatefulWidget {
  final PrescriptionReport prescriptionReport;
  const PrescriptionPreview({
    Key? key,
    required this.prescriptionReport,
  }) : super(key: key);

  @override
  State<PrescriptionPreview> createState() => _PrescriptionPreviewState();
}

class _PrescriptionPreviewState extends State<PrescriptionPreview> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Vital? vital = widget.prescriptionReport.vitals;
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
          margin: const EdgeInsets.all(8),
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
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40,
                      child:
                          (widget.prescriptionReport.clinic?.logo ?? '') == ''
                              ? Image.asset(
                                  'assets/homeimages/Group 36536.png',
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  "${ApiEndPoint.logoBaseUrl}${widget.prescriptionReport.clinic!.logo}",
                                  height: 60,
                                  width: 60,
                                ),
                      //backgroundImage: AssetImage('assets/homeimages/Group 36536.png'),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.prescriptionReport.clinic?.clinicName ?? '',
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            'Dr. ${widget.prescriptionReport.doctorName ?? 'N/A'}',
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.prescriptionReport.doctorId
                                          ?.specialization ??
                                      'N/A',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          /*  const SizedBox(height: 6),
                          Row(
                            children: [
                              Text(
                                'Reg. no: ',
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                'G1235455',
                                style: const TextStyle(fontSize: 12),
                              )
                            ],
                          )*/
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Divider(),
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
                              'Patient details: ${widget.prescriptionReport.patientName}, ${widget.prescriptionReport.patientGender}, ${widget.prescriptionReport.patientAge} yrs, ${widget.prescriptionReport.patientMobile}',
                              style: const TextStyle(fontSize: 12),
                            )),
                        const SizedBox(width: 30),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date: ${DateFormat('dd MMM, yyyy, hh:mm a').format(widget.prescriptionReport.appointmentDate!)}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Patient ID: ${widget.prescriptionReport.clinicPatientId}',
                                style: const TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    /* Text(
                      'Patient medical history:',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                    Divider(
                      height: 0,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Family history: ',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Row(
                            children: List.generate(widget.medicalHistory?['familyHistory']?.length ?? 0,
                                (index) => Text(widget.medicalHistory?['familyHistory']![index].name ?? '', style: const TextStyle(fontSize: 12))))
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Medical Procedures: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        Row(
                            children: List.generate(
                                widget.medicalHistory?['pastProcedureHistory']?.length ?? 0,
                                (index) =>
                                    Text(widget.medicalHistory?['pastProcedureHistory']![index].name ?? '', style: const TextStyle(fontSize: 12))))
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Medication: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        Row(
                            children: List.generate(widget.medicalHistory?['medication']?.length ?? 0,
                                (index) => Text(widget.medicalHistory?['medication']![index].name ?? '', style: const TextStyle(fontSize: 12))))
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Allergies: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        Row(
                            children: List.generate(widget.medicalHistory?['allergies']?.length ?? 0,
                                (index) => Text(widget.medicalHistory?['allergies']![index].name ?? '', style: const TextStyle(fontSize: 12))))
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),*/
                    const Text(
                      'Vitals',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                    const Divider(height: 0),
                    Row(
                      children: [
                        const Text(
                          'Blood Pressure: ',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Text(
                            (vital?.bloodPressure?.systolic ?? '') != '' &&
                                    (vital?.bloodPressure?.diastolic ?? '') !=
                                        ''
                                ? '${vital?.bloodPressure?.systolic}/${vital?.bloodPressure?.diastolic} mm Hg'
                                : '',
                            style: const TextStyle(fontSize: 12))
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'SpO2 levels: ',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Text(
                            (vital?.spo2 ?? '') != '' ? '${vital?.spo2} %' : '',
                            style: const TextStyle(fontSize: 12))
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
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
                        const Text(
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
                        const Text(
                          'Temperature: ',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Text(
                            (vital?.temperature ?? '') != ''
                                ? '${vital?.temperature} \u2103'
                                : '',
                            style: const TextStyle(fontSize: 12))
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
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
                        const Text(
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
                        const Text(
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
                    const SizedBox(height: 15),
                    const Row(
                      children: [
                        SizedBox(
                            width: 150,
                            child: Text('Symptoms',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700))),
                        SizedBox(
                          width: 50,
                        ),
                        Text('Clinical Findings',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700))
                      ],
                    ),
                    const Divider(height: 0),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.prescriptionReport.prescriptions
                                ?.symptoms?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Row(
                              children: [
                                SizedBox(
                                    width: 150,
                                    child: Text(
                                        widget.prescriptionReport.prescriptions
                                                ?.symptoms?[index].name ??
                                            '',
                                        style: TextStyle(fontSize: 12))),
                                const SizedBox(width: 50),
                                Text(
                                    widget.prescriptionReport.prescriptions
                                            ?.symptoms?[index].privateNote ??
                                        '',
                                    style: TextStyle(fontSize: 12))
                              ],
                            ),
                          );
                        }),
                    const SizedBox(height: 15),
                    const Text('Diagnosis',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w700)),
                    const Divider(height: 0),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.prescriptionReport.prescriptions
                                ?.diagnosis?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                                widget.prescriptionReport.prescriptions
                                        ?.diagnosis?[index].name ??
                                    '',
                                style: TextStyle(fontSize: 12)),
                          );
                        }),
                    const SizedBox(height: 15),
                    const Row(
                      children: [
                        SizedBox(
                            width: 100,
                            child: Text('Drugs',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700))),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                            width: 50,
                            child: Text('Dosage',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700))),
                        SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                            width: 70,
                            child: Text('Time',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700))),
                        SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                            width: 70,
                            child: Text('Frequency',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700))),
                        /* SizedBox(
                          width: 8,
                        ),
                        SizedBox(width: 60, child: Text('Duration', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700))),
                        SizedBox(
                          width: 8,
                        ),
                        SizedBox(width: 40, child: Text('Notes', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700))),*/
                      ],
                    ),
                    const Divider(height: 0),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.prescriptionReport.prescriptions
                                ?.drugPrescriptions?.length ??
                            0,
                        itemBuilder: (context, index) {
                          Drug? drug = widget.prescriptionReport.prescriptions
                              ?.drugPrescriptions?[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Row(
                              children: [
                                SizedBox(
                                    width: 100,
                                    child: Text(drug?.name ?? '',
                                        style: TextStyle(fontSize: 12))),
                                const SizedBox(width: 10),
                                SizedBox(
                                    width: 50,
                                    child: Text(drug?.quantity ?? '',
                                        style: TextStyle(fontSize: 12))),
                                const SizedBox(width: 8),
                                SizedBox(
                                    width: 70,
                                    child: Text(drug?.dosageTime ?? '',
                                        style: TextStyle(fontSize: 12))),
                                const SizedBox(width: 8),
                                SizedBox(
                                    width: 70,
                                    child: Text(drug?.dosageFrequency ?? '',
                                        style: TextStyle(fontSize: 12))),
                                /* SizedBox(
                                  width: 8,
                                ),
                                SizedBox(
                                    width: 60,
                                    child: Text('${drug.duration?['value'] ?? ''} ${drug.duration?['unit'] ?? ''}', style: TextStyle(fontSize: 12))),
                                SizedBox(
                                  width: 8,
                                ),
                                const SizedBox(width: 40, child: Text('Notes', style: TextStyle(fontSize: 12))),*/
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Divider()),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text('Advice/Instructions',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w700)),
                    const Divider(height: 0),
                    Text(
                        widget.prescriptionReport.prescriptions
                                ?.patientAdvice ??
                            '',
                        style: TextStyle(fontSize: 12)),
                    const SizedBox(height: 15),
                    const Text('Follow-up',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w700)),
                    const Divider(height: 0),
                    Row(
                      children: [
                        const Text('Date:',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700)),
                        const SizedBox(width: 8),
                        Text(
                            widget.prescriptionReport.prescriptions
                                    ?.followUpDate
                                    ?.split('T')[0] ??
                                '',
                            style: TextStyle(fontSize: 12))
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Text('Time:',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700)),
                        const SizedBox(width: 8),
                        Text(
                            widget.prescriptionReport.prescriptions
                                    ?.followUpTimeSlot ??
                                '',
                            style: TextStyle(fontSize: 12))
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),
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
                          children: [
                            Text('Ph: ', style: TextStyle(fontSize: 12)),
                            Text(
                                widget.prescriptionReport.clinic?.adminUserId
                                        ?.mobile ??
                                    '',
                                style: TextStyle(fontSize: 12))
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text('email: ', style: TextStyle(fontSize: 12)),
                            Text(
                                widget.prescriptionReport.clinic?.adminUserId
                                        ?.email ??
                                    '',
                                style: TextStyle(fontSize: 12))
                          ],
                        )
                      ],
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Add: ', style: TextStyle(fontSize: 12)),
                              Expanded(
                                  child: Text(
                                      widget.prescriptionReport.clinic
                                              ?.address ??
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
                textStyle:
                    const TextStyle(color: AppColors.eerieBlack, fontSize: 17),
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
                  PrescriptionPdf().generate(context,
                      prescriptionReport: widget.prescriptionReport);
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
