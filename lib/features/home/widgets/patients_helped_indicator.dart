import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:clinica_flow/features/appointment/viewmodel/appointment_cubit.dart';

import 'legend_item.dart';

/// Circular progress indicator showing the completed/total
/// patient appointment ratio for the selected day.
class PatientsHelpedIndicator extends StatelessWidget {
  const PatientsHelpedIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        /*final isLoading = state.patientsHelped == null ||
            state.state == AppointmentStates.fetchingAppointmentCount ||
            state.state == AppointmentStates.fetchingAppointmentCountFailed;

        if (isLoading) {
          return AppConstants.patientsHelpedPlaceHolder();
        }

        final completed = state.patientsHelped!['completed'] as num;
        final received = state.patientsHelped!['received'] as num;
        final percentage =
            received != 0 ? ((completed / received) * 100).round() : 0;
        final normalizedPercent =
            percentage <= 100 ? percentage / 100 : 1.0;*/

        const completed = 75;
        const received = 100;
        const percentage = 75;
        const normalizedPercent = 0.75;

        return Row(
          children: [
            Expanded(
              child: CircularPercentIndicator(
                radius: 50.0,
                animation: true,
                animationDuration: 1200,
                lineWidth: 10.0,
                percent: normalizedPercent,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$percentage%',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                    const Text(
                      'done',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: const Color(0xffE4E0F3),
                progressColor: const Color(0xff03BF9C),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$completed/$received patients helped',
                    style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: const Color(0xff0C091F),
                    ),
                  ),
                  const SizedBox(height: 9),
                  const LegendItem(
                    color: Color(0xff03BF9C),
                    label: 'Completed',
                  ),
                  const SizedBox(height: 9),
                  const LegendItem(
                    color: Color(0xffE4E0F3),
                    label: 'Remaining',
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
