import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/patients_records/add_prescription_screen.dart';
import 'package:healtether_clinic_app/business_logic/cubits/is_edit_cubit/is_edit_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/patient_detail/patient_detail_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/patient_detail/patient_detail_state.dart';
import 'package:healtether_clinic_app/data_layer/models/patient/patient_model_id.dart';
import 'package:healtether_clinic_app/data_layer/models/patient_records_model/patient_model.dart';
import 'package:healtether_clinic_app/business_logic/cubits/patient_records_cubit/patient_records_cubit.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';
import 'package:intl/intl.dart';

class PatientRecordsScreen extends StatefulWidget {
  final PatientOverviewModel patient;

  const PatientRecordsScreen({
    super.key,
    required this.patient,
  });

  @override
  State<PatientRecordsScreen> createState() => _PatientRecordsScreenState();
}

class _PatientRecordsScreenState extends State<PatientRecordsScreen> {
  // late PatientRecordsProvider patientRecordsProvider;

  // @override
  // void initState() {
  //   super.initState();
  //   _initialLoad();
  // }
  //
  // Future<void> _initialLoad() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   try {
  //     GetPatientService service = GetPatientService();
  //     GetPatient getPatient = await service.fetchPatients();
  //     setState(() {
  //       _patients = getPatient.data ?? [];
  //       _totalCount = getPatient.totalCount ?? 0;
  //       _isLoading = false;
  //     });
  //   } catch (error) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     print('Failed to load patients: $error');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PatientDetailCubit>(context).fetchData(widget.patient.id!);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: const Text(AppText.patientRecords),
      ),
      body: BlocBuilder<PatientDetailCubit, PatientDetailState>(
          builder: (context, state) {
        PatientByIdModel? data;
        if (state is PatientDetailLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        // List<Data> patient = provider.patients;

        if (state is PatientDetailLoadedState) {
          data = state.data;
        }
        print("DATA : $data");
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              // patient.map((patient) {
              //   return
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.patient.initials,

                            // provider. patients[0].lastName ?? 'No name',
                            style: const TextStyle(
                              color: AppColors.lightBlueColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data!.firstName} ${data.lastName}",
                                style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 23,
                                    color: AppColors.blackColor),
                              ),
                              Text(
                                // widget.  patient.mobile.toString(),
                                "+91 ${data.mobile.toString()}",
                                // patient.mobile ?? '',
                                // provider.patients[0].mobile ?? '',
                                style: const TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: AppColors.blackLightColor),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      print(widget.patient.id);
                                      context
                                          .read<IsEditCubit>()
                                          .setValue(true, widget.patient.id!);
                                      context.pushNamed(
                                        AppRoutes.editProfile.name,
                                      );

                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     //TOD: CHANGE TO GOROUTER
                                      //     builder: (context) =>
                                      //         const EditProfiles(),
                                      //   ),
                                      // );
                                    },
                                    style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color(0xffF8F7FC)),
                                    ),
                                    child: const Text(
                                      AppText.editProfile,
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: AppColors.blackColor,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    height: 41,
                                    decoration: BoxDecoration(
                                      color: AppColors.greenColor,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const AddPrescriptionScreen(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        "Add records",
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: AppColors.whiteColor,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Column(
                                        children: [
                                          Text(
                                            'Do you want to delete the patient from the directory?',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                            'The patient details will be deleted permanently.',
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    const Color(0xff32856E)),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                              ),
                                            ),
                                            minimumSize:
                                                MaterialStateProperty.all(
                                                    const Size(110, 50)),
                                          ),
                                          child: const Text(
                                            'No',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            deletePatient(widget.patient);
                                            Navigator.of(context).pop();
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              const Color(0xFF0F8F7FC),
                                            ),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                              ),
                                            ),
                                            minimumSize:
                                                MaterialStateProperty.all(
                                                    const Size(110, 50)),
                                          ),
                                          child: const Text(
                                            'Yes',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.delete, size: 22),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        AppText.PERSONALDETAILS,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                      greenLine(),
                      const SizedBox(height: 10),
                      detailRowWidget(
                          title: 'Birthday',
                          subTitle: data.birthday != null
                              ? DateFormat('yyyy-MM-dd').format(data.birthday!)
                              : ""),
                      const SizedBox(height: 8),
                      detailRowWidget(
                          title: 'Age', subTitle: data.age.toString()),
                      const SizedBox(height: 8),
                      detailRowWidget(subTitle: data.gender, title: 'Gender'),
                      const SizedBox(height: 8),
                      detailRowWidget(
                          subTitle: data.height.toString() + ' cm',
                          title: 'Height'),
                      const SizedBox(height: 8),
                      detailRowWidget(
                          subTitle: data.weight.toString() + ' kg',
                          title: 'Weight'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        AppText.CONTACTDETAILS,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                      greenLine(),
                      const SizedBox(height: 10),
                      detailRowWidget(
                          subTitle: "+91 ${widget.patient.mobile ?? ''}",
                          title: 'Mobile'),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 120,
                            child: Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 28,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/homeimages/whatsapp.png'))),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                          const Text(':'),
                          const SizedBox(width: 28),
                          Expanded(
                            child: Text(
                              // patient.mobile ?? '',
                              "+91 ${widget.patient.mobile ?? ''}",
                              style: robotoBold,
                              softWrap: true,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      detailRowWidget(subTitle: data.email, title: 'Email'),
                      const SizedBox(height: 8),
                      detailRowWidget(
                          subTitle:
                              "${data.address!.house} ${data.address!.street} ${data.address!.landmarks} ${data.address!.city} ${data.address!.pincode}",
                          title: 'Address'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 8),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          AppText.BANKDETAILS,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        greenLine(),
                        const SizedBox(height: 10),
                        detailRowWidget(subTitle: 'test@ybl', title: 'UPI ID'),
                        const SizedBox(height: 8),
                        detailRowWidget(subTitle: 'Indian Bank', title: 'Bank'),
                        const SizedBox(height: 8),
                        detailRowWidget(
                            subTitle: '5213 5123 6554 5894', title: 'A/c no.'),
                        const SizedBox(height: 8),
                        detailRowWidget(
                            subTitle: 'IDBI000H013', title: 'IFSC code'),
                        const SizedBox(height: 8),
                        detailRowWidget(
                            subTitle: 'Jane Doe', title: 'Account Holder'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 8),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        greenLine(),
                        const SizedBox(height: 10),
                        detailRowWidget(
                            subTitle: data.documentType, title: ' ID type'),
                        const SizedBox(height: 8),
                        detailRowWidget(
                            subTitle: data.documentNumber, title: 'ID no.'),
                        const SizedBox(height: 8),
                        detailRowWidget(
                            subTitle: '', title: 'Other Documents '),
                        Column(
                          children: data.documents
                              .map((e) => detailsRowWidget(
                                  subTitle: e['blobName'],
                                  title: e['fileName']))
                              .toList(),
                        )
                      ],
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 8),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'APPOINTMENT HISTORY',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                        greenLine(),
                        const SizedBox(height: 10),
                        detailsRowWidget(
                            subTitle: '',
                            title: '1. High_feverConsulation_01jjuly23.p...'),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 8),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'MEDICAL  RECORDS',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                        greenLine(),
                        const SizedBox(height: 10),
                        detailsRowWidget(
                            subTitle: '', title: '1.X-ray report_28may23.pdf'),
                        const SizedBox(height: 8),
                        detailsRowWidget(
                            subTitle: '',
                            title: '2. Blood test report_28may23.pdf'),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 8),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'PROCEDURE  RECORDS',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                        greenLine(),
                        const SizedBox(height: 10),
                        detailsRowWidget(
                            subTitle: '', title: '1.Consulation_01july23.pdf'),
                        const SizedBox(height: 8),
                        detailsRowWidget(
                            subTitle: '',
                            title: '2. Minor surgery_28may23.pdf'),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 8),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'PAYMENTS  RECORDS',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                        greenLine(),
                        const SizedBox(height: 10),
                        detailsRowWidget(
                          subTitle: '',
                          title: '1.Consulation fee_1july 2023 receipt',
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              )
            ] // }).toList(),
                ),
          ),
        );
      }),
    );
  }

  Container greenLine() {
    return Container(
      height: 2,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.greenLightColor,
      ),
    );
  }

  TextStyle get robotoBold => GoogleFonts.roboto(
          textStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        height: 22.08 / 16,
        color: AppColors.eerieBlack,
      ));

  Row detailRowWidget({required String title, required String subTitle}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(0xFF6D6D6D),
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Text(':'),
        const SizedBox(width: 28),
        Expanded(
          child: Text(
            subTitle,
            style: robotoBold,
            softWrap: true,
            overflow: TextOverflow.clip,
          ),
        )
      ],
    );
  }

  Row detailsRowWidget({required String title, required String subTitle}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: robotoBold,
          ),
        ),
        // const SizedBox(width: 8),
        // Expanded(
        //   child: Text(
        //     subTitle,
        //     style: robotoBold,
        //     softWrap: true,
        //     overflow: TextOverflow.clip,
        //   ),
        // ),
        const SizedBox(width: 10),
        const Icon(Icons.find_in_page_rounded),
      ],
    );
  }

  String _getInitials(String name) {
    List<String> nameSplit = name.split(" ");
    String initials = "";
    int numWords = 2;

    if (nameSplit.length >= numWords) {
      for (int i = 0; i < numWords; i++) {
        initials += '${nameSplit[i][0]}';
      }
    } else {
      for (int i = 0; i < nameSplit.length; i++) {
        initials += '${nameSplit[i][0]}';
      }
    }
    return initials.toUpperCase();
  }

  void deletePatient(PatientOverviewModel patientModel) {
    print(patientModel.id);
    print(patientModel.sId);
    context.read<PatientRecordsCubit>().deletePatient(patientModel.id!);
    // if (mounted) {
    context.pop();
    // }
  }
}
