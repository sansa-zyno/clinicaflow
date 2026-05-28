import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clinica_flow/features/chat/view/chat_detailes_screen.dart';
import 'package:clinica_flow/features/patient/viewmodel/patient_records_cubit.dart';
import 'package:clinica_flow/shared/ui/member/add/personal_detail_screen.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text.dart';
import 'package:clinica_flow/core/utils/enums/bloc_enums.dart';
import 'package:clinica_flow/core/utils/enums/route_enums.dart';
import '../model/patient_model.dart';

class PatientRecords extends StatefulWidget {
  const PatientRecords({Key? key}) : super(key: key);

  @override
  State<PatientRecords> createState() => _PatientRecordsState();
}

class _PatientRecordsState extends State<PatientRecords> {
  final TextEditingController _searchController = TextEditingController();
  List<PatientModel>? searchResult;

  @override
  void initState() {
    super.initState();
    context.read<PatientRecordsCubit>().fetchPatients();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocBuilder<PatientRecordsCubit, PatientRecordsState>(
        builder: (context, state) {
          return Stack(
            children: [
              if (state.state == PatientRecordsStates.fetchingPatients)
                const Center(child: CircularProgressIndicator())
              else
                _buildBodyContent(state),
              _buildAddPatientButton(),
            ],
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leadingWidth: 30,
      automaticallyImplyLeading: false,
      title: const Text(
        AppText.patientRecords,
        style: TextStyle(fontSize: 20),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: IconButton(
          onPressed: () => Navigator.pop(context),
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
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.close_rounded),
          ),
        ),
        const SizedBox(width: 5),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert, size: 25),
        ),
      ],
    );
  }

  Widget _buildBodyContent(PatientRecordsState state) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            _buildSearchBar(state),
            const SizedBox(height: 15),
            _buildPatientCount(state),
            const SizedBox(height: 8),
            _buildPatientList(state),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(PatientRecordsState state) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        fillColor: const Color(0xFFF5F5F5),
        filled: true,
        hintText: 'Search',
        hintStyle: GoogleFonts.montserrat(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        suffixIcon: const Icon(Icons.search, color: Colors.grey),
      ),
      onChanged: (query) => _onSearchChanged(query, state),
    );
  }

  void _onSearchChanged(String query, PatientRecordsState state) {
    if (query.isEmpty) {
      setState(() => searchResult = null);
    } else {
      final filtered = state.patients?.where((e) {
            final firstNameMatch = e.firstName
                    ?.toLowerCase()
                    .trim()
                    .startsWith(query.toLowerCase()) ??
                false;
            final lastNameMatch = e.lastName
                    ?.toLowerCase()
                    .trim()
                    .startsWith(query.toLowerCase()) ??
                false;
            return firstNameMatch || lastNameMatch;
          }).toList() ??
          [];
      setState(() => searchResult = filtered);
    }
  }

  Widget _buildPatientCount(PatientRecordsState state) {
    if (searchResult != null && searchResult!.isEmpty)
      return const SizedBox.shrink();

    final count =
        searchResult != null ? searchResult!.length : state.totalCount;
    return Text(
      'All $count patients are listed',
      style: GoogleFonts.roboto(
        textStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w400,
          height: 15.6 / 13,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildPatientList(PatientRecordsState state) {
    final list = searchResult ?? state.patients ?? [];

    if (list.isEmpty) {
      return const Align(
        heightFactor: 25,
        alignment: Alignment.center,
        child: Text('No data found'),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (context, index) => _buildPatientItem(list[index]),
    );
  }

  Widget _buildPatientItem(PatientModel patient) {
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${patient.firstName ?? ''} ${patient.lastName ?? ''}'
                        .trim(),
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    patient.mobile ?? 'No phone number',
                    style: const TextStyle(
                      color: AppColors.grey,
                      fontSize: 12,
                      height: 14.06 / 12,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${patient.age ?? 'N/A'}yrs, ${patient.gender ?? 'N/A'}',
                    style: const TextStyle(
                      color: AppColors.grey,
                      fontSize: 12,
                      height: 14.06 / 12,
                    ),
                  ),
                ],
              ),
            ),
            const VerticalDivider(
              color: Color(0xFFDFDFDF),
              thickness: 1,
            ),
            _buildChatAction(),
          ],
        ),
      ),
    );
  }

  Widget _buildChatAction() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChatDetailScreen()),
        );
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Image.asset(
              "assets/homeimages/whatsapp.png",
              color: const Color(0xFF110C2C),
              height: 26,
              width: 26,
            ),
          ),
          const Icon(Icons.call, size: 20),
        ],
      ),
    );
  }

  Widget _buildAddPatientButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PersonalDetailScreen(
                isAdmin: false,
                forStaff: false,
              ),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.greenColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "Add new patient",
                style: GoogleFonts.urbanist(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
