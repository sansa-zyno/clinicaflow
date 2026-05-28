import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:clinica_flow/features/patient/viewmodel/patient_records_cubit.dart';
import 'package:clinica_flow/core/utils/enums/bloc_enums.dart';
import 'package:clinica_flow/core/utils/enums/route_enums.dart';
import 'package:clinica_flow/core/utils/extensions.dart/widget_extensions.dart';
import 'package:clinica_flow/shared/widgets/text_list_tile.dart';

import '../../patient/model/patient_model.dart';

/// Builds the patient search results shown in the overlay dropdown.
class PatientSearchResults extends StatelessWidget {
  final String query;
  final VoidCallback onPatientSelected;

  const PatientSearchResults({
    super.key,
    required this.query,
    required this.onPatientSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientRecordsCubit, PatientRecordsState>(
      builder: (context, state) {
        if (state.state == PatientRecordsStates.fetchingPatients ||
            state.state == PatientRecordsStates.fetchingPatientsFailed) {
          return const SizedBox.shrink();
        }

        final results = _filterPatients(state.patients, query);

        if (results.isEmpty) {
          return Container(
            padding: const EdgeInsets.only(right: 60),
            height: 325,
            child: const Center(child: Text('No data found')),
          );
        }

        return Column(
          children: results.map((patient) {
            return TextListTile(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              text: patient.fullName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              onTap: () {
                context.pushNamed(
                  AppRoutes.patientRecordsScreen.name,
                  extra: patient,
                );
                onPatientSelected();
              },
            ).pOnly(bottom: 8);
          }).toList(),
        );
      },
    );
  }

  List<PatientModel> _filterPatients(
    List<PatientModel>? patients,
    String query,
  ) {
    if (patients == null || query.isEmpty) return [];

    final lowerQuery = query.toLowerCase();

    return patients.where((patient) {
      return (patient.id?.toLowerCase().startsWith(lowerQuery) ?? false) ||
          (patient.firstName?.toLowerCase().trim().startsWith(lowerQuery) ??
              false) ||
          (patient.lastName?.toLowerCase().trim().startsWith(lowerQuery) ??
              false) ||
          (patient.mobile?.startsWith(query) ?? false);
    }).toList();
  }
}
