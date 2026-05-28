import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clinica_flow/features/appointment/viewmodel/appointment_cubit.dart';
import 'package:clinica_flow/features/appointment/model/appointment_model.dart';
import 'package:clinica_flow/features/appointment/service/appointment_service.dart';
import 'package:clinica_flow/features/past_medical_history/service/past_medical_history_service.dart';
import 'package:clinica_flow/features/vitals/service/vitals_service.dart';
import 'package:clinica_flow/core/utils/enums/bloc_enums.dart';
import 'package:clinica_flow/core/utils/enums/route_enums.dart';
import 'package:clinica_flow/core/utils/extensions.dart/string_extensions.dart';
import 'package:clinica_flow/core/utils/snackbar.dart';
import 'package:clinica_flow/core/constants/app_colors.dart';
import 'package:clinica_flow/core/utils/responsive_layout.dart';

/// A card displaying a single upcoming appointment with
/// quick-action buttons for medical history, vitals, prescriptions, and receipts.
class AppointmentCard extends StatefulWidget {
  final Appointment appointment;

  const AppointmentCard({super.key, required this.appointment});

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  bool _isMakingReceipt = false;

  // ── Build ────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth =
        ResponsiveLayout.isDesktop(context) ? 400.0 : screenWidth - 32;

    return Container(
      width: cardWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGrey7.withOpacity(0.25),
            offset: const Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(cardWidth),
          const SizedBox(height: 8),
          _buildActionButtons(cardWidth),
        ],
      ),
    );
  }

  // ── Header (name, age, gender, time) ─────────────────────────────

  Widget _buildHeader(double width) {
    final appt = widget.appointment;

    return Container(
      padding: const EdgeInsets.all(8),
      width: width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
        color: Color(0xff8BDFC7),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appt.name!.capitalize,
                style: GoogleFonts.urbanist(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ),
              Text(
                '${appt.age} years, ${appt.gender}',
                style: GoogleFonts.urbanist(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            '${appt.timeSlot}',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  // ── Quick-action buttons ─────────────────────────────────────────

  Widget _buildActionButtons(double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPastMedicalHistoryButton(),
          _buildVitalsButton(),
          _buildPrescriptionButton(),
          _buildMakeReceiptButton(),
        ],
      ),
    );
  }

  Widget _buildPastMedicalHistoryButton() {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      buildWhen: (_, current) =>
          current.state == AppointmentStates.fetchingAppointmentById,
      builder: (context, _) {
        return FutureBuilder(
          future: PastMedicalHistoryService()
              .getPastMedicalHistory(patientId: widget.appointment.patientId!),
          builder: (context, snapshot) {
            return InkWell(
              onTap: (snapshot.data != null &&
                      snapshot.data!.values.every((e) => e != null))
                  ? () => context.pushNamed(
                        AppRoutes.pastMedicalHistory.name,
                        extra: {
                          'appointment': widget.appointment,
                          'pastHistory': snapshot.data!['pastHistory'],
                          'familyHistory': snapshot.data!['familyHistory'],
                          'pastProcedureHistory':
                              snapshot.data!['pastProcedureHistory'],
                          'allergies': snapshot.data!['allergies'],
                          'medication': snapshot.data!['medication'],
                        },
                      )
                  : null,
              child: Opacity(
                opacity: (snapshot.data == null ||
                        snapshot.data!.values.every((e) => e == null))
                    ? 0.5
                    : 1,
                child: _ActionIcon(
                  assetPath: 'assets/homeimages/Component 15.svg',
                  label: 'Past Medical\n History',
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildVitalsButton() {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      buildWhen: (_, current) =>
          current.state == AppointmentStates.fetchingAppointmentById,
      builder: (context, _) {
        return FutureBuilder(
          future: VitalsService().getVitals(
            appointmentId: widget.appointment.id!,
            patientId: widget.appointment.patientId!,
          ),
          builder: (context, snapshot) {
            return InkWell(
              onTap: (snapshot.data != null && snapshot.data!.id != null)
                  ? () => context.pushNamed(
                        AppRoutes.vitals.name,
                        extra: {
                          'appointment': widget.appointment,
                          'vitals': snapshot.data,
                        },
                      )
                  : null,
              child: Opacity(
                opacity: (snapshot.data == null || snapshot.data!.id == null)
                    ? 0.5
                    : 1,
                child: _ActionIcon(
                  assetPath: 'assets/homeimages/Vector (15).svg',
                  label: 'Vitals & \nExamination',
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPrescriptionButton() {
    return InkWell(
      onTap: () => context.pushNamed(
        AppRoutes.writePrescription.name,
        extra: widget.appointment,
      ),
      child: _ActionIcon(
        assetPath: 'assets/homeimages/Vector (16).svg',
        label: 'Write\nprescription',
      ),
    );
  }

  Widget _buildMakeReceiptButton() {
    return InkWell(
      onTap: _isMakingReceipt ? null : _handleMakeReceipt,
      child: Opacity(
        opacity: _isMakingReceipt ? 0.5 : 1,
        child: _ActionIcon(
          assetPath: 'assets/homeimages/Vector (17).svg',
          label: 'Make\nreceipt',
        ),
      ),
    );
  }

  Future<void> _handleMakeReceipt() async {
    try {
      setState(() => _isMakingReceipt = true);

      final service = AppointmentServices();
      final invoiceId = await service.makeReceipt(
        appointmentId: widget.appointment.id!,
      );

      if (!mounted) return;

      await context
          .read<AppointmentCubit>()
          .getInvoiceById(invoiceId: invoiceId);

      if (!mounted) return;

      setState(() => _isMakingReceipt = false);

      final cubitState = context.read<AppointmentCubit>().state;
      if (cubitState.state == AppointmentStates.invoiceFetched) {
        context.pushNamed(
          AppRoutes.paymentReceiptScreen.name,
          extra: invoiceId,
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isMakingReceipt = false);
        showSnackbar(e.toString(), context);
      }
    }
  }
}

// ── Reusable action icon used inside AppointmentCard ────────────────

class _ActionIcon extends StatelessWidget {
  final String assetPath;
  final String label;

  const _ActionIcon({required this.assetPath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color(0xffEFE9E9),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SvgPicture.asset(
              assetPath,
              height: 20,
              width: 20,
              colorFilter: const ColorFilter.mode(
                Color(0xff413D56),
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.urbanist(
            textStyle: const TextStyle(fontSize: 12),
            fontWeight: FontWeight.w500,
            color: const Color(0xff0C091F),
          ),
        ),
      ],
    );
  }
}
