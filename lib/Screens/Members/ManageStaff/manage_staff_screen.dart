import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/business_logic/cubits/staff_cubit/staff_cubit.dart';
import 'package:healtether_clinic_app/Screens/Members/ManageStaff/staff_records_screen.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/staff_model.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/widget_extensions.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';
import 'package:healtether_clinic_app/utils/mixins/app_bar_mixin.dart';
import '../../AppointmentScreen/appointment_screen.dart';
import '../add_member_screen.dart';

class ManageStaffScreen extends StatefulWidget {
  const ManageStaffScreen({super.key});

  @override
  State<ManageStaffScreen> createState() => _ManageStaffScreenState();
}

class _ManageStaffScreenState extends State<ManageStaffScreen> with AppBarMixin {
  String selectedDate = 'All';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<StaffCubit>().fetchStaffs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: "Manage Staff",
        showDefaultActions: false,
      ),
      body: BlocBuilder<StaffCubit, StaffState>(
        builder: (context, state) {
          return Stack(
            children: [
              Column(
                children: [
                  Container(
                    color: const Color(0xffF5F5F5),
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
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
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 38,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        DateCards(
                          width: 35,
                          isSelected: selectedDate == 'All',
                          onTap: () {
                            setState(() {
                              selectedDate = 'All';
                            });
                          },
                          text: 'All',
                        ),
                        DateCards(
                          width: 110,
                          isSelected: selectedDate == 'Super Admin',
                          onTap: () {
                            setState(() {
                              selectedDate = 'Super Admin';
                            });
                          },
                          text: 'Super Admin',
                        ),
                        DateCards(
                          width: 66,
                          isSelected: selectedDate == 'Admins',
                          onTap: () {
                            setState(() {
                              selectedDate = 'Admins';
                            });
                          },
                          text: 'Admins',
                        ),
                        DateCards(
                          width: 62,
                          isSelected: selectedDate == 'Guests',
                          onTap: () {
                            setState(() {
                              selectedDate = 'Guests';
                            });
                          },
                          text: 'Guests',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: InfoCard(
                      selectedDate: selectedDate,
                    ),
                  ),
                  const SizedBox(height: 90),
                ],
              ),
              BlocBuilder<StaffCubit, StaffState>(builder: (context, state) {
                return state.state == StaffStates.creatingStaff ||
                        state.state == StaffStates.fetchingStaff ||
                        state.state == StaffStates.deletingStaff
                    ? const Center(child: CircularProgressIndicator())
                    : const SizedBox();
              }),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return const SelectStaffType();
                        },
                      );
                    },
                    child: Container(
                      height: 60,
                      width: 280,
                      decoration: BoxDecoration(
                        color: AppColors.greenColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          "Add member",
                          style: GoogleFonts.urbanist(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.whiteColor,
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

class InfoCard extends StatefulWidget {
  final String selectedDate;

  const InfoCard({Key? key, required this.selectedDate}) : super(key: key);

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StaffCubit, StaffState>(
      builder: (context, state) {
        // List<staff_model.StaffModel> filteredStaff = [];
        List<Staff> filteredStaff = [];

        if (widget.selectedDate == 'All') {
          filteredStaff = state.staffList ?? [];
        } else {
          filteredStaff = state.staffList?.where((staff) {
                if (widget.selectedDate == 'Super Admin') {
                  return staff.isDoctor == true;
                } else if (widget.selectedDate == 'Admins') {
                  return staff.isDoctor == true;
                } else if (widget.selectedDate == 'Guests') {
                  return staff.isDoctor == false;
                }
                return true;
              }).toList() ??
              [];
        }

        if (widget.selectedDate == 'Guests' && filteredStaff.isEmpty) {
          return const Center(
            child: Text('No data found.'),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          itemCount: filteredStaff.length,
          itemBuilder: (BuildContext context, int index) {
            // staff_model.StaffModel staff = filteredStaff[index];
            Staff staff = filteredStaff[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => StaffRecordsScreen(data: staff)));
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                margin: EdgeInsets.only(bottom: 6.0),
                decoration: BoxDecoration(
                  color: const Color(0xffF5F5F5),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${staff.firstName} ${staff.lastName}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: Text(
                                staff.mobile ?? '91 7896 32154',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                            child: Text(
                              staff.isDoctor == true ? 'Admin' : 'Guest',
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          staff.isDoctor == true ? 'Doctor' : 'Other',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(Icons.mail_outline, size: 20).pOnly(right: 10),
                            Image.asset(
                              "assets/homeimages/whatsapp.png",
                              color: const Color(0xFF110C2C),
                              height: 26,
                              width: 26,
                            ).pOnly(right: 10),
                            InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Column(
                                          children: [
                                            Text(
                                              'Do you want to delete the staff from the directory?',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              'The staff details will bw deleted permanently.',
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
                                              context.pop();
                                            },
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(const Color(0xff32856E)),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(4.0),
                                                ),
                                              ),
                                              minimumSize: MaterialStateProperty.all(const Size(110, 50)),
                                            ),
                                            child: const Text(
                                              'No',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              log("About to delete staff: $staff");
                                              deleteStaff(staff);
                                            },
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(
                                                const Color(0xFF0F8F7FC),
                                              ),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(4.0),
                                                ),
                                              ),
                                              minimumSize: MaterialStateProperty.all(const Size(110, 50)),
                                            ),
                                            child: const Text(
                                              'Yes',
                                              style: TextStyle(color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Icon(Icons.delete, size: 20)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void deleteStaff(Staff staff) {
    log("DELETING STAFF: $staff");
    context.read<StaffCubit>().deleteStaff(staff.staffId!);
    // if (mounted) {
    context.pop();
    // }
  }
}

class SelectStaffType extends StatefulWidget {
  const SelectStaffType({super.key});

  @override
  State<SelectStaffType> createState() => _SelectStaffTypeState();
}

class _SelectStaffTypeState extends State<SelectStaffType> {
  bool isAdmin = false;
  bool isGuest = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SELECT STATUS',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Container(
                  height: 2,
                  width: 55,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: const Color(0xFF52CFAC)),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              // context.pushNamed(AppRoutes.addMemberScreen.name);
              isAdmin = true;
              isGuest = false;
              setState(() {});
              context.pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddMemberScreen(
                            isAdmin: true,
                            forStaff: true,
                          )));
            },
            child: Container(
              width: double.infinity,
              height: 58,
              decoration: BoxDecoration(
                color: isAdmin ? AppColors.greenColor : AppColors.white1Color,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        children: [
                          Text(
                            'Admin',
                            style: GoogleFonts.montserrat(color: isAdmin ? Colors.white : Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 9,
          ),
          GestureDetector(
            onTap: () {
              // context.pushNamed(AppRoutes.addMemberScreen.name);
              isGuest = true;
              isAdmin = false;
              setState(() {});
              context.pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddMemberScreen(
                            isAdmin: false,
                            forStaff: true,
                          )));
            },
            child: Container(
              width: double.infinity,
              height: 58,
              decoration: BoxDecoration(
                color: isGuest ? AppColors.greenColor : AppColors.white1Color,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        children: [
                          Text(
                            'Guest',
                            style: GoogleFonts.montserrat(color: isGuest ? Colors.white : Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
