import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/business_logic/cubits/settings_cubit/settings_cubit.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/constants/app_images.dart';
import 'package:healtether_clinic_app/utils/enums/enums.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/widget_extensions.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';
import 'package:healtether_clinic_app/utils/mixins/app_bar_mixin.dart';
import 'package:healtether_clinic_app/widgets/section_text.dart';
import 'package:healtether_clinic_app/widgets/components/scrollable_row.dart';

class PrescriptionSettings extends StatefulWidget {
  const PrescriptionSettings({super.key});

  @override
  State<PrescriptionSettings> createState() => _PrescriptionSettingsState();
}

class _PrescriptionSettingsState extends State<PrescriptionSettings>
    with AppBarMixin {
  bool useAiPredictiveSearch = true;
  bool previewPrescriptionbeforePrint = false;
  bool notifyUserOnWhatsapp = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context,
          title: "Clinic Settings", automaticallyImplyLeading: true),
      body: SingleChildScrollView(
        child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                //? PRESCRIPTION SETTINGS
                const SectionText("PRESCRIPTION SETTINGS").pSymmetric(),

                const SizedBox(height: 14),

                //? AI PREDICTIVE SEARCH
                MySwitchListTile(
                  title: "Ai Predictive Search",
                  subtitle:
                      "The Ai search allows you to give predictive analysis based on the patient’s vitals, examinations, lab and reports",
                  value: state.useAiPredictiveSearch,
                  onChanged:
                      context.read<SettingsCubit>().updateUseAiPredictiveSearch,
                ).pSymmetric(),

                const SizedBox(
                  height: 18,
                ),

                // Prescription layout
                const MySwitchListTile(
                  title: "Prescription Layout",
                  subtitle:
                      "Choose from the templates available or add your own template.",
                ).pSymmetric(),

                const SizedBox(height: 18),

                //? Row of available Templates
                ScrollableRow(
                  height: 121,
                  children: List<Widget>.generate(
                      PrescriptionTemplates.values.length, (index) {
                    final template =
                        PrescriptionTemplates.values.elementAt(index);

                    return PrescriptionTemplateContainer(
                      title: "Template ${index + 1}",
                      child: Image.asset(template.imgPath),
                      onTap: () {
                        log("Tapped template ${index + 1}");
                        context.pushNamed(AppRoutes.prescriptionLayout.name,
                            extra: template);
                      },
                    ).pOnly(right: 18, left: index == 0 ? 16 : 0);
                  }),
                ),

                const SizedBox(height: 18),

                // preview prescription before pring
                MySwitchListTile(
                  title: "Preview the prescription before every print",
                  value: state.notifyUserOnWhatsapp,
                  onChanged:
                      context.read<SettingsCubit>().updateNotifyUserOnWhatsapp,
                ).pSymmetric(),

                const SizedBox(height: 18),

                // send prescription to user's whatsapp
                MySwitchListTile(
                        title:
                            "Auto send the prescription to the user's whatsapp, ask before action",
                        value: state.previewPrescriptionbeforePrint,
                        onChanged: context
                            .read<SettingsCubit>()
                            .updatePreviewPrescriptionbeforePrint)
                    .pSymmetric()
              ]);
        }),
      ),
    );
  }
}

class PrescriptionTemplateContainer extends StatelessWidget {
  const PrescriptionTemplateContainer(
      {super.key, required this.child, this.title, this.onTap});

  final Widget child;
  final String? title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            // container with child
            Container(
              width: 100,
              height: 100,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(color: AppColors.smokeGrey),
              child: child,
            ),

            // title
            if (title != null)
              Text(title!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          color: AppColors.lightGreen,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          height: 17.16 / 13)))
          ],
        ),
      ),
    );
  }
}

class MySwitchListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool? value;
  final void Function(bool)? onChanged;

  const MySwitchListTile(
      {super.key,
      required this.title,
      this.subtitle,
      this.value,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //? title and subtitle
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //? title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(title,
                          style: GoogleFonts.urbanist(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  height: 22.78 / 17)))),

                  if (value != null)
                    const SizedBox(
                      width: 9,
                    ),

                  //? check box
                  if (value != null)
                    MySwitch(value: value!, onChanged: onChanged)
                ],
              ),

              if (subtitle != null)
                const SizedBox(
                  height: 2,
                ),

              //? subtitle
              if (subtitle != null)
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        subtitle!,
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                height: 17.16 / 13,
                                color: AppColors.grey)),
                      ),
                    ),

                    //? invisible check box to adjust layout
                    const Opacity(
                      opacity: 0,
                      child: Switch.adaptive(value: false, onChanged: null),
                    )
                  ],
                )
            ],
          ),
        ),
      ],
    );
  }
}

class MySwitch extends StatelessWidget {
  const MySwitch({super.key, required this.value, required this.onChanged});
  final bool value;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
        value: value,
        activeColor: AppColors.blueViolet,
        activeTrackColor: AppColors.whiteSmoke,
        trackColor: const MaterialStatePropertyAll(AppColors.lightGrey3),
        trackOutlineColor: const MaterialStatePropertyAll(AppColors.lightGrey3),
        onChanged: onChanged);
  }
}
