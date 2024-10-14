import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/business_logic/cubits/appointment_data_cubit/appointment_data_cubit.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:url_launcher/url_launcher.dart';

class AppointmentActionButtons extends StatelessWidget {
  const AppointmentActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Row(
          children: [
            Icon(Icons.call, size: 20),
            SizedBox(width: 5),
            Text('Call',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ],
        ),
        Row(
          children: [
            Icon(MdiIcons.fileDocument, size: 23),
            const SizedBox(width: 5),
            const Text('View bills',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ],
        ),
        GestureDetector(
          onTap: () => _sendWhatsAppMessage(context),
          child: Container(
            height: 42,
            width: 80,
            decoration: BoxDecoration(
              color: const Color(0xff32856E),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(MdiIcons.whatsapp, size: 20, color: Colors.white),
                const SizedBox(width: 5),
                const Text(
                  'Chat',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _sendWhatsAppMessage(BuildContext context) async {
    // final appointmentData =
    //     Provider.of<AppointmentData>(context, listen: false);
    final appointments = context.read<AppointmentDataCubit>().state.appointments ?? [];

    String message = 'Appointment Details:\n';
    for (final appointment in appointments) {
      message += 'Name: ${appointment.name}\n';
      message += 'Date: ${appointment.selectedDate}\n';
      message += 'Doctor: ${appointment.doctor}\n';
      message += 'Mobile No.: ${appointment.mobileNo}\n';
      message += '\n';
    }

    final encodedMessage = Uri.encodeComponent(message);

    final uri = Uri.parse('whatsapp://send?text=$encodedMessage');

    await launch(uri.toString());
  }

  Future<void> _launchURI(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
