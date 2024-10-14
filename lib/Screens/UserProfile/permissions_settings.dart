import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/cancel_appoinments.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/reschedule_appoinment.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/schedule_follow_up.dart';
import 'package:healtether_clinic_app/data_layer/models/patient_records_model/patient_model.dart';
import 'package:healtether_clinic_app/Screens/patients_records/patient_record_screen.dart';
import 'package:healtether_clinic_app/constants/constants.dart';

class PermissionsSettings extends StatefulWidget {
  const PermissionsSettings({super.key});

  @override
  State<PermissionsSettings> createState() => _PermissionsSettingsState();
}

class _PermissionsSettingsState extends State<PermissionsSettings> {
  bool light1 = false;
  bool light2 = false;
  bool light3 = false;
  late PatientOverviewModel patient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            Text(
              'Settings',
              style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
            ),
          ],
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
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'option_1') {
                // Handle option 1
              } else if (value == 'option_2') {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const ScheduleFollowUp(),
                );
              } else if (value == 'option_3') {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const RescheduleAppointment(),
                );
              } else if (value == 'option_4') {
                showDialog(
                    context: context,
                    builder: (BuildContext) {
                      return const CancelAppointment();
                    });
              } else if (value == 'option_5') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PatientRecordsScreen(
                            // data: Data(),
                            patient: patient,
                          )),
                );
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'option_1',
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff5DDCB8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: const Row(
                    children: [
                      Text(
                        'Menu',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      Spacer(),
                      Icon(
                        Icons.cancel,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'option_2',
                child: ListTile(
                  title: Text(
                    'Schedule Follow-up',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'option_3',
                child: ListTile(
                  title: Text(
                    'Reschedule Appointment',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'option_4',
                child: ListTile(
                  title: Text(
                    'Cancel Appointment',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'option_5',
                child: ListTile(
                  title: Text(
                    'View Patient Details',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    'APP PERMISSIONS',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      right: 94.0,
                    ),
                    child: SizedBox(
                      height: 5,
                      width: 54,
                      child: Divider(
                        thickness: 2,
                        color: Color(0xff52CFAC),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 260,
                        child: Text(
                          'Contacts and Message Syncing',
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Switch(
                        value: light1,
                        onChanged: (bool value) {
                          setState(() {
                            light1 = value;
                          });
                        },
                        trackColor: MaterialStatePropertyAll<Color>(
                            Colors.grey.shade300),
                        thumbColor: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.selected)) {
                            return const Color(
                                0xff5351C7); // Color when the switch is active
                          }
                          return Colors
                              .grey; // Color when the switch is inactive
                        }),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 290,
                    child: Text(
                      'Allow access to your contacts and messaging app for a convenient and integrated experience.',
                      style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 260,
                        child: Text(
                          'Allow Camera Access',
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Switch(
                        value: light2,
                        onChanged: (bool value) {
                          setState(() {
                            light2 = value;
                          });
                        },
                        trackColor: MaterialStatePropertyAll<Color>(
                            Colors.grey.shade300),
                        thumbColor: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.selected)) {
                            return const Color(0xff5351C7);
                          }
                          return Colors.grey;
                        }),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 290,
                    child: Text(
                      "This is enable the app to use your device's camera for capturing photos of documents to upload medical records or documents securely within the app.",
                      style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 260,
                        child: Text(
                          'Third-Party Permissions',
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Switch(
                        value: light3,
                        onChanged: (bool value) {
                          setState(() {
                            light3 = value;
                          });
                        },
                        trackColor: MaterialStatePropertyAll<Color>(
                            Colors.grey.shade300),
                        thumbColor: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.selected)) {
                            return const Color(0xff5351C7);
                          }
                          return Colors.grey;
                        }),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 290,
                    child: Text(
                      'Some features may require access to third-party services for enhanced functionality.',
                      style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
