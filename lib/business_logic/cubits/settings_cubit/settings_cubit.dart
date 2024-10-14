import 'dart:convert';

import 'package:healtether_clinic_app/data_layer/models/template_form_data/template_form_data.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'settings_state.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(SettingsState(state: SettingsStates.initial));

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    return SettingsState.fromMap(json);
  }

  // modify useAiPredictiveSearch;
  void updateUseAiPredictiveSearch(bool value) {
    final newState = state.copyWith(state: SettingsStates.useAiPredictiveSearchUpdated, useAiPredictiveSearch: value);
    emit(newState);
  }
  // modify previewPrescriptionbeforePrint;
  void updatePreviewPrescriptionbeforePrint(bool value) {
    final newState = state.copyWith(state: SettingsStates.previewPrescriptionbeforePrintUpdated, previewPrescriptionbeforePrint: value);
    emit(newState);
  }
  // modify notifyUserOnWhatsapp;
  void updateNotifyUserOnWhatsapp(bool value) {
    final newState = state.copyWith(state: SettingsStates.notifyUserOnWhatsappUpdated, notifyUserOnWhatsapp: value);
    emit(newState);
  }

  // modify templateFormData;
  void updateTemplateFormData(TemplateFormData value) {
    final newState = state.copyWith(state: SettingsStates.templateFormDataUpdated, templateFormData: value);
    emit(newState);
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    return state.toMap();
  }
}
