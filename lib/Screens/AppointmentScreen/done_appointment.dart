import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/business_logic/cubits/appointment_data_cubit/appointment_data_cubit.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:healtether_clinic_app/data_layer/models/appointmentdata.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/rounded_button.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/text_row.dart';
import 'package:hexagon/hexagon.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DoneAppoint extends StatelessWidget {
  const DoneAppoint({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<AppointmentDataCubit, AppointmentDataState>(builder: (context, state) {
      var appointment = state.appointments?.isNotEmpty == true ? state.appointments!.last : null;
      final int? slotNumber = state.appointments != null ? state.appointments!.indexOf(appointment!) + 1 : null;
      return Expanded(
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Image.asset('assets/homeimages/charm_circle-tick.png'),
                  const SizedBox(height: 12),
                  Text(
                    'The appointment has been ',
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'scheduled successfully.',
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 40),
                  if (appointment != null) ...[
                    HexagonWidget.pointy(
                      color: AppColors.blueViolet,
                      cornerRadius: 2,
                      width: screenWidth * 0.2,
                      child: HexagonWidget.pointy(
                        color: AppColors.whiteColor,
                        width: screenWidth * 0.19,
                        child: HexagonWidget.pointy(
                          width: screenWidth * 0.17,
                          color: AppColors.blueViolet,
                          elevation: 5,
                          child: Text(
                            '10',
                            style: GoogleFonts.montserrat(
                              fontSize: 30,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: screenWidth * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.white1Color,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'APPOINTMENT DETAILS',
                              style: GoogleFonts.montserrat(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: AppColors.blueLightColor,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextRow('Patient name : ', appointment.name ?? ''),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Mode : ',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      appointment.isVirtualConsultation ? 'Virtual' : 'Physical',
                                      style: const TextStyle(
                                        color: AppColors.greenColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: screenWidth * 0.075),
                                Row(
                                  children: [
                                    const Text(
                                      'Date : ',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      '${appointment.selectedDate?.day ?? ''} ${_getMonthName(appointment.selectedDate?.month ?? 0)}, ${appointment.selectedDate?.year ?? ''}',
                                      style: const TextStyle(
                                        color: AppColors.greenColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            TextRow('Slot no. : ', slotNumber.toString()),
                            const SizedBox(height: 5),
                            const SizedBox(height: 6),
                            Center(
                              child: Text(
                                'Appointment Booked on ${appointment.selectedDate?.day ?? ''} ${_getMonthName(appointment.selectedDate?.month ?? 0)}, ${appointment.selectedDate?.year ?? ''}',
                                style: const TextStyle(
                                  color: AppColors.grey1Color,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 46),
                    RoundedButton(
                      text: 'Send on',
                      icon: MdiIcons.whatsapp,
                      onTap: () {},
                    ),
                    const SizedBox(height: 12),
                    RoundedButton(
                      text: 'Back to home',
                      onTap: () {},
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }
}
