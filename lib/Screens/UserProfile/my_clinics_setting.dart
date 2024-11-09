import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/data_layer/models/user_model/user_model.dart';
import 'package:healtether_clinic_app/data_layer/services/shared_preferences_service.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';
import 'package:healtether_clinic_app/utils/mixins/app_bar_mixin.dart';

import '../../constants/constants.dart';

class MyClinicsSetting extends StatefulWidget {
  const MyClinicsSetting({super.key});

  @override
  State<MyClinicsSetting> createState() => _MyClinicsSettingState();
}

class _MyClinicsSettingState extends State<MyClinicsSetting> with AppBarMixin {
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
      appBar: buildAppBar(context, title: "Clinic Settings", automaticallyImplyLeading: true, showDefaultActions: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Container(
              height: 52,
              color: AppColors.whiteSmoke,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(children: [
                  const Icon(Icons.search),
                  const SizedBox(width: 6),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Quick Search',
                        hintStyle: GoogleFonts.montserrat(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ]),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
                child: userModel != null
                    ? ListView.builder(
                        itemCount: userModel?.linkedClinics.length ?? 0,
                        itemBuilder: (ctx, index) => InkWell(
                              onTap: () {
                                context.pushNamed(AppRoutes.clinicSettings.name, extra: userModel!.linkedClinics[index]['clinic']);
                              },
                              child: Container(
                                padding: EdgeInsets.all(15),
                                margin: EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.grey5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 20,
                                          backgroundImage: AssetImage('assets/homeimages/image 6 (3).png'),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          userModel?.linkedClinics[index]['clinic']['clinicName'] ?? '',
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.eerieBlack),
                                        ),
                                        Spacer(),
                                        (userModel?.linkedClinics[index]['clinic']['_id'] ?? -1) == activeClinicId
                                            ? Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(color: AppColors.whiteSmoke3, borderRadius: BorderRadius.circular(5)),
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
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.eerieBlack),
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
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.grey),
                                    )
                                  ],
                                ),
                              ),
                            ))
                    : const Center(child: CircularProgressIndicator())),
            Container(
              height: 52,
              margin: EdgeInsets.only(bottom: 15, left: 20, right: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF32856E),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Center(
                child: TextButton(
                  onPressed: () async {
                    context.pushNamed(AppRoutes.addClinic.name);
                  },
                  child: const Text(
                    'Add New Clinic',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
