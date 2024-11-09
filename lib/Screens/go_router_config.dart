import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:healtether_clinic_app/Screens/AppointmentScreen/appoinment_detail_screen.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/appointment_detail.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/appointment_screen.dart';
import 'package:healtether_clinic_app/Screens/ChatScreen/chat_screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/drug_prescription/digital_precription_screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/lab_investigations/lab_investigations_screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/prescription_preview.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/vitals_screen/other_vitals_screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/vitals_screen/personal_historyScreen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/vitals_screen/vitals_screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/digital_screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/family_history_screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/medication_history_screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/past_history_screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/past_medical_procedures.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/patient_%20suffering_from_%20allergies_screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/symptoms_diagnosis/create_digital_prescription_screens.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/past_medical_history/past_medical_history_screen.dart';
import 'package:healtether_clinic_app/Screens/HomeScreen/drawer_menu.dart';
import 'package:healtether_clinic_app/Screens/HomeScreen/feedback_page.dart';
import 'package:healtether_clinic_app/Screens/HomeScreen/homescreen.dart';
import 'package:healtether_clinic_app/Screens/HomeScreen/page_view_screen.dart';
import 'package:healtether_clinic_app/Screens/HomeScreen/patient_analysis.dart';
import 'package:healtether_clinic_app/Screens/ManageStaff/add_member_screen.dart';
import 'package:healtether_clinic_app/Screens/ManageStaff/manage_staff_screen.dart';
import 'package:healtether_clinic_app/Screens/Notification/screen/notifications_screen.dart';
import 'package:healtether_clinic_app/Screens/Onboarding/splash_screen.dart';
import 'package:healtether_clinic_app/Screens/Onboarding/onboarding_screen.dart';
import 'package:healtether_clinic_app/Screens/ScheduleAppointment/schedule_appointment_screen.dart';
import 'package:healtether_clinic_app/Screens/ScheduleAppointment/schedule_successfully_screen.dart';
import 'package:healtether_clinic_app/Screens/UserProfile/clinic_details_page.dart';
import 'package:healtether_clinic_app/Screens/UserProfile/my_clinics_setting.dart';
import 'package:healtether_clinic_app/Screens/UserProfile/payment_settings.dart';
import 'package:healtether_clinic_app/Screens/UserProfile/prescription_settings/prescription_layout.dart';
import 'package:healtether_clinic_app/Screens/UserProfile/prescription_settings/prescription_settings.dart';
import 'package:healtether_clinic_app/Screens/UserProfile/clinic_settings_page.dart';
import 'package:healtether_clinic_app/Screens/edit_profile/edit_profile.dart';
import 'package:healtether_clinic_app/Screens/loginpage/login_page.dart';
import 'package:healtether_clinic_app/Screens/loginpage/welcome.dart';
import 'package:healtether_clinic_app/Screens/patients_records/patient_record_screen.dart';
import 'package:healtether_clinic_app/Screens/patients_records/patients_records.dart';
import 'package:healtether_clinic_app/Screens/payment_records/payment_records.dart';
import 'package:healtether_clinic_app/Screens/payment_records/payments_receipt_screen.dart';
import 'package:healtether_clinic_app/Screens/payments/payment_receipt/payments_receipt_screen.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_models/appointment_model.dart';
import 'package:healtether_clinic_app/data_layer/models/drug_model/drug_model.dart';
import 'package:healtether_clinic_app/data_layer/models/history_item/history_item.dart';
import 'package:healtether_clinic_app/data_layer/models/lab_tests/lab_tests.dart';
// import 'package:healtether_clinic_app/data_layer/models/patient/patient_model.dart';
import 'package:healtether_clinic_app/data_layer/models/patient_records_model/patient_model.dart';
import 'package:healtether_clinic_app/data_layer/models/symptom_model/symptom.dart';
import 'package:healtether_clinic_app/data_layer/models/user_model/user_model.dart';
// import 'package:healtether_clinic_app/data_layer/models/user_model/user_model.dart';
import 'package:healtether_clinic_app/data_layer/models/vitals_model.dart/vital.dart';
import 'package:healtether_clinic_app/utils/enums/enums.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';
import 'package:healtether_clinic_app/Screens/ChatScreen/chat_detailes_screen.dart';
import 'package:healtether_clinic_app/data_layer/services/shared_preferences_service.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:healtether_clinic_app/Screens/edit_profile/add_members_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final routerConfig = AppRouterConfig();

class AppRouterConfig {
  //final staffCubit = StaffCubit();
  //final appointmentCubit = AppointmentCubit();
  //final paymentCubit = PaymentCubit();
  //final homePageBottomNavCubit = HomePageBottomNavCubit();
  //final patientRecordsCubit = PatientRecordsCubit();
  // final userBloc = UserBloc();
  //final paymentsBloc = PaymentsBloc();
  //final settingsCubit = SettingsCubit();
  //final pastHistoryCubit = PastHistoryCubit();
  //final allergyCubit = AllergyCubit();
  //final vitalsCubit = VitalsCubit();
  //final labTestCubit = LabTestCubit();
  //final drugPrescriptionCubit = DrugPrescriptionCubit();
  // ServiceCubit serviceCubit;

  final router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      // initialLocation: '/home/symptoms-test',
      initialLocation: '/splash', //? original
      routes: [
        //? SPLASH;
        GoRoute(
            name: AppRoutes.splash.name,
            path: "/splash",
            builder: (context, state) {
              return const SplashScreen();
            }),

        //? ONBOARDING
        GoRoute(
            name: AppRoutes.onboarding.name,
            path: "/onboarding",
            builder: (context, state) {
              return const OnboardingScreen();
            }),

        //? LOGIN
        GoRoute(
            name: AppRoutes.login.name,
            path: "/login",
            builder: (context, state) {
              return const LoginPage();
            }),

        //? WELCOME
        GoRoute(
            name: AppRoutes.welcome.name,
            path: "/welcome",
            builder: (context, state) {
              return const Welcome();
            }),
        //! TEST SCREENS

        //!__________________________________________________________________

        //? HOME PAGE VIEW
        StatefulShellRoute.indexedStack(builder: (context, state, navigationShell) => HomePageView(shell: navigationShell), branches: [
          //? HOMESCREEN
          StatefulShellBranch(routes: [
            GoRoute(
                name: AppRoutes.homePageView.name,
                path: "/home",
                builder: (context, state) {
                  return const HomeScreen();
                },
                routes: [
                  // sub-routes for home

                  //? SCHEDULE APPOINTMENT
                  GoRoute(
                      name: AppRoutes.scheduleAppointment.name,
                      path: "schedule-appointment",
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        return const ScheduleAppointmentScreen();
                      }),

                  //? APPOINTMENT SUCCESS
                  GoRoute(
                      name: AppRoutes.appointmentSuccess.name,
                      path: "appointment-success",
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        final params = state.extra as Map;
                        return ScheduleSuccessfullyScreen(appointmentDetails: params);
                      }),

                  //? PAST MEDICAL HISTORY
                  GoRoute(
                      name: AppRoutes.pastMedicalHistory.name,
                      path: "past-medical-history",
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        final Map data = state.extra as Map;
                        return PastMedicalHistoryScreen(
                          appointment: data['appointment'] as Appointment,
                          pastHistory: List<HistoryItem>.from(data['pastHistory']),
                          familyHistory: List<HistoryItem>.from(data['familyHistory']),
                          pastProcedures: List<HistoryItem>.from(data['pastProcedures']),
                          allergies: List<HistoryItem>.from(data['allergies']),
                          medicationHistory: List<HistoryItem>.from(data['medicalHistory']),
                        );
                      }),

                  //? PAST HISTORY
                  /* GoRoute(
                      name: AppRoutes.pastHistoryScreen.name,
                      path: "past-history",
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        final params = state.extra as Map<String, dynamic>;
                        return PastHistoryScreen(userId: params['userId']!, appointmentId: params['appointmentId']);
                      }),*/

                  //? SAVE PAST HISTORY
                  /*  GoRoute(
                          name: AppRoutes.savePastHistoryScreen.name,
                          path: "save-past-history",
                          parentNavigatorKey: _rootNavigatorKey,
                          builder: (context, state) {
                            return const SavePastHistoryScreen();
                          }),*/

                  //? FAMILY HISTORY
                  GoRoute(
                      name: AppRoutes.familyHistory.name,
                      path: "family-history",
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        return const FamilyHistoryScreen();
                      }),

                  //? SAVE FAMILY HISTORY
                  /* GoRoute(
                          name: AppRoutes.saveFamilyHistory.name,
                          path: "save-family-history",
                          parentNavigatorKey: _rootNavigatorKey,
                          builder: (context, state) {
                            return const SaveFamilyHistoryScreen();
                          }),*/

                  //? PAST MEDICAL PROCEDURES
                  /* GoRoute(
                      name: AppRoutes.pastMedicalProcedures.name,
                      path: "past-medical-procedures",
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        return const PastMedicalProcedures();
                      }),*/

                  //? SAVE PAST MEDICAL PROCEDURES
                  /*  GoRoute(
                          name: AppRoutes.savePastMedicalProcedures.name,
                          path: "save-past-medical-procedures",
                          parentNavigatorKey: _rootNavigatorKey,
                          builder: (context, state) {
                            return const SavePastMedicalProceduresScreen();
                          }),*/

                  //? ALLERGYSCREEN
                  GoRoute(
                      name: AppRoutes.allergy.name,
                      path: "allergy",
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        return const PatientSufferingFromAllergiesScreen();
                      }),

                  //? SAVE ALLERGYSCREEN
                  /* GoRoute(
                          name: AppRoutes.saveAllergy.name,
                          path: "save-allergy",
                          parentNavigatorKey: _rootNavigatorKey,
                          builder: (context, state) {
                            return const SavePatientSufferingFromAllergiesScreen();
                          }),*/

                  //? MEDICATION HISTORY
                  GoRoute(
                      name: AppRoutes.medicationHistory.name,
                      path: "medication-history",
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        return const MedicationHistoryScreen();
                      }),

                  //? SAVE MEDICATION HISTORY
                  /*  GoRoute(
                          name: AppRoutes.saveMedicationHistory.name,
                          path: "save-medication-history",
                          parentNavigatorKey: _rootNavigatorKey,
                          builder: (context, state) {
                            return const SaveMedicationHistoryScreen();
                          }),*/

                  //? WRITE PRESCRIPTION
                  GoRoute(
                      name: AppRoutes.writePrescription.name,
                      path: "write-prescription",
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        return DigitalScreen(
                          appointment: state.extra as Appointment,
                        );
                      }),

                  //? DRUG PRESCRIPTION & FOLLOW-UP
                  GoRoute(
                      name: AppRoutes.drugPrescription.name,
                      path: "drug-prescription",
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        final Map data = state.extra as Map;
                        return DigitalPrecriptionScreen(
                          appointment: data['appointment'] as Appointment,
                          selectedDrugs: data['drugs'] != null ? List<Drug>.from(data['drugs']) : null,
                        );
                      }),

                  /* //? VITALS GENERAL SCREEN
                  GoRoute(
                      name: AppRoutes.vitalsGeneral.name,
                      path: "vitals-general",
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        return const VitalsGeneralScreen();
                      }),*/

                  //? VITALS SCREEN
                  GoRoute(
                      name: AppRoutes.vitals.name,
                      path: "vitals",
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        final Map data = state.extra as Map;
                        return VitalsScreen(
                          appointment: data['appointment'] as Appointment,
                          vitals: List<Vital>.from(data['vitals']),
                        );
                      },
                      routes: [
                        GoRoute(
                            name: AppRoutes.personalHistory.name,
                            path: "personal-history",
                            parentNavigatorKey: _rootNavigatorKey,
                            builder: (context, state) {
                              return const PersonalHistoryScreen();
                            }),
                      ]),

                  //? OTHER VITALS
                  GoRoute(
                      name: AppRoutes.otherVitals.name,
                      path: "other-vitals/:appointmentId",
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        final List<Vital>? vitals = state.extra as List<Vital>?;
                        return OtherVitalsScreen(
                          vitals: vitals,
                          appointmentId: state.pathParameters['appointmentId']!,
                        );
                      }),

                  //? LAB TESTS
                  GoRoute(
                    name: AppRoutes.labInvestigations.name,
                    path: "lab-investigation",
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) {
                      final Map data = state.extra as Map;
                      return LabInvestigationsScreen(
                        appointment: data['appointment'] as Appointment,
                        selectedTests: data['labTests'] != null ? List<LabTest>.from(data['labTests']) : null,
                      );
                    },
                  ),

                  //? CREATE DIGITAL PRESCRIPTION
                  GoRoute(
                    name: AppRoutes.createDigitalPrescription.name,
                    path: "create-digital-prescription",
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) {
                      final Map data = state.extra as Map;
                      return CreateDigitalPrescriptionScreens(
                        appointment: data['appointment'] as Appointment,
                        selectedSymptoms: data['symptoms'] != null ? Set<Symptom>.from(data['symptoms']) : null,
                        selectedDiagnosis: data['diagnosis'] != null ? Set<Symptom>.from(data['diagnosis']) : null,
                      );
                    },
                  ),

                  /*GoRoute(
                          name: AppRoutes.createDigitalPrescriptionScreen.name,
                          path: "create-digital-prescription-screen",
                          parentNavigatorKey: _rootNavigatorKey,
                          builder: (context, state) {
                            final Map<String, dynamic> params =
                                state.extra as Map<String, dynamic>;

                            return CreateDigitalPrescriptionScreen(
                              symptoms: params['symptoms'],
                              timePeriod: params['timePeriod'],
                              duration: params['duration'],
                            );
                          }),*/

                  //? PAYMENT RECEIPT SCREEN
                  GoRoute(
                      name: AppRoutes.paymentReceiptScreen.name,
                      path: "payments-reciept-screen",
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        return const PaymentsReceiptScreen();
                      }),

                  //? PAYMENT RECEIPT
                  GoRoute(
                      name: AppRoutes.paymentReceipt.name,
                      path: "payments-reciept",
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        return const PaymentsReceipt();
                      }),

                  //? PRESCRIPTION PREVIEW
                  GoRoute(
                      name: AppRoutes.prescriptionPreview.name,
                      path: "prescription-preview",
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        return const PrescriptionPreview();
                      }),

                  //? DRAWER
                  GoRoute(
                      name: AppRoutes.drawer.name,
                      path: "drawer",
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        return const Drawer(
                          child: DrawerMenu(),
                        );
                      },
                      routes: const [
                        // subroutes already defined as top-level
                        // routes so they'll be accessed using
                        // context.pushNamed not context.goNamed
                      ]),

                  //? MANAGE STAFF
                  GoRoute(
                      name: AppRoutes.manageStaff.name,
                      path: "manage-staff",
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        return const ManageStaffScreen();
                      },
                      routes: [
                        // sub-routes for manage staff
                        GoRoute(
                          name: AppRoutes.addMemberScreen.name,
                          path: "add-member",
                          builder: (context, state) {
                            final bool isAdmin = state.extra as bool;
                            return AddMemberScreen(isAdmin: isAdmin);
                          },
                        )
                      ]),

                  //? EDIT PROFILE
                  GoRoute(
                      name: AppRoutes.editProfile.name,
                      path: "edit-profile",
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        return const EditProfiles();
                      }),

                  //? PATIENT RECORDS
                  GoRoute(
                      name: AppRoutes.patientRecords.name,
                      path: "patient-records",
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        return const PatientRecords();
                      },
                      routes: [
                        //? ADD MEMBERS
                        GoRoute(
                            name: AppRoutes.addMembersScreen.name,
                            path: "add-members-screen",
                            parentNavigatorKey: _rootNavigatorKey,
                            builder: (context, state) {
                              return const AddMembersScreen();
                            }),

                        GoRoute(
                            name: AppRoutes.patientRecordsScreen.name,
                            path: "patient-records-screen",
                            parentNavigatorKey: _rootNavigatorKey,
                            builder: (context, state) {
                              final patient = state.extra as PatientOverviewModel;
                              return PatientRecordsScreen(
                                patient: patient,
                              );
                            }),
                      ]),
                  GoRoute(
                      name: AppRoutes.paymentRecords.name,
                      path: "payment-records",
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        return const PaymentsRecordScreen();
                      }),
                  GoRoute(
                      name: AppRoutes.patientAnalysis.name,
                      path: "patient-analysis",
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        return const PatientAnalysis();
                      }),

                  //? FEEDBACK
                  GoRoute(
                      name: AppRoutes.feedBack.name,
                      path: "feedback",
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        return const FeedBackPage();
                      }),

                  //? SETTINGS
                  GoRoute(
                      name: AppRoutes.myClinicsSetting.name,
                      parentNavigatorKey: _rootNavigatorKey,
                      path: "my-clinics-setting",
                      builder: (context, state) {
                        return const MyClinicsSetting();
                      },
                      routes: [
                        GoRoute(
                            name: AppRoutes.addClinic.name,
                            parentNavigatorKey: _rootNavigatorKey,
                            path: "add-clinic",
                            builder: (context, state) {
                              return const ClinicDetails();
                            }),
                        GoRoute(
                            name: AppRoutes.clinicSettings.name,
                            parentNavigatorKey: _rootNavigatorKey,
                            path: "clinic-settings",
                            builder: (context, state) {
                              final Map<String, dynamic> selectedClinic = state.extra as Map<String, dynamic>;
                              return ClinicSettings(
                                selectedClinic: selectedClinic,
                              );
                            },
                            routes: [
                              //? CLINIC SETTINGS
                              GoRoute(
                                  name: AppRoutes.clinicDetails.name,
                                  path: "clinic-details",
                                  parentNavigatorKey: _rootNavigatorKey,
                                  builder: (context, state) {
                                    final Map<String, dynamic>? selectedClinic = state.extra as Map<String, dynamic>?;
                                    return ClinicDetails(selectedClinic: selectedClinic);
                                  }),

                              /* //? CLINIC DETAILS
                                  GoRoute(
                                      name: AppRoutes.clinicSettings.name,
                                      path: "clinic-settings",
                                      parentNavigatorKey: _rootNavigatorKey,
                                      builder: (context, state) {
                                        return const ClinicSettings();
                                      }),*/

                              //? APPOINTMENT SETTINGS
                              /* GoRoute(
                                      name: AppRoutes.appointmentSettings.name,
                                      path: "appointment-settings",
                                      parentNavigatorKey: _rootNavigatorKey,
                                      builder: (context, state) {
                                        return const AppointmentSettings();
                                      }),*/

                              //? PAYMENT SETTINGS
                              GoRoute(
                                  name: AppRoutes.paymentSettings.name,
                                  path: "payment-settings",
                                  parentNavigatorKey: _rootNavigatorKey,
                                  builder: (context, state) {
                                    return const PaymentSettings();
                                  }),

                              //? NOTIFICATION SETTINGS
                              /* GoRoute(
                                  name: AppRoutes.notificationsSettings.name,
                                  path: "notification-settings",
                                  parentNavigatorKey: _rootNavigatorKey,
                                  builder: (context, state) {
                                    return const NotificationSettings();
                                  }),*/

                              //? PERMISSIONS SETTINGS
                              /* GoRoute(
                                  name: AppRoutes.appPermissionsSettings.name,
                                  path: "app-permissions-settings",
                                  parentNavigatorKey: _rootNavigatorKey,
                                  builder: (context, state) {
                                    return const PermissionsSettings();
                                  }),*/

                              //! PRESCRIPTION SETTINGS
                              GoRoute(
                                  name: AppRoutes.prescriptionSettings.name,
                                  path: "prescription-settings",
                                  parentNavigatorKey: _rootNavigatorKey,
                                  builder: (context, state) {
                                    return const PrescriptionSettings();
                                  },
                                  routes: [
                                    GoRoute(
                                        name: AppRoutes.prescriptionLayout.name,
                                        path: "prescription-layout",
                                        parentNavigatorKey: _rootNavigatorKey,
                                        builder: (context, state) {
                                          return PrescriptionLayout(
                                            template: (state.extra ?? PrescriptionTemplates.template_1) as PrescriptionTemplates,
                                          );
                                        }),
                                  ])
                            ]),
                      ]),
                ]),
          ]),

          //? APPOINTMENT
          StatefulShellBranch(routes: [
            GoRoute(
                name: AppRoutes.appointment.name,
                path: "/appointment",
                builder: (context, state) {
                  return const AppointmentScreen();
                },
                routes: [
                  GoRoute(
                      name: AppRoutes.appointmentDetail.name,
                      path: "appointment-detail",
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        final Appointment appointment = state.extra as Appointment;
                        return AppointmentDetail(
                          appointment: appointment,
                        );
                      })
                ]),
          ]),

          //? CHAT
          StatefulShellBranch(routes: [
            GoRoute(
                name: AppRoutes.chat.name,
                path: "/chat",
                builder: (context, state) {
                  return const ChatScreen();
                },
                routes: [
                  GoRoute(
                      name: AppRoutes.chatDetails.name,
                      parentNavigatorKey: _rootNavigatorKey,
                      path: 'chat-details',
                      builder: (context, state) {
                        return const ChatDetailScreen();
                      })
                ]),
          ]),

          //? NOTIFICATION
          StatefulShellBranch(routes: [
            GoRoute(
                name: AppRoutes.notification.name,
                path: "/notification",
                builder: (context, state) {
                  return const NotificationScreen();
                }),
          ])
        ])
      ],
      redirect: (context, state) async {
        final String currentLocation = state.matchedLocation;

        String? token = await SharedPrefService.getAccessToken();
        UserModel? user = await UserModel.getCurrentUser();
        bool isExpired = token != null ? JwtDecoder.isExpired(token) : true;

        bool isLoggedIn = token != null && user != null && !isExpired;
        log("ROUTER_REDIRECT");
        log("TOKEN $token");
        log("USER ${user?.firstName ?? ''} ${user?.lastName ?? ''}");
        log("IS_TOKEN_EXPIRED $isExpired");
        log("IS_USER_LOGGEDIN $isLoggedIn");
        log("CURRENT_NAV_LOCATION: $currentLocation");

        if (currentLocation == '/onboarding' && isLoggedIn == true) {
          log("\n::: \nUser is logged in so redirecting to home\n::: ");
          return '/home'; //? original
          // return '/appointment/appointment-detail';
        } else if (currentLocation.startsWith('/home') && isLoggedIn == false) {
          return '/login';
        }

        log("NAVIGATING TO: $currentLocation");

        return null;
      });
}
