import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_models/appointment_model.dart';

class AppointmentDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Appointment appointment;
  final VoidCallback onDelete;

  const AppointmentDetailsAppBar({
    Key? key,
    required this.appointment,
    required this.onDelete,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Appointment Details',
        style:
            GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 19),
      ),
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'option6') {
              onDelete();
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem<String>(
                value: 'option1',
                child: Text('Schedule Follow-Up'),
              ),
              const PopupMenuItem<String>(
                value: 'option2',
                child: Text('Reschedule'),
              ),
              const PopupMenuItem<String>(
                value: 'option3',
                child: Text('Cancel Appointment'),
              ),
              PopupMenuItem<String>(
                value: 'option4',
                child: InkWell(
                  onTap: () {
                    // showDialog(
                    //   context: context,
                    //   builder: (BuildContext context) {
                    //     return ViewPatientDetailsPopup(
                    //         appointment: appointment);
                    //   },
                    // );
                  },
                  child: const Text('View Patient details'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'option5',
                child: Text('Notify Patients'),
              ),
              PopupMenuItem<String>(
                value: 'option6',
                child: InkWell(
                  onTap: onDelete,
                  child: const Text('Delete Appointment'),
                ),
              ),
            ];
          },
        ),
      ],
    );
  }
}
