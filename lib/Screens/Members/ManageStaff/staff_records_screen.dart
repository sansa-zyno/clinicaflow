import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/Members/EditScreens/edit_member_screen.dart';
import 'package:healtether_clinic_app/business_logic/cubits/staff_detail/staff_detail_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/staff_detail/staff_detail_state.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/staff_detail_model.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/staff_model.dart';
import 'package:intl/intl.dart';

class StaffRecordsScreen extends StatefulWidget {
  final Staff data;
  const StaffRecordsScreen({super.key, required this.data});

  @override
  State<StaffRecordsScreen> createState() => _StaffRecordsScreenState();
}

class _StaffRecordsScreenState extends State<StaffRecordsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<StaffDetailCubit>(context).fetchData(widget.data.sId!);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: Text(
          AppText.staffRecords,
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
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
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.close_rounded,
              ),
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: BlocBuilder<StaffDetailCubit, StaffDetailState>(builder: (context, state) {
        if (state is StaffDetailLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        StaffByIdModel? staffByIdModel;
        if (state is StaffDetailLoadedState) {
          staffByIdModel = state.data;
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          staffByIdModel!.profilePic.isEmpty ? 'https://picsum.photos/seed/picsum/200/300' : staffByIdModel.profilePic,
                        ),
                        radius: 45,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 33,
                              width: 110,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(247, 247, 222, 4),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  staffByIdModel.isDoctor == true ? 'Admin' : 'Guest',
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Montserrat'),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${staffByIdModel.firstName} ${staffByIdModel.lastName}',
                            style: GoogleFonts.montserrat(
                              color: AppColors.blackColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          /* const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            '??? Doubt',
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: AppColors.blackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),*/
                          Text(
                            staffByIdModel.specialization.isNotEmpty ? staffByIdModel.specialization : 'N/A',
                            style: GoogleFonts.montserrat(
                              color: AppColors.blueViolet,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditMemberScreen(
                                            isAdmin: staffByIdModel?.isDoctor ?? false,
                                            forStaff: true,
                                            staffByIdModel: staffByIdModel,
                                          )));
                            },
                            child: Container(
                              height: 30,
                              width: 100,
                              decoration: BoxDecoration(
                                color: AppColors.greenColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  AppText.editProfile,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: AppColors.whiteColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 9,
                ),
                const Divider(),
                Container(
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        buildDetailSection(
                          title: AppText.PERSONALDETAILS,
                          details: [
                            detailRowWidget(
                                subTitle: staffByIdModel.birthday != null ? DateFormat('dd/MM/yyyy').format(staffByIdModel.birthday!) : "N/A",
                                title: 'Birthday'),
                            detailRowWidget(subTitle: staffByIdModel.age.toString(), title: 'Age'),
                            detailRowWidget(subTitle: staffByIdModel.gender, title: 'Gender'),
                          ],
                        ),
                        const Divider(),
                        buildDetailSection(
                          title: AppText.CONTACTDETAILS,
                          details: [
                            detailRowWidget(subTitle: "+91 ${staffByIdModel.mobile}", title: 'Mobile'),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 108,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/homeimages/whatsapp.png',
                                        height: 28,
                                        width: 28,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 9,
                                ),
                                const Text(':'),
                                const SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                  child: Container(
                                    child: Text("+91 ${staffByIdModel.mobile}",
                                        style: const TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Color(0xFF266A57),
                                        ),
                                        softWrap: true,
                                        overflow: TextOverflow.clip),
                                  ),
                                )
                              ],
                            ),
                            detailRowWidget(subTitle: staffByIdModel.email, title: 'Email'),
                            detailRowWidget(
                                subTitle:
                                    "${staffByIdModel.address!.street} ${staffByIdModel.address!.landmarks} ${staffByIdModel.address!.house} ${staffByIdModel.address!.city} ${staffByIdModel.address!.pincode}",
                                title: 'Address'),
                          ],
                        ),
                        const Divider(),
                        buildDetailSection(
                          title: AppText.BANKDETAILS,
                          details: [
                            detailRowWidget(subTitle: staffByIdModel.upiId, title: 'UPI ID'),
                            detailRowWidget(subTitle: staffByIdModel.bankName, title: 'Bank'),
                            // detailRowWidget(subTitle: '5213 5123 6554 5894', title: 'A/c no.'),
                            detailRowWidget(subTitle: staffByIdModel.ifsc, title: 'IFSC code'),
                            detailRowWidget(subTitle: staffByIdModel.accountName, title: 'Account Holder'),
                          ],
                        ),
                        const Divider(),
                        buildDetailSection(
                          title: 'DOCUMENTS',
                          details: [
                            detailRowWidget(subTitle: staffByIdModel.documentType, title: 'ID type'),
                            detailRowWidget(subTitle: staffByIdModel.documentNumber, title: 'ID no.'),
                            detailWidget(subTitle: '', title: 'Other Documents'),
                            Column(
                              children: staffByIdModel.documents
                                  .map(
                                    (e) => detailsRowWidget(subTitle: e['blobName'], title: e['fileName']),
                                  )
                                  .toList(),
                            )
                          ],
                        ),
                        const Divider(),
                        buildDetailSection(
                          title: 'PAYMENTS HISTORY',
                          details: [
                            detailRowWidget(subTitle: '', title: 'Receipts'),
                            detailsRowWidget(subTitle: '', title: '1. Salary_aug23'),
                            detailsRowWidget(subTitle: '', title: '2. Salary_july23'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget buildDetailSection({required String title, required List<Widget> details}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        greenLine(),
        const SizedBox(
          height: 10,
        ),
        ...details,
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Container greenLine() {
    return Container(
      height: 2,
      width: 40,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: const Color(0xFF52CFAC)),
    );
  }

  Row detailRowWidget({required String title, required String subTitle}) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
      const Text(':'),
      const SizedBox(
        width: 30,
      ),
      Expanded(
        child: Container(
          child: Text(subTitle,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
                fontSize: 16,
                color: Color(0xFF266A57),
              ),
              softWrap: true,
              overflow: TextOverflow.clip),
        ),
      )
    ]);
  }

  Row detailWidget({required String title, required String subTitle}) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
      Expanded(
        child: Container(
          child: Text(subTitle,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
                fontSize: 16,
                color: Color(0xFF266A57),
              ),
              softWrap: true,
              overflow: TextOverflow.clip),
        ),
      )
    ]);
  }

  Row detailsRowWidget({required String title, required String subTitle}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(0xFF266A57),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  subTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: "Poppins",
                    fontSize: 16,
                    color: Color(0xFF266A57),
                  ),
                  softWrap: true,
                  overflow: TextOverflow.clip,
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.find_in_page_rounded, color: Colors.black),
            ],
          ),
        ),
      ],
    );
  }
}
