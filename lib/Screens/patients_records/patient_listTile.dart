import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/Screens/patients_records/patient_record_full_page.dart';
import 'package:healtether_clinic_app/constants/constants.dart';

class PatientListTile extends StatelessWidget {
  final String firstname;
  final String lastname;
  final String number;
  final String id;

  const PatientListTile(
      {super.key,
      required this.firstname,
      required this.number,
      required this.lastname,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 68,
        decoration: const BoxDecoration(
            color: AppColors.white1Color,
            borderRadius: BorderRadius.all(Radius.circular(7))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PatientDetails(
                          id: id,
                        ),
                      )),
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.scaleDown,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("$firstname $lastname"),
                          Text("+91 $number")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // SvgPicture.asset("assets/homeimages/records/whatsapp.svg",width: 40,),
                    Container(
                      width: 1,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 5,
                    ),

                    Image.asset(
                      'assets/homeimages/whatsapp2.png',
                      height: 40,
                      fit: BoxFit.scaleDown,
                    ),
                    Image.asset(
                      "assets/homeimages/phone2.png",
                      height: 40,
                      fit: BoxFit.scaleDown,
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
