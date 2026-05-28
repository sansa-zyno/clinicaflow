// ignore_for_file: public_member_api_docs, sort_constructors_first

part of '../viewmodel/settings_cubit.dart';

class SettingsState {
  final SettingsStates state;
  final bool useAiPredictiveSearch;
  final bool previewPrescriptionbeforePrint;
  final bool notifyUserOnWhatsapp;
  final List<TemplateFormData>? templatesFormData;

  SettingsState(
      {required this.state,
      this.templatesFormData,
      this.useAiPredictiveSearch = true,
      this.previewPrescriptionbeforePrint = false,
      this.notifyUserOnWhatsapp = false});

  SettingsState copyWith({
    TemplateFormData? templateFormData,
    SettingsStates? state,
    bool? useAiPredictiveSearch,
    bool? previewPrescriptionbeforePrint,
    bool? notifyUserOnWhatsapp,
  }) {
    log("TEMPLATE TO SAVE: $templateFormData");
    // List<TemplateFormData>? parsedFormData = templatesFormData?.map((e) {
    //   final currentTemplate = e.template;
    //   final templateToCopy = templateFormData!.template;

    //   log("e: $currentTemplate, t: $templateToCopy, equal: ${currentTemplate == templateToCopy}");
    //   return currentTemplate == templateToCopy ? templateFormData : e;
    // }).toList();
    List<TemplateFormData>? parsedFormData = templatesFormData;

    final bool? updateTemplate = templatesFormData?.contains(templateFormData);

    log("INITIAL PARSED FORM DATA: $parsedFormData");

    if (templateFormData != null) {
      if (updateTemplate != null) {
        log("UPDATE/CREATE NEW TEMPLATE");
        parsedFormData?.add(templateFormData);
        parsedFormData = parsedFormData?.toSet().toList();
      } else {
        log("ADD INITIAL TEMPLATE");
        parsedFormData = [templateFormData];
      }
    }

    

    log("parsed data: $parsedFormData");

    return SettingsState(
      state: state ?? this.state,
      templatesFormData: parsedFormData ?? templatesFormData,
      useAiPredictiveSearch:
          useAiPredictiveSearch ?? this.useAiPredictiveSearch,
      previewPrescriptionbeforePrint:
          previewPrescriptionbeforePrint ?? this.previewPrescriptionbeforePrint,
      notifyUserOnWhatsapp: notifyUserOnWhatsapp ?? this.notifyUserOnWhatsapp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'state': state.describe,
      'templatesFormData': templatesFormData?.map((e) => e.toMap()).toList(),
      'useAiPredictiveSearch': useAiPredictiveSearch,
      'previewPrescriptionbeforePrint': previewPrescriptionbeforePrint,
      'notifyUserOnWhatsapp': notifyUserOnWhatsapp,
    };
  }

  factory SettingsState.fromMap(Map<String, dynamic> map) {
    return SettingsState(
      state: SettingsStates.fromString(map['state'] as String),
      useAiPredictiveSearch: map['useAiPredictiveSearch'] as bool,
      templatesFormData: map['templatesFormData'] != null
          ? (map['templatesFormData'] as List<Map<String, dynamic>>?)
              ?.map((e) => TemplateFormData.fromMap(e))
              .toList()
          : null,
      previewPrescriptionbeforePrint:
          map['previewPrescriptionbeforePrint'] as bool,
      notifyUserOnWhatsapp: map['notifyUserOnWhatsapp'] as bool,
    );
  }

  @override
  String toString() {
    return 'SettingsState(state: $state, useAiPredictiveSearch: $useAiPredictiveSearch, previewPrescriptionbeforePrint: $previewPrescriptionbeforePrint, notifyUserOnWhatsapp: $notifyUserOnWhatsapp, templatesFormData: $templatesFormData)';
  }
}
