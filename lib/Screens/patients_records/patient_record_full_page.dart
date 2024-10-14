import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/Screens/patient_profile/edit_profile/edit_profile.dart';
import 'package:healtether_clinic_app/business_logic/blocs/patient_records_bloc/patient_records_bloc.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/data_layer/models/patient/patient_model.dart';
import 'package:healtether_clinic_app/widgets/customButton.dart';
import 'package:healtether_clinic_app/widgets/custom_row.dart';
import 'package:intl/intl.dart';

class PatientDetails extends StatefulWidget {
  final String id;
  const PatientDetails({super.key, required this.id});

  @override
  State<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  PatientRecordsBloc patientBloc = PatientRecordsBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    patientBloc.add(LoadPatientFullRecordEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppText.patientRecord),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: BlocBuilder<PatientRecordsBloc, PatientRecordsState>(
            bloc: patientBloc,
            buildWhen: (previous, current) => current is SinglePatientRecord,
            builder: (context, state) {
              if (state is SinglePatientRecordLoadedstate) {
                PatientModel patient = state.patient;
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              AssetImage("assets/homeimages/janaDoe.png"),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${patient.firstName} ${patient.lastName}",
                                  style: const TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("+91 ${patient.mobile} "),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const EditProfile(),
                                            )),
                                        child: const CustomButton(
                                          data: AppText.editProfile,
                                          Textsize: 13,
                                          color: Color(0XFFF8F7FC),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        child: const CustomButton(
                                          data: AppText.startConsultation,
                                          color: AppColors.greenColor,
                                          Textsize: 13,
                                          Textcolor: AppColors.whiteColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    personalDetails(
                      age: patient.age,
                      height: patient.height,
                      weight: patient.weight,
                      gender: patient.gender,
                      birthday: patient.birthday,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    ContactDetails(
                      mobile: patient.mobile,
                      address: patient.address,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    const BankDetails()
                  ],
                );
              }

              if (state is SinglePatientFullRecordLoadFailedState) {
                return const Center(
                  child: Text("Unable to Fetch details"),
                );
              }

              return const Center(
                child: Text("Loading....."),
              );
            },
          ),
        ),
      ),
    );
  }
}

class personalDetails extends StatelessWidget {
  final DateTime birthday;
  final int age;
  final String gender;
  final double? height;
  final double? weight;
  const personalDetails(
      {super.key,
      required this.age,
      required this.gender,
      required this.height,
      required this.weight,
      required this.birthday});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppText.personalDetails,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Container(
            height: 3,
            color: AppColors.greenLightColor,
            width: 80,
          ),
          const SizedBox(
            height: 8,
          ),
          CustomRow(
              first: "BirthDay",
              second: DateFormat('dd/MM/yyyy').format(birthday)),
          const SizedBox(
            height: 8,
          ),
          CustomRow(first: "Age", second: age.toString()),
          const SizedBox(
            height: 8,
          ),
          CustomRow(first: "Gender", second: gender),
          const SizedBox(
            height: 8,
          ),
          CustomRow(first: "Height", second: "${height ?? "-"} cm"),
          const SizedBox(
            height: 8,
          ),
          CustomRow(first: "Weight", second: "${weight ?? "-"} kg"),
        ],
      ),
    );
  }
}

class BankDetails extends StatelessWidget {
  const BankDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppText.bankDetails,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Container(
            height: 3,
            color: AppColors.greenLightColor,
            width: 80,
          ),
          const SizedBox(
            height: 8,
          ),
          const CustomRow(first: "UPI ID", second: "janedoes@ybl"),
          const SizedBox(
            height: 8,
          ),
          const CustomRow(first: "BANK", second: "INDIAN BANK"),
          const SizedBox(
            height: 8,
          ),
          const CustomRow(first: "A/C NO.", second: "5213 5123 6554 5894"),
          const SizedBox(
            height: 8,
          ),
          const CustomRow(first: "IFSC code", second: "IDBI000H013"),
          const SizedBox(
            height: 8,
          ),
          const CustomRow(first: "A/C Holder", second: "Jane Doe"),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}

class ContactDetails extends StatelessWidget {
  final String mobile;
  final Address? address;
  const ContactDetails(
      {super.key, required this.mobile, required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppText.contactDetails,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Container(
            height: 3,
            color: AppColors.greenLightColor,
            width: 80,
          ),
          const SizedBox(
            height: 8,
          ),
          CustomRow(first: "Mobile", second: "+91 $mobile"),
          const SizedBox(
            height: 8,
          ),
          CustomRow(first: "Whatsapp", second: "+91 $mobile"),
          const SizedBox(
            height: 8,
          ),
          const CustomRow(first: "Email", second: "janedoe@gmail.com"),
          const SizedBox(
            height: 8,
          ),
          CustomRow(
              first: "Address ",
              second: address == null
                  ? "-"
                  : address!.house +
                      " " +
                      address!.landmarks +
                      ' ' +
                      address!.street +
                      ' ' +
                      address!.city +
                      address!.pincode),
        ],
      ),
    );
  }
}
