import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/data_layer/models/helper_models/schedule_helper.dart';
import 'package:healtether_clinic_app/data_layer/models/user_model/user_model.dart';
import 'package:healtether_clinic_app/data_layer/services/shared_preferences_service.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/widget_extensions.dart';
import 'package:healtether_clinic_app/utils/mixins/app_bar_mixin.dart';
import 'package:healtether_clinic_app/widgets/text_list_tile.dart';

import '../../constants/constants.dart';

class ClinicSettings extends StatefulWidget {
  final Map selectedClinic;
  const ClinicSettings({super.key, required this.selectedClinic});

  @override
  State<ClinicSettings> createState() => _ClinicSettingsState();
}

class _ClinicSettingsState extends State<ClinicSettings> with AppBarMixin {
  // late PatientModel patient;
  final cancelAppointmentSchedule = ScheduleHelper();
  UserModel? userModel;
  String activeClinicId = '';
  void getCurrentUser() async {
    var data = await UserModel.getCurrentUser();
    userModel = data;
    activeClinicId = await SharedPrefService.getClinicId() ?? "";
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context,
          title: "Clinic Settings",
          automaticallyImplyLeading: true,
          showDefaultActions: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.grey5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        backgroundImage:
                            AssetImage('assets/homeimages/image 6 (3).png'),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        widget.selectedClinic['clinicName'] ?? '',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.eerieBlack),
                      ),
                      Spacer(),
                      widget.selectedClinic['_id'] == activeClinicId
                          ? Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: AppColors.whiteSmoke3,
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Text(
                                'Current',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.lightTeal),
                              ),
                            )
                          : Container()
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${userModel?.firstName ?? ''} ${userModel?.lastName ?? ''}',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.eerieBlack),
                  ),
                  /* SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  '+91 9865632142',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.grey6),
                                ),*/

                  Text(
                    userModel?.email ?? '',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey6),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                child: Divider(
                  thickness: 2,
                  color: Color(0xffEEEEEE),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),

            //? CLINIC DETAILS
            TextListTile(
                text: 'Clinic details',
                onTap: () {
                  context.pushNamed(AppRoutes.clinicDetails.name,
                      extra: widget.selectedClinic);
                }).pOnly(bottom: 5),

            /*//? CLINIC SETTINGS
            TextListTile(
                text: 'Clinic settings',
                onTap: () {
                  context.pushNamed(AppRoutes.clinicSettings.name);
                }).pOnly(bottom: 5),*/

            /*   //? CLINIC SETTINGS
            TextListTile(
                text: 'Appointment settings',
                onTap: () {
                  context.pushNamed(AppRoutes.appointmentSettings.name);
                }).pOnly(bottom: 5),*/

            //? PAYMENT SETTINGS
            TextListTile(
                text: 'Payments settings',
                onTap: () {
                  context.pushNamed(AppRoutes.paymentSettings.name);
                }).pOnly(bottom: 5),

            //? PAYMENT SETTINGS
            TextListTile(
                text: 'Prescription settings',
                onTap: () {
                  context.pushNamed(AppRoutes.prescriptionSettings.name);
                }).pOnly(bottom: 5),

            TextListTile(text: 'Archive Clinic', onTap: () {})
                .pOnly(bottom: 12),
            //? NOTIFICAITON SETTINGS
            // TextListTile(
            //     text: 'Notifications settings',
            //     onTap: () {
            //       context.pushNamed(AppRoutes.notificationsSettings.name);
            //     }).pOnly(bottom: 5),

            // //? APP PERMISSIONS
            // TextListTile(
            //     text: 'App Permissions',
            //     onTap: () {
            //       context.pushNamed(AppRoutes.appPermissionsSettings.name);
            //     }).pOnly(bottom: 12),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.copyright_rounded,
                      color: Colors.grey,
                      size: 16,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Copyright 2024 HealTether. All Rights Reserved.',
                      style: GoogleFonts.montserrat(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
