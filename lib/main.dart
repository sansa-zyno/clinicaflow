import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clinica_flow/core/navigation/go_router_config.dart';
import 'package:clinica_flow/features/appointment/bloc/appointment_bloc.dart';
import 'package:clinica_flow/features/auth/bloc/login_bloc.dart';
import 'package:clinica_flow/features/allergy/viewmodel/allergy_cubit.dart';
import 'package:clinica_flow/features/analytics/viewmodel/age_cubit.dart';
import 'package:clinica_flow/features/analytics/viewmodel/gender_ratio_cubit.dart';
import 'package:clinica_flow/features/analytics/viewmodel/patient_ratio_cubit.dart';
import 'package:clinica_flow/features/appointment/viewmodel/appointment_cubit.dart';
import 'package:clinica_flow/features/medication/viewmodel/drug_prescription_cubit.dart';
import 'package:clinica_flow/core/navigation/home_page_bottom_nav_cubit.dart';
import 'package:clinica_flow/features/lab_test/viewmodel/lab_test_cubit.dart';
import 'package:clinica_flow/features/chat/viewmodel/whatsapp_messaging_cubit.dart';
import 'package:clinica_flow/features/notification/viewmodel/notification_cubit.dart';
import 'package:clinica_flow/features/onboarding/viewmodel/onboarding_cubit.dart';
import 'package:clinica_flow/features/past_medical_history/viewmodel/past_medical_history_cubit.dart';
import 'package:clinica_flow/features/patient/viewmodel/patient_detail_cubit.dart';
import 'package:clinica_flow/features/patient/viewmodel/patient_records_cubit.dart';
import 'package:clinica_flow/features/payment/viewmodel/payment_cubit.dart';
import 'package:clinica_flow/features/prescription/viewmodel/prescription_report_cubit.dart';
import 'package:clinica_flow/features/profile/viewmodel/profile_image_cubit.dart';
import 'package:clinica_flow/features/profile/viewmodel/settings_cubit.dart';
import 'package:clinica_flow/features/team/viewmodel/staff_cubit.dart';
import 'package:clinica_flow/features/team/viewmodel/staff_detail_cubit.dart';
import 'package:clinica_flow/features/symptoms_diagnosis/viewmodel/symptoms_and_diagnosis_cubit.dart';
import 'package:clinica_flow/features/vitals/viewmodel/vitals_cubit.dart';
import 'package:clinica_flow/features/analytics/service/analytics_service.dart';
import 'package:clinica_flow/features/notification/service/notifications_services.dart';
import 'package:clinica_flow/features/patient/service/patient_service.dart';
import 'package:clinica_flow/core/utils/shared_preferences_service.dart';
import 'package:clinica_flow/features/team/service/staff_service.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:clinica_flow/core/constants/app_colors.dart';

import 'core/constants/data_initializer.dart';
import 'core/utils/background_services/background_fetch_implementation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await DataInitializer.initializeSampleData();
  await SharedPrefService.initSharedPref();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorageDirectory.web
          : HydratedStorageDirectory((await getTemporaryDirectory()).path));
  await NotificationService.initializeAwesomeNotification();
  await NotificationService.listenToActions();
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);

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
        BlocProvider(
            create: (context) => PatientRatioCubit(AnalyticsService())),
        BlocProvider(
            create: (context) => PatientGenderRatioCubit(AnalyticsService())),
        BlocProvider(create: (context) => AgeRatioCubit(AnalyticsService())),
        BlocProvider(create: (context) => PatientDetailCubit(PatientService())),
        BlocProvider(create: (context) => SymptomsAndDiagnosisCubit()),
        BlocProvider(create: (context) => PastMedicalHistoryCubit()),
        BlocProvider(create: (context) => WhatsappMessagingCubit()),
        BlocProvider(create: (context) => NotificationCubit()),
        BlocProvider(create: (context) => PrescriptionReportCubit()),
        BlocProvider(create: (context) => OnboardingCubit()),
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
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white, surfaceTintColor: Colors.white),
          bottomSheetTheme: const BottomSheetThemeData(
              backgroundColor: Colors.white, surfaceTintColor: Colors.white),
          dialogTheme: const DialogThemeData(
              backgroundColor: Colors.white, surfaceTintColor: Colors.white),
          textTheme: GoogleFonts.poppinsTextTheme(),
          // switchTheme: SwitchThemeData(),
          timePickerTheme: const TimePickerThemeData(
              dialBackgroundColor: Colors.white,
              dialTextColor: Colors.black,
              dayPeriodTextStyle: TextStyle(
                  color: AppColors.eerieBlack, fontWeight: FontWeight.w500))),
      routerConfig: routerConfig.router,
    );
  }
}
