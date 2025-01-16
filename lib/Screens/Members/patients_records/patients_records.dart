import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/ChatScreen/chat_detailes_screen.dart';
import 'package:healtether_clinic_app/business_logic/cubits/patient_records_cubit/patient_records_cubit.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/data_layer/models/patient_records_model/patient_model.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/string_extensions.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';
import '../add_member_screen.dart';

class PatientRecords extends StatefulWidget {
  const PatientRecords({Key? key}) : super(key: key);

  @override
  State<PatientRecords> createState() => _PatientRecordsState();
}

class _PatientRecordsState extends State<PatientRecords> {
  final TextEditingController _searchController = TextEditingController();

  List<PatientOverviewModel>? searchResult; //starting or when search keyword is empty

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
        leading: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
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
                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Container(
                          color: const Color(0xffF5F5F5),
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                    hintText: 'Quick Search',
                                    hintStyle: GoogleFonts.roboto(
                                      color: const Color(0xff413D56),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    //suffixIcon: ScheduleSearchBox(),
                                    prefixIcon: const Icon(Icons.search, color: Color(0xff413D56)),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (query) {
                                    if (query.isEmpty) {
                                      searchResult = null;
                                    } else {
                                      searchResult = state.patients?.where((e) {
                                            return (e.firstName?.toLowerCase().trim().startsWith(query.toLowerCase()) ?? false) ||
                                                (e.lastName?.toLowerCase().trim().startsWith(query.toLowerCase()) ?? false);
                                          }).toList() ??
                                          [];
                                    }
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        if (searchResult?.isNotEmpty ?? true)
                          Text(
                            'All ${searchResult != null ? searchResult!.length : state.totalCount} patients are listed',
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              height: 15.6 / 13,
                              fontSize: 13,
                            )),
                          ),
                        const SizedBox(height: 8),
                        searchResult?.isNotEmpty ?? true
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: searchResult != null ? searchResult!.length : state.patients?.length ?? 0,
                                itemBuilder: (context, index) {
                                  var patient = searchResult != null ? searchResult![index] : state.patients![index];
                                  return InkWell(
                                    onTap: () {
                                      context.pushNamed(AppRoutes.patientRecordsScreen.name, extra: patient);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 6.0),
                                      padding: const EdgeInsets.all(12.0),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF5F5F5),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                patient.firstName?.capitalize ?? '',
                                                style: const TextStyle(
                                                    color: AppColors.eerieBlack, fontSize: 16, fontWeight: FontWeight.w600, height: 22.08 / 16),
                                              ),
                                              const SizedBox(height: 3),
                                              Text(
                                                '${patient.age ?? 'N/A'}yrs, ${patient.gender ?? 'N/A'}',
                                                style: const TextStyle(color: AppColors.grey, fontSize: 12, height: 14.06 / 12),
                                              ),
                                              const SizedBox(height: 3),
                                              Text(
                                                "+91 ${patient.mobile ?? 'No phone number'}",
                                                style: const TextStyle(color: AppColors.grey, fontSize: 12, height: 14.06 / 12),
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
                                                  builder: (context) => const ChatDetailScreen(),
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
                                  );
                                },
                              )
                            : const Align(heightFactor: 25, alignment: Alignment.center, child: Text('No data found')),
                      ],
                    ),
                  ),
                ),
              ],
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFF32856E),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddMemberScreen(
                                        isAdmin: false,
                                        forStaff: false,
                                      )));
                        },
                        child: const Text(
                          "Add new patient",
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            // Equivalent to AppColors.whiteColor
                            fontSize: 14,
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
