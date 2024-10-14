import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/ChatScreen/chat_detailes_screen.dart';
// import 'package:healtether_clinic_app/Screens/patients_records/bloc/patient_records_bloc.dart';
import 'package:healtether_clinic_app/Screens/patients_records/patient_record_screen.dart';
import 'package:healtether_clinic_app/business_logic/cubits/patient_records_cubit/patient_records_cubit.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/constants/app_icons.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/string_extensions.dart';

import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';

class PatientRecords extends StatefulWidget {
  const PatientRecords({Key? key}) : super(key: key);

  @override
  State<PatientRecords> createState() => _PatientRecordsState();
}

class _PatientRecordsState extends State<PatientRecords> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // late PatientRecordsProvider patientRecordsProvider;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<PatientRecordsCubit>().fetchPatients();
    // });
  }

  // PatientRecordsBloc bloc = PatientRecordsBloc();

  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context);
    // final screenWidth = mediaQuery.size.width;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        automaticallyImplyLeading: false,
        title: const Text(
          AppText.patientRecords,
          style: TextStyle(fontSize: 20),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.blackColor),
              borderRadius: BorderRadius.circular(6),
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.close_rounded,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              size: 25,
            ),
          ),
        ],
      ),
      body: BlocBuilder<PatientRecordsCubit, PatientRecordsState>(
        builder: (context, state) {
          return Stack(
            children: [
              if (state.state == PatientRecordsStates.fetchingPatients) ...[
                const Center(child: CircularProgressIndicator()),
              ] else ...[
                SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Container(
                          height: 50,
                          color: const Color(0xFFFFFFFF),
                          child: CupertinoSearchTextField(
                            controller: _searchController,
                            placeholder: "Quick Search",
                            // suffix: AppIcons.search,
                            placeholderStyle: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppColors.darkBlueViolet,
                              fontSize: 16,
                            )),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'All ${state.totalCount} appointments are listed',
                          style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            height: 15.6 / 13,
                            fontSize: 13,
                          )),
                        ),
                        const SizedBox(height: 8),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.patients?.length ?? 0,
                          itemBuilder: (context, index) {
                            var patient = state.patients![index];
                            return InkWell(
                              onTap: () {
                                context.pushNamed(
                                    AppRoutes.patientRecordsScreen.name,
                                    extra: patient);
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           PatientRecordsScreen(
                                //             patient: patient,
                                //           )),
                                // );
                              },
                              child: Container(
                                // width: 150,
                                // height: 90,
                                color: const Color(0xFFF5F5F5),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            patient.firstName?.capitalize ?? '',
                                            style: const TextStyle(
                                                color: AppColors.eerieBlack,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                height: 22.08 / 16),
                                          ),
                                          const SizedBox(height: 2),
                                          const Text(
                                            '35yrs, Female',
                                            style: TextStyle(
                                                color: AppColors.grey,
                                                fontSize: 12,
                                                height: 14.06 / 12),
                                          ),
                                          const SizedBox(height: 2),
                                          Row(children: [
                                            AppIcons.flower,
                                            const SizedBox(width: 2),
                                            const Text(
                                              "Add ABHA",
                                              style: TextStyle(
                                                  color: AppColors.blueViolet),
                                            )
                                          ]),
                                          const SizedBox(height: 2),
                                          Text(
                                            "+91 ${patient.mobile ?? 'No phone number'}",
                                            style: const TextStyle(
                                                color: AppColors.grey,
                                                fontSize: 12,
                                                height: 14.06 / 12),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      const VerticalDivider(
                                        color: Color(0xFFDFDFDF),
                                        thickness: 1,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ChatDetailScreen(),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 34,
                                              width: 34,
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    'assets/homeimages/whatsapp2.png',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            const Icon(Icons.call, size: 22),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 60,
                    margin: const EdgeInsets.only(left: 24, right: 24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF32856E),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          context.pushNamed(AppRoutes.addMembersScreen.name);
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return const AddMembersScreen();
                          // }));
                        },
                        child: const Text(
                          "Add new patient",
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            // Equivalent to AppColors.whiteColor
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
