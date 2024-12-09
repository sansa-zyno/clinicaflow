import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/go_router_config.dart';
import 'package:healtether_clinic_app/business_logic/blocs/appointment_bloc/appointment_bloc.dart';
import 'package:healtether_clinic_app/business_logic/blocs/login_bloc/login_bloc.dart';
import 'package:healtether_clinic_app/business_logic/cubits/allergy_cubit/allergy_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/analytics/patient_analysis/age_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/analytics/patient_analysis/gender_ratio_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/analytics/patient_analysis/patient_ratio_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/appointment_cubit/appointment_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/drug_cubit/drug_prescription_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/home_page_bottom_nav_cubit/home_page_bottom_nav_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/lab_test_cubit/lab_test_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/messaging/whatsapp/whatsapp_messaging_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/past_medical_history_cubit/past_medical_history_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/patient_detail/patient_detail_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/patient_records_cubit/patient_records_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/payment_cubit/payment_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/profile_image_cubit/profile_image_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/settings_cubit/settings_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/staff_cubit/staff_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/staff_detail/staff_detail_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/symptoms_and_diagnosis_cubit/symptoms_and_diagnosis_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/vitals_cubit/vitals_cubit.dart';
import 'package:healtether_clinic_app/data_layer/services/analytics/analytics_service.dart';
import 'package:healtether_clinic_app/data_layer/services/patients_service/patient_service.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/data_layer/services/shared_preferences_service.dart';
import 'package:healtether_clinic_app/data_layer/services/staff_service/staff_service.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefService.initSharedPref();
  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: await getApplicationDocumentsDirectory());

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()), //? would be here
        BlocProvider(create: (context) => AppointmentBloc(AnalyticsService())),
        BlocProvider(create: (context) => HomePageBottomNavCubit()),
        BlocProvider(create: (context) => AppointmentCubit()),
        BlocProvider(create: (context) => AllergyCubit()),
        BlocProvider(create: (context) => DrugPrescriptionCubit()),
        BlocProvider(create: (context) => VitalsCubit()),
        BlocProvider(create: (context) => LabTestCubit()),
        BlocProvider(create: (context) => PaymentCubit()),
        BlocProvider(create: (context) => StaffCubit()),
        BlocProvider(create: (context) => StaffDetailCubit(StaffServices())),
        BlocProvider(create: (context) => PatientRecordsCubit()),
        BlocProvider(create: (context) => SettingsCubit()),
        BlocProvider(create: (context) => ProfileImageCubit()),
        BlocProvider(create: (context) => PatientRatioCubit(AnalyticsService())),
        BlocProvider(create: (context) => PatientGenderRatioCubit(AnalyticsService())),
        BlocProvider(create: (context) => AgeRatioCubit(AnalyticsService())),
        BlocProvider(create: (context) => PatientDetailCubit(PatientService())),
        BlocProvider(create: (context) => SymptomsAndDiagnosisCubit()),
        BlocProvider(create: (context) => PastMedicalHistoryCubit()),
        BlocProvider(create: (context) => WhatsappMessagingCubit()),
        //? would be here
      ],
      child: MyApp(routerConfig: routerConfig),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouterConfig routerConfig;
  const MyApp({Key? key, required this.routerConfig}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white, surfaceTintColor: Colors.white),
          bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white, surfaceTintColor: Colors.white),
          dialogTheme: const DialogTheme(backgroundColor: Colors.white, surfaceTintColor: Colors.white),
          textTheme: GoogleFonts.poppinsTextTheme(),
          // switchTheme: SwitchThemeData(),
          timePickerTheme: const TimePickerThemeData(
              dialBackgroundColor: Colors.white,
              dialTextColor: Colors.black,
              dayPeriodTextStyle: TextStyle(color: AppColors.eerieBlack, fontWeight: FontWeight.w500))),
      routerConfig: routerConfig.router,
    );
  }
}
