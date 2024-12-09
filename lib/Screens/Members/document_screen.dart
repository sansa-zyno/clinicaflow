import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';
import 'package:healtether_clinic_app/Screens/Members/ManageStaff/id_proof_dropdown.dart';
import 'package:healtether_clinic_app/Screens/Members/payment_detail_screen.dart';
import 'package:healtether_clinic_app/Screens/Members/patients_records/patients_records.dart';
import 'package:healtether_clinic_app/business_logic/cubits/patient_records_cubit/patient_records_cubit.dart';
import 'package:healtether_clinic_app/data_layer/models/patient_records_model/post/documents_patient_model.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/create_staff_model.dart';
import 'package:healtether_clinic_app/data_layer/models/patient_records_model/post/patient_create_model.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/document_staff_model.dart';
import 'package:healtether_clinic_app/data_layer/services/shared_preferences_service.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:healtether_clinic_app/utils/snackbar.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:file_picker/file_picker.dart';

class DocumentScreen extends StatefulWidget {
  final PageController? pageController;
  final PatientCreate? patientCreate;
  final CreateStaff? createStaff;
  final bool forStaff;

  const DocumentScreen({
    super.key,
    required this.forStaff,
    this.pageController,
    this.patientCreate,
    this.createStaff,
  });

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  TextEditingController idController = TextEditingController();
  TextEditingController additionalIDController = TextEditingController();
  List<String> docs = [];
  List<DocumentsPatient>? patDocs = [];
  List<Documents>? staffDocs = [];
  String? idProofText;
  bool showID = false;
  int currentPageIndex = 2;
  final PageController pageController = PageController(initialPage: 2);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          // leadingWidth: 30,
          //automaticallyImplyLeading: false,
          title: const Text(
            AppText.addMember,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            widget.forStaff
                ? TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentDetailScreen(
                                  createStaff: widget.createStaff!,
                                )),
                      );
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Color(0XFF4646B5),
                        fontSize: 18,
                      ),
                    ),
                  )
                : Container(),
            /*IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),*/
          ],
        ),
        body: BlocListener<PatientRecordsCubit, PatientRecordsState>(
          listener: (context, state) {
            if (state.state == PatientRecordsStates.patientPosted) {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              showSnackbar("Patient created successfully", context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PatientRecords()),
              );
            }
          },
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SmoothPageIndicator(
                            controller: pageController,
                            count: widget.forStaff ? 5 : 3,
                            effect: const ExpandingDotsEffect(
                              expansionFactor: 5,
                              dotColor: Color(0XFF5351C7),
                              strokeWidth: 3,
                              dotHeight: 8,
                              dotWidth: 8,
                              paintStyle: PaintingStyle.fill,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            AppText.documents,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: IdProofDropDown(
                                  value: idProofText,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      idProofText = newValue;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: idController,
                            keyBoardType: TextInputType.number,
                            hintText: AppText.iDNo,
                            height: 52,
                          ),
                          const SizedBox(height: 10),
                          if (showID)
                            CustomTextField(
                              controller: additionalIDController,
                              keyBoardType: TextInputType.number,
                              hintText: AppText.additionalID,
                              height: 52,
                            ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showID = true;
                              });
                            },
                            child: const Row(
                              children: [
                                Icon(Icons.add, color: AppColors.blueViolet),
                                Text(
                                  AppText.addAnotherID,
                                  style: TextStyle(color: AppColors.blueViolet),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 2,
                              width: screenSize.width * 0.6,
                              color: AppColors.blueViolet,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Divider(),
                          const Text(
                            AppText.addDocuments,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            AppText.uploadImage,
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            onTap: () async {
                              FilePickerResult? result = await FilePicker.platform.pickFiles();

                              if (result != null) {
                                PlatformFile file = result.files.first;
                                setState(() {
                                  if (!docs.contains(file.name)) {
                                    docs.add(file.name);
                                    if (widget.forStaff != true) {
                                      patDocs!.add(DocumentsPatient(fileName: file.path, blobName: file.path));
                                    } else {
                                      staffDocs!.add(Documents(fileName: file.path, blobName: file.path));
                                    }
                                  }
                                });
                              } else {
                                // User canceled the picker
                              }
                            },
                            child: Container(
                              height: 35,
                              width: 370,
                              decoration: BoxDecoration(
                                color: AppColors.greyColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Browse to upload documents',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 65,
                                    ),
                                    Icon(
                                      Icons.cloud_upload_outlined,
                                      color: AppColors.whiteColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Divider(),
                          docs.isNotEmpty
                              ? const Text(
                                  AppText.list,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              : const SizedBox(),
                          Column(
                            children: docs
                                .map((e) => Row(
                                      children: [
                                        Text(
                                          e.split('_').last,
                                          style: const TextStyle(
                                            color: Color(0xff6D6D6D),
                                            fontSize: 12,
                                          ),
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            IconButton(onPressed: () {}, icon: const Icon(Icons.find_in_page_rounded)),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    docs.remove(e);
                                                  });
                                                },
                                                icon: const Icon(Icons.delete)),
                                          ],
                                        ),
                                      ],
                                    ))
                                .toList(),
                          ),
                          const SizedBox(
                            height: 140,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              BlocBuilder<PatientRecordsCubit, PatientRecordsState>(builder: (context, state) {
                if (state.state == PatientRecordsStates.postingPatient) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 50),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return GestureDetector(
                    onTap: () async {
                      if (widget.forStaff == true) {
                        widget.createStaff?.documentType = idProofText;
                        widget.createStaff?.documentNumber = idController.text;
                        widget.createStaff?.documents = staffDocs;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PaymentDetailScreen(createStaff: widget.createStaff!)),
                        );
                      } else {
                        String clinicId = await SharedPrefService.getClinicId() ?? '';
                        //log('ClinicId>>>>>  $clinicId');
                        widget.patientCreate?.documentType = idProofText;
                        widget.patientCreate?.documentNumber = idController.text;
                        widget.patientCreate?.documents = patDocs;
                        widget.patientCreate?.createdOn = convertDatetimeFormat(DateTime.now());
                        widget.patientCreate?.modifiedOn = convertDatetimeFormat(DateTime.now());
                        widget.patientCreate?.clientId = clinicId;
                        if (clinicId != '') {
                          await context.read<PatientRecordsCubit>().postPatient(widget.patientCreate!);
                        }
                      }
                    },
                    child: Container(
                      height: 52,
                      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.greenColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          AppText.save,
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  );
                }
              }),
            ],
          ),
        ));
  }

  String convertDatetimeFormat(DateTime dateTime) {
    // Parse the input datetime string into a DateTime object

    // Format the DateTime object into the desired output format
    String formattedDatetime = DateFormat('dd/MM/yyyy, HH:mm:ss').format(dateTime);

    return formattedDatetime;
  }
}
