import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';
import 'package:healtether_clinic_app/data_layer/models/template_form_data/template_form_data.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/constants/app_icons.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:healtether_clinic_app/utils/enums/enums.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/string_extensions.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/widget_extensions.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';
import 'package:healtether_clinic_app/utils/mixins/app_bar_mixin.dart';
import 'package:healtether_clinic_app/utils/mixins/image_mixin.dart';
import 'package:healtether_clinic_app/utils/mixins/ui_info_mixin.dart';
import 'package:healtether_clinic_app/widgets/buttons/my_elevated_button.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_slot/appointment_slot.dart';
import 'package:healtether_clinic_app/widgets/buttons/my_selectable_container.dart';
import 'package:healtether_clinic_app/widgets/section_text.dart';
import 'package:healtether_clinic_app/widgets/containers/my_image_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/business_logic/cubits/settings_cubit/settings_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_slot/time_slot.dart';
import 'package:uuid/uuid.dart';

class PrescriptionLayout extends StatefulWidget {
  const PrescriptionLayout({super.key, required this.template});

  final PrescriptionTemplates template;

  @override
  State<PrescriptionLayout> createState() => _PrescriptionLayoutState();
}

class _PrescriptionLayoutState extends State<PrescriptionLayout> with AppBarMixin, ImageMixin, UiInfoMixin {
  late final TextEditingController doctorName;
  late final TextEditingController doctorSpecialty;
  late final TextEditingController otherInfo;
  late final TextEditingController clinicAddress;
  // late final TextEditingController clinicContact;
  // late final TextEditingController clinicEmail;
  late final List<TextEditingController> clinicContacts;
  late final List<TextEditingController> clinicEmails;
  late TemplateFormData form;
  XFile? clinicLogo;
  late List<AppointmentSlot> openHours;
  late List<TextEditingController> openHoursControllers;

  Map<String, bool> autofill = {
    "Patient Id": false,
    "Patient Personal details - Name, contact": false,
    "Patient Vitals details": false,
    "Patient Past history details": false,
    "Symptoms and Diagnosis": false,
    "Lab Tests": false,
    "Drug prescription": false,
  };

  @override
  void initState() {
    super.initState();
    final savedTemplateForm = (context.read<SettingsCubit>().state.templatesFormData);

    log("SAVED TEMPLATE FORM: $savedTemplateForm");
    List<TemplateFormData>? currentForm = savedTemplateForm?.where((form) => form.template == widget.template).toList();
    form = (currentForm == null || currentForm.isEmpty == true ? [TemplateFormData(template: widget.template)] : currentForm).first;
    log("INITIAL FORM DATA: $form");
    if (form.clinicLogo != null) clinicLogo = XFile(form.clinicLogo!);

    openHours = form.openHours;
    if (openHours.isEmpty) {
      openHours = [
        AppointmentSlot(id: Uuid().v4(), days: [], duration: '', timeSlots: [TimeSlot(const Uuid().v4())])
      ];
    }

    doctorName = TextEditingController(text: form.doctorName);
    doctorSpecialty = TextEditingController(text: form.doctorSpecialty);
    otherInfo = TextEditingController(text: form.otherInfo);
    clinicAddress = TextEditingController(text: form.clinicAddress);
    clinicContacts = List<TextEditingController>.generate(form.clinicContacts.length, (index) {
      final contact = form.clinicContacts.elementAt(index);

      return TextEditingController(text: contact);
    });
    clinicEmails = List<TextEditingController>.generate(form.clinicEmails.length, (index) {
      final email = form.clinicEmails.elementAt(index);

      return TextEditingController(text: email);
    });
  }

  TextStyle get titleTextStyle =>
      GoogleFonts.urbanist(textStyle: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.grey, fontSize: 17, height: 23.12 / 17));

  @override
  void dispose() {
    doctorName.dispose();
    doctorSpecialty.dispose();
    otherInfo.dispose();
    clinicAddress.dispose();
    for (var e in clinicContacts) {
      e.dispose();
    }
    for (var e in clinicEmails) {
      e.dispose();
    }
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state.state == SettingsStates.templateFormDataUpdated) {
          showMessage(context, "Success", "Template data saved");
        }
      },
      child: Scaffold(
        appBar: buildAppBar(context, title: "Clinic Settings", showDefaultActions: false),
        bottomNavigationBar: BlocBuilder<SettingsCubit, SettingsState>(builder: (context, state) {
          // final bool isValid = validateForm();
          // log("BUILDING SAVE: ${form.isValid}");
          return MyElevatedButton(
              text: "Save",
              height: 61,
              backgroundColor: form.isValid == false ? AppColors.whiteSmoke : null,
              textStyle: TextStyle(color: form.isValid == false ? AppColors.lightGrey3 : null),
              onPressed: () {
                log("NEW SETTINGS: $state");
                FocusManager.instance.primaryFocus?.unfocus();
                final bool isValid = validateForm();
                if (!isValid) return;
                if (form.clinicLogo == null) {
                  showMessage(context, "Error", "Please add clinic logo");
                  return;
                }

                context.read<SettingsCubit>().updateTemplateFormData(form);
              }).pSymmetric(vertical: 20, horizontal: 50);
        }),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                //? PRESCRIPTION SETTINGS
                const SectionText("PRESCRIPTION SETTINGS").pSymmetric(),

                const SizedBox(height: 14),

                //? TEMPLATE IMAGE
                Image.asset(widget.template.imgPath).pSymmetric(),

                const SizedBox(height: 24),

                //* SECTION - HEADER INFO
                buildSectionHeader("Header Info").pSymmetric(),

                //? ADD CLINIC LOGO
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(
                    "Add Clinic Logo",
                    style: GoogleFonts.urbanist(textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, height: 23.12 / 17)),
                  ),

                  //? select image
                  MyImageContainer(
                    file: clinicLogo,
                    onTap: () async {
                      print("Change image");
                      clinicLogo = await getSingleImageFromSource();
                      if (clinicLogo != null) {
                        setState(() {
                          form = form.copyWith(clinicLogo: clinicLogo?.path);
                        });
                      }
                    },
                    child: AppIcons.camera,
                  )
                ]).pSymmetric(vertical: 12),

                //? DOCTORS NAME
                TitledTextField(
                        title: "Doctor's name",
                        controller: doctorName,
                        onChanged: (value) => setState(() {
                              form = form.copyWith(doctorName: value);
                              log("NEW FORM: $form");
                            }),
                        validator: (value) => nonNullValidator(value, "Doctor's name cannot be empty"),
                        hintText: "E.g Dr Kim Jones")
                    .pOnly(left: 16, right: 16, bottom: 12),

                //? DOCTOR'S SPECIALTY
                TitledTextField(
                        title: "Doctor's specialty",
                        controller: doctorSpecialty,
                        onChanged: (value) => setState(() {
                              form = form.copyWith(doctorSpecialty: value);
                              log("NEW FORM: $form");
                            }),
                        validator: (value) => nonNullValidator(value, "Doctor's specialty cannot be empty"),
                        hintText: "E.g Neurologist")
                    .pOnly(left: 16, right: 16, bottom: 12),

                //? OTHER INFORMATION
                TitledTextField(
                        title: "Other information",
                        controller: otherInfo,
                        onChanged: (value) => setState(() {
                              form = form.copyWith(otherInfo: value);
                              log("NEW FORM: $form");
                            }),
                        hintText: "E.g MBBS | MD | AIIMS, etc.")
                    .pOnly(left: 16, right: 16),

                const SizedBox(height: 8),

                //* SECTION - FOOTER INFO
                buildSectionHeader("Footer Info").pSymmetric(vertical: 12),
                //? CLINIC ADDRESS
                TitledTextField(
                        title: "Clinic address",
                        controller: clinicAddress,
                        onChanged: (value) => setState(() {
                              form = form.copyWith(clinicAddress: value);
                              log("NEW FORM: $form");
                            }),
                        validator: (value) => nonNullValidator(value, "Clinic address cannot be empty"),
                        hintText: "E.g Plot no, Street, Landmark, City, State")
                    .pOnly(left: 16, right: 16, bottom: 12),

                //? CLINIC CONTACT
                Text("Clinic contact${clinicContacts.length > 1 ? 's' : ''}", style: titleTextStyle).pOnly(bottom: 4, left: 16, right: 16),
                ...List<Widget>.generate(clinicContacts.length, (index) {
                  final clinicContact = clinicContacts.elementAt(index);

                  return TitledTextField(
                          controller: clinicContact,
                          onChanged: (value) => setState(() {
                                form = form.copyWith(clinicContacts: clinicContacts.map((e) => e == clinicContact ? value : e.text).toList());
                                log("NEW FORM: $form");
                              }),
                          validator: (value) => nonNullValidator(value, "Clinic contact cannot be empty"),
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          keyBoardType: TextInputType.number,
                          hintText: "E.g +91")
                      .pOnly(left: 16, right: 16, bottom: 12);
                }),
                // add contact
                CustomTextButton(
                  text: "Add contact",
                  dividerLength: 135,
                  prefixIcon: AppIcons.add,
                  onTap: () {
                    log("Adding contact");
                    setState(() {
                      form = form.copyWith(clinicContacts: [...form.clinicContacts, '']);
                      clinicContacts.add(TextEditingController(text: ''));

                      log("new form: $form");
                    });
                  },
                ).pSymmetric(),

                const SizedBox(
                  height: 12,
                ),

                //? CLINIC EMAIL
                Text("Clinic email${clinicEmails.length > 1 ? 's' : ''}", style: titleTextStyle).pOnly(bottom: 4, left: 16, right: 16),
                ...List<Widget>.generate(clinicEmails.length, (index) {
                  final clinicEmail = clinicEmails.elementAt(index);

                  return TitledTextField(
                          controller: clinicEmail,
                          onChanged: (value) => setState(() {
                                form = form.copyWith(clinicEmails: clinicEmails.map((e) => e == clinicEmail ? value : e.text).toList());
                                log("NEW FORM: $form");
                              }),
                          validator: (value) => nonNullValidator(value, "Clinic email cannot be empty"),
                          hintText: "E.g xyz@gmail.com")
                      .pOnly(left: 16, right: 16, bottom: 12);
                }),

                // add email
                CustomTextButton(
                  text: "Add email",
                  dividerLength: 120,
                  prefixIcon: AppIcons.add,
                  onTap: () {
                    log("Adding email");
                    setState(() {
                      form = form.copyWith(clinicEmails: [...form.clinicEmails, '']);
                      clinicEmails.add(TextEditingController(text: ''));

                      log("new form: $form");
                    });
                  },
                ).pSymmetric(),

                //? CLINIC OPEN HOURS

                boldSubheading("Clinic open hours").pSymmetric(vertical: 12),
                ...List<Widget>.generate(openHours.length, (index) {
                  final openHour = openHours.elementAt(index);

                  return TimeSelectionCard(appointmentSlot: openHour).pSymmetric();
                }),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //? add other timings
                    CustomTextButton(
                        text: "Add other timings",
                        onTap: () {
                          setState(() {
                            openHours.add(AppointmentSlot(id: Uuid().v4(), days: [], duration: '', timeSlots: [TimeSlot(const Uuid().v4())]));
                          });
                        }),

                    //? clear
                    CustomTextButton(
                        text: "Clear",
                        textStyle: const TextStyle(color: AppColors.darkBlueViolet),
                        onTap: () {
                          setState(() {
                            openHours = [AppointmentSlot.empty()];
                          });
                        })
                  ],
                ).pOnly(left: 16, right: 16, top: 16, bottom: 24),

                //* SECTION - BODY INFO
                const SizedBox(
                  height: 12,
                ),

                buildSectionHeader("Body Info").pSymmetric(vertical: 8),
                //? AUTOFILL DATA IN THE PRESCRIPTION
                boldSubheading("Auto fill data in the prescription").pSymmetric(),
                const SizedBox(
                  height: 4,
                ),

                ...List<Widget>.generate(autofill.values.length, (index) {
                  final key = autofill.keys.elementAt(index);
                  final value = autofill[key];

                  return Row(
                    children: [
                      //? check box
                      Checkbox.adaptive(
                          value: value,
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                autofill[key] = value;
                              });
                            }
                          }),

                      //? column with key
                      Expanded(
                          child: Column(
                              mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [Text(key), const Divider()]))
                    ],
                  ).pSymmetric();
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateForm() => _formKey.currentState?.validate() ?? false;

  Text boldSubheading(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, height: 18.2 / 14)),
    );
  }

  Text buildSectionHeader(String text) {
    return Text(text.toUpperCase(),
        style: GoogleFonts.urbanist(
            textStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          color: AppColors.lightGrey6,
          fontSize: 16,
          height: 19.2 / 16,
        )));
  }

  String? nonNullValidator(String? value, String errorMessage) {
    if (value?.isEmpty == true) return errorMessage;
    return null;
  }
}

class TitledTextField extends StatelessWidget {
  const TitledTextField(
      {super.key,
      this.title,
      required this.controller,
      required this.hintText,
      this.validator,
      this.inputFormatters,
      this.onChanged,
      this.keyBoardType});
  final String? title;
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyBoardType;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
      // title
      if (title != null)
        Text(title!,
            style: GoogleFonts.urbanist(
                textStyle: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.grey, fontSize: 17, height: 23.12 / 17))),

      if (title != null) const SizedBox(height: 4),

      // textfield
      CustomTextField(
        controller: controller,
        validator: validator,
        inputFormatters: inputFormatters,
        hintText: hintText,
        keyBoardType: keyBoardType,
        onChanged: onChanged,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      )
    ]);
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, required this.text, this.prefixIcon, this.dividerLength, this.textStyle, required this.onTap});
  final String text;
  final Widget? prefixIcon;
  final void Function() onTap;
  final double? dividerLength;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (prefixIcon != null) AppIcons.add,
              if (prefixIcon != null)
                const SizedBox(
                  width: 12,
                ),
              Text(text,
                  style: GoogleFonts.urbanist(
                      textStyle: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.blueViolet, fontSize: 17, height: 23.12 / 17)
                          .merge(textStyle))),
            ],
          ),
          if (dividerLength != null) const SizedBox(height: 6),
          if (dividerLength != null) SizedBox(width: dividerLength, child: Divider(color: textStyle?.color ?? AppColors.blueViolet, thickness: 2))
        ],
      ),
    );
  }
}

class TimeSelectionCard extends StatefulWidget {
  const TimeSelectionCard({super.key, required this.appointmentSlot});
  final AppointmentSlot appointmentSlot;

  @override
  State<TimeSelectionCard> createState() => _TimeSelectionCardState();
}

class _TimeSelectionCardState extends State<TimeSelectionCard> {
  final startHour = TextEditingController();
  final startMinute = TextEditingController();
  final DayPeriod startDayPeriod = DayPeriod.am;
  DayPeriod selectedStartDayPeriod = DayPeriod.am;

  final finishHour = TextEditingController();
  final finishMinute = TextEditingController();
  final DayPeriod finishDayPeriod = DayPeriod.pm;
  DayPeriod selectedFinishDayPeriod = DayPeriod.am;

  List<WeekDays> selectedDays = [];

  @override
  void initState() {
    super.initState();
    final String startStr = widget.appointmentSlot.timeSlots[0].startStr ?? '';
    final String finishStr = widget.appointmentSlot.timeSlots[0].finishStr ?? '';
    if (startStr.isNotEmpty) {
      startHour.text = startStr.split(':')[0];
      startMinute.text = startStr.split(':')[1];
    }

    if (finishStr.isNotEmpty) {
      finishHour.text = finishStr.split(':')[0];
      finishMinute.text = finishStr.split(':')[1];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //? time
            buildSectionText("Time").pOnly(bottom: 16),

            //? start time
            buildSectionText("Start time").pOnly(bottom: 12),

            TimeField(
                hour: startHour,
                minute: startMinute,
                selectedDayPeriod: selectedStartDayPeriod,
                onDayPeriodSelected: (newPeriod) {
                  setState(() {
                    selectedStartDayPeriod = newPeriod;
                  });
                }),

            //? end time
            buildSectionText("End time").pOnly(bottom: 12, top: 8),

            TimeField(
                hour: finishHour,
                minute: finishMinute,
                selectedDayPeriod: selectedFinishDayPeriod,
                onDayPeriodSelected: (newPeriod) {
                  setState(() {
                    selectedFinishDayPeriod = newPeriod;
                  });
                }),

            const SizedBox(height: 16),

            //? applicable for days
            Row(
              children: [
                Expanded(child: buildSectionText("Applicable for days")),
                Expanded(
                    flex: 2,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.end,
                      children: List<Widget>.generate(WeekDays.values.length, (index) {
                        final WeekDays weekDay = WeekDays.values.elementAt(index);
                        final bool selected = selectedDays.contains(weekDay);

                        return SelectableContainer(
                          title: Text(weekDay.describe.capitalize),
                          selectedTitle: Text(weekDay.describe.capitalize, style: const TextStyle(color: Colors.white)),
                          selected: selected,
                          onTap: () {
                            setState(() {
                              selected ? selectedDays.remove(weekDay) : selectedDays.add(weekDay);
                            });
                          },
                        );
                      }),
                    ))
              ],
            )
          ],
        ));
  }

  Text buildSectionText(String text) {
    return Text(
      text,
      style: GoogleFonts.urbanist(textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, height: 17.36 / 14)),
    );
  }
}

class TimeField extends StatelessWidget {
  final TextEditingController hour;
  final TextEditingController minute;
  final DayPeriod selectedDayPeriod;
  final void Function(DayPeriod) onDayPeriodSelected;
  const TimeField({
    super.key,
    required this.hour,
    required this.minute,
    required this.selectedDayPeriod,
    required this.onDayPeriodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //? hours
        Expanded(
            child: CustomTextField(
          controller: hour,
          hintText: "00",
          // suffixText: "hr",
          inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(2)],
        )),

        const Text(":"), //.pSymmetric(horizontal: 4),

        //? minutes
        Expanded(
            child: CustomTextField(
          controller: minute,
          hintText: "00",
          // suffixText: "min",
          inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(2)],
        )),

        SelectableContainer(
          height: 76,
          title: Text(DayPeriod.am.name.toUpperCase()),
          selectedTitle: Text(
            DayPeriod.am.name.toUpperCase(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          onTap: () => onDayPeriodSelected(DayPeriod.am),
          selected: selectedDayPeriod == DayPeriod.am,
        ),

        const SizedBox(width: 8),

        SelectableContainer(
          title: Text(DayPeriod.pm.name.toUpperCase()),
          height: 76,
          selectedTitle: Text(
            DayPeriod.pm.name.toUpperCase(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          onTap: () => onDayPeriodSelected(DayPeriod.pm),
          selected: selectedDayPeriod == DayPeriod.pm,
        )
      ],
    );
  }
}
