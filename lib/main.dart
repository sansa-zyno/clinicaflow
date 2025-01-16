import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:background_fetch/background_fetch.dart';
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
import 'package:healtether_clinic_app/business_logic/cubits/notification/notification_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/past_medical_history_cubit/past_medical_history_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/patient_detail/patient_detail_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/patient_records_cubit/patient_records_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/payment_cubit/payment_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/prescription/prescription_report_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/profile_image_cubit/profile_image_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/settings_cubit/settings_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/staff_cubit/staff_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/staff_detail/staff_detail_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/symptoms_and_diagnosis_cubit/symptoms_and_diagnosis_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/vitals_cubit/vitals_cubit.dart';
import 'package:healtether_clinic_app/constants/api.dart';
import 'package:healtether_clinic_app/data_layer/services/analytics/analytics_service.dart';
import 'package:healtether_clinic_app/data_layer/services/http.service.dart';
import 'package:healtether_clinic_app/data_layer/services/notifications_services.dart';
import 'package:healtether_clinic_app/data_layer/services/patients_service/patient_service.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/data_layer/services/shared_preferences_service.dart';
import 'package:healtether_clinic_app/data_layer/services/staff_service/staff_service.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<Map<String, dynamic>?> api() async {
  String token = await SharedPrefService.getAccessToken() ?? "";
  String clinicId = await SharedPrefService.getClinicId() ?? "";
  if (token != '' && clinicId != '') {
    final response = await HttpService.get(ApiEndPoint.getNotifications(clinicId: clinicId), token);
    if (response.statusCode == 200) {
      List<Map<String, dynamic>>? list = response.data != null ? List<Map<String, dynamic>>.from(response.data['data'] ?? []) : null;
      if (list != null) {
        DateTime now = DateTime.now();
        String? savedIdsString = await SharedPrefService.getString("savedIds");
        List savedIds = savedIdsString != null ? jsonDecode(savedIdsString) : [];
        Map<String, dynamic>? lastItem = list.lastWhere((element) {
          DateTime showTime = DateTime.parse(element['showTime']);
          return showTime.difference(now).inDays >= 0 && !savedIds.contains(element["_id"]);
        }, orElse: () {
          return {}; //to prevent bad state error
        });
        return lastItem;
      } else {
        return null;
      }
    } else {
      return null;
    }
  } else {
    return null;
  }
}

// [Android-only] This "Headless Task" is run when the Android app
// is terminated with enableHeadless: true
@pragma('vm:entry-point')
void backgroundFetchHeadlessTask(HeadlessTask task) async {
  String taskId = task.taskId;
  //print(taskId);
  bool isTimeout = task.timeout;
  if (isTimeout) {
    // This task has exceeded its allowed running-time.
    // You must stop what you're doing and immediately .finish(taskId)
    BackgroundFetch.finish(taskId);
    return;
  }
  // Do your work here...
  try {
    //SharedPreferences? prefs = await SharedPreferences.getInstance();
    await SharedPrefService.initSharedPref();
    Map<String, dynamic>? apiResult = await api();
    if (apiResult != null && apiResult.isNotEmpty) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: Random().nextInt(20),
            channelKey: NotificationService.appNotificationChannel().channelKey!,
            title: "${apiResult['header']}",
            body: "${apiResult["notificationMessage"]}",
            icon: "resource://drawable/res_launcher",
            // notificationLayout: NotificationLayout.BigPicture,
            //bigPicture: "resource://drawable/launcher_icon",
            payload: {
              "id": "${apiResult['_id']}",
              "header": "${apiResult['header']}",
              "notificationMessage": "${apiResult["notificationMessage"]}",
              "showTime": "${apiResult["showTime"]}",
              "seen": "${apiResult["seen"]}",
            }),
      );
      String? savedIdsString = await SharedPrefService.getString("savedIds");
      List savedIds = savedIdsString != null ? jsonDecode(savedIdsString) : [];
      savedIds.insert(0, apiResult['_id']);
      await SharedPrefService.setString("savedIds", jsonEncode(savedIds));
    }
  } catch (e) {
    dev.log(e.toString());
    throw Exception(e);
  }
  BackgroundFetch.finish(taskId);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefService.initSharedPref();
  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: await getApplicationDocumentsDirectory());
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
        BlocProvider(create: (context) => PatientRatioCubit(AnalyticsService())),
        BlocProvider(create: (context) => PatientGenderRatioCubit(AnalyticsService())),
        BlocProvider(create: (context) => AgeRatioCubit(AnalyticsService())),
        BlocProvider(create: (context) => PatientDetailCubit(PatientService())),
        BlocProvider(create: (context) => SymptomsAndDiagnosisCubit()),
        BlocProvider(create: (context) => PastMedicalHistoryCubit()),
        BlocProvider(create: (context) => WhatsappMessagingCubit()),
        BlocProvider(create: (context) => NotificationCubit()),
        BlocProvider(create: (context) => PrescriptionReportCubit()),
        //? would be here
      ],
      child: MyApp(routerConfig: routerConfig),
    ),
  );
}

class MyApp extends StatefulWidget {
  final AppRouterConfig routerConfig;
  const MyApp({Key? key, required this.routerConfig}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    int status = await BackgroundFetch.configure(
        BackgroundFetchConfig(
            minimumFetchInterval: 1,
            forceAlarmManager: true,
            stopOnTerminate: false,
            enableHeadless: true,
            startOnBoot: true,
            requiresBatteryNotLow: false,
            requiresCharging: false,
            requiresStorageNotLow: false,
            requiresDeviceIdle: false,
            requiredNetworkType: NetworkType.ANY), (String taskId) async {
      // <-- Event handler
      // This is the fetch-event callback.
      //print("[BackgroundFetch] Event received $taskId");
      try {
        Map<String, dynamic>? apiResult = await api();
        if (apiResult != null && apiResult.isNotEmpty) {
          AwesomeNotifications()
              .createNotification(
                content: NotificationContent(
                    id: Random().nextInt(20),
                    channelKey: NotificationService.appNotificationChannel().channelKey!,
                    title: "${apiResult['header']}",
                    body: "${apiResult["notificationMessage"]}",
                    icon: "resource://drawable/res_launcher",
                    // notificationLayout: NotificationLayout.BigPicture,
                    //bigPicture: "resource://drawable/launcher_icon",
                    payload: {
                      "id": "${apiResult['_id']}",
                      "header": "${apiResult['header']}",
                      "notificationMessage": "${apiResult["notificationMessage"]}",
                      "showTime": "${apiResult["showTime"]}",
                      "seen": "${apiResult["seen"]}",
                    }),
              )
              .then((value) => context.read<NotificationCubit>().fetchNotifications());
          String? savedIdsString = await SharedPrefService.getString("savedIds");
          List savedIds = savedIdsString != null ? jsonDecode(savedIdsString) : [];
          savedIds.insert(0, apiResult['_id']);
          await SharedPrefService.setString("savedIds", jsonEncode(savedIds));
        }
      } catch (e) {
        dev.log(e.toString());
        throw Exception(e);
      }
      BackgroundFetch.finish(taskId);
    }, (String taskId) async {
      BackgroundFetch.finish(taskId);
    });
    if (!mounted) return;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }

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
      routerConfig: widget.routerConfig.router,
    );
  }
}
