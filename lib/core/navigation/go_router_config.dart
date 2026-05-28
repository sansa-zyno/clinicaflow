import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:clinica_flow/features/appointment/view/appointment_detail.dart';
import 'package:clinica_flow/features/appointment/view/appointment_screen.dart';
import 'package:clinica_flow/features/chat/view/chat_screen.dart';
import 'package:clinica_flow/features/medication/view/digital_precription_screen.dart';
import 'package:clinica_flow/features/lab_test/view/lab_investigations_screen.dart';
import 'package:clinica_flow/features/prescription/view/prescription_preview.dart';
import 'package:clinica_flow/features/vitals/view/vitals_screen.dart';
import 'package:clinica_flow/shared/ui/digital_screen.dart';
import 'package:clinica_flow/features/symptoms_diagnosis/view/create_digital_prescription_screens.dart';
import 'package:clinica_flow/features/past_medical_history/view/past_medical_history_screen.dart';
import 'package:clinica_flow/features/home/drawer_menu.dart';
import 'package:clinica_flow/shared/ui/feedback_page.dart';
import 'package:clinica_flow/features/home/homescreen.dart';
import 'package:clinica_flow/core/navigation/page_view_screen.dart';
import 'package:clinica_flow/features/analytics/view/patient_analysis.dart';
import 'package:clinica_flow/features/team/view/manage_team_screen.dart';
import 'package:clinica_flow/features/notification/view/notifications_screen.dart';
import 'package:clinica_flow/features/onboarding/view/onboarding_screen.dart';
import 'package:clinica_flow/features/appointment/view/schedule_appointment_screen.dart';
import 'package:clinica_flow/features/appointment/view/schedule_successfully_screen.dart';
import 'package:clinica_flow/features/profile/view/clinic_details_page.dart';
import 'package:clinica_flow/features/profile/view/my_clinics_setting.dart';
import 'package:clinica_flow/features/profile/view/payment_settings.dart';
import 'package:clinica_flow/features/profile/view/prescription_layout.dart';
import 'package:clinica_flow/features/profile/view/prescription_settings.dart';
import 'package:clinica_flow/features/profile/view/clinic_settings_page.dart';
import 'package:clinica_flow/features/auth/view/forgot_password.dart';
import 'package:clinica_flow/features/auth/view/login_page.dart';
import 'package:clinica_flow/features/auth/view/welcome.dart';
import 'package:clinica_flow/features/patient/view/patient_record_screen.dart';
import 'package:clinica_flow/features/patient/view/patients_records.dart';
import 'package:clinica_flow/features/payment/view/payInCash_success_screen.dart';
import 'package:clinica_flow/features/payment/view/payment_records.dart';
import 'package:clinica_flow/features/payment/view/payments_receipt_screen.dart';
import 'package:clinica_flow/features/payment/view/payments_receipt_invoice_screen.dart';
import 'package:clinica_flow/features/appointment/model/appointment_model.dart';
import 'package:clinica_flow/features/past_medical_history/model/history_item.dart';
import 'package:clinica_flow/features/payment/model/invoice.dart'
    hide Appointment;
import 'package:clinica_flow/features/lab_test/model/lab_tests.dart';
import 'package:clinica_flow/features/prescription/model/prescription_report.dart';
import 'package:clinica_flow/features/symptoms_diagnosis/model/symptom.dart';
import 'package:clinica_flow/features/auth/model/user_model.dart';
import 'package:clinica_flow/features/vitals/model/vital.dart';
import 'package:clinica_flow/core/utils/enums/enums.dart';
import 'package:clinica_flow/core/utils/enums/route_enums.dart';
import 'package:clinica_flow/core/utils/helper_functions/log.dart';
import 'package:clinica_flow/features/chat/view/chat_detailes_screen.dart';

import '../../features/patient/model/patient_model.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final routerConfig = AppRouterConfig();

class AppRouterConfig {
  final router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      //initialLocation: '/splash', //? original
      initialLocation: '/onboarding', //? original
      routes: [
        //? SPLASH;
        /*GoRoute(
            name: AppRoutes.splash.name,
            path: "/splash",
            builder: (context, state) {
              return const SplashScreen();
            }),*/

        //? ONBOARDING
        GoRoute(
            name: AppRoutes.onboarding.name,
            path: "/onboarding",
            builder: (context, state) {
              return const OnBoardingScreen();
            }),

        //? LOGIN
        GoRoute(
            name: AppRoutes.login.name,
            path: "/login",
            builder: (context, state) {
              return const LoginPage();
            }),

        //? FORGOT PASSWORD
        GoRoute(
            name: AppRoutes.forgotPassword.name,
            path: "/forgot-password",
            builder: (context, state) {
              return const ForgotPassword();
            }),

        //? WELCOME
        GoRoute(
            name: AppRoutes.welcome.name,
            path: "/welcome",
            builder: (context, state) {
              return const Welcome();
            }),

        //? HOME PAGE VIEW
        StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) =>
                HomePageView(shell: navigationShell),
            branches: [
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
                            final appointment = state.extra as Appointment;
                            return ScheduleSuccessfullyScreen(
                                appointment: appointment);
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
                              pastHistory: data['pastHistory'] != null
                                  ? List<HistoryItem>.from(data['pastHistory'])
                                  : null,
                              familyHistory: data['familyHistory'] != null
                                  ? List<HistoryItem>.from(
                                      data['familyHistory'])
                                  : null,
                              pastProcedureHistory:
                                  data['pastProcedureHistory'] != null
                                      ? List<HistoryItem>.from(
                                          data['pastProcedureHistory'])
                                      : null,
                              allergies: data['allergies'] != null
                                  ? List<HistoryItem>.from(data['allergies'])
                                  : null,
                              medication: data['medication'] != null
                                  ? List<HistoryItem>.from(data['medication'])
                                  : null,
                            );
                          }),

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
                              savedDrugPrescription:
                                  data['savedDrugPrescription'] != null
                                      ? Map<String, dynamic>.from(
                                          data['savedDrugPrescription'])
                                      : null,
                            );
                          }),

                      //? VITALS SCREEN
                      GoRoute(
                        name: AppRoutes.vitals.name,
                        path: "vitals",
                        parentNavigatorKey: _rootNavigatorKey,
                        builder: (context, state) {
                          final Map data = state.extra as Map;
                          return VitalsScreen(
                            appointment: data['appointment'] as Appointment,
                            vitals: data['vitals'] as Vital?,
                          );
                        },
                      ),

                      //? OTHER VITALS
                      /* GoRoute(
                      name: AppRoutes.otherVitals.name,
                      path: "other-vitals/:appointmentId",
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        final List<Vital>? vitals = state.extra as List<Vital>?;
                        return OtherVitalsScreen(
                          vitals: vitals,
                          appointmentId: state.pathParameters['appointmentId']!,
                        );
                      }),*/

                      //? LAB TESTS
                      GoRoute(
                        name: AppRoutes.labInvestigations.name,
                        path: "lab-investigation",
                        parentNavigatorKey: _rootNavigatorKey,
                        builder: (context, state) {
                          final Map data = state.extra as Map;
                          return LabInvestigationsScreen(
                            appointment: data['appointment'] as Appointment,
                            selectedTests: data['labTests'] != null
                                ? List<LabTest>.from(data['labTests'])
                                : null,
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
                            selectedSymptoms: data['symptoms'] != null
                                ? Set<Symptom>.from(data['symptoms'])
                                : null,
                            selectedDiagnosis: data['diagnosis'] != null
                                ? Set<Symptom>.from(data['diagnosis'])
                                : null,
                          );
                        },
                      ),

                      //? PAYMENT RECEIPT SCREEN
                      GoRoute(
                          name: AppRoutes.paymentReceiptScreen.name,
                          path: "payments-reciept-screen",
                          parentNavigatorKey: _rootNavigatorKey,
                          builder: (context, state) {
                            final String invoiceId = state.extra as String;
                            return PaymentsReceiptScreen(invoiceId: invoiceId);
                          }),

                      //? PAYMENT INVOICE
                      GoRoute(
                          name: AppRoutes.paymentReceiptInvoice.name,
                          path: "payments-reciept-invoice",
                          parentNavigatorKey: _rootNavigatorKey,
                          builder: (context, state) {
                            return const PaymentsReceiptInvoice();
                          }),

                      //? PAYINCASH SUCCESS
                      GoRoute(
                          name: AppRoutes.payInCashSuccess.name,
                          path: "pay-in-cash-success",
                          parentNavigatorKey: _rootNavigatorKey,
                          builder: (context, state) {
                            final Invoice invoiceDetails =
                                state.extra as Invoice;
                            return PayInCashSuccessScreen(
                                invoiceDetails: invoiceDetails);
                          }),

                      //? PRESCRIPTION PREVIEW
                      GoRoute(
                          name: AppRoutes.prescriptionPreview.name,
                          path: "prescription-preview",
                          parentNavigatorKey: _rootNavigatorKey,
                          builder: (context, state) {
                            final Map data = state.extra as Map;
                            return PrescriptionPreview(
                              prescriptionReport: data['prescriptionReport']
                                  as PrescriptionReport,
                            );
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
                            return const ManageTeamScreen();
                          },
                          routes: []),

                      //? PATIENT RECORDS
                      GoRoute(
                          name: AppRoutes.patientRecords.name,
                          path: "patient-records",
                          parentNavigatorKey: _rootNavigatorKey,
                          builder: (context, state) {
                            return const PatientRecords();
                          },
                          routes: [
                            GoRoute(
                                name: AppRoutes.patientRecordsScreen.name,
                                path: "patient-records-screen",
                                parentNavigatorKey: _rootNavigatorKey,
                                builder: (context, state) {
                                  final patient = state.extra as PatientModel;
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
                                  final Map<String, dynamic> selectedClinic =
                                      state.extra as Map<String, dynamic>;
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
                                        final Map<String, dynamic>?
                                            selectedClinic = state.extra
                                                as Map<String, dynamic>?;
                                        return ClinicDetails(
                                            selectedClinic: selectedClinic);
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
                                            name: AppRoutes
                                                .prescriptionLayout.name,
                                            path: "prescription-layout",
                                            parentNavigatorKey:
                                                _rootNavigatorKey,
                                            builder: (context, state) {
                                              return PrescriptionLayout(
                                                template: (state.extra ??
                                                        PrescriptionTemplates
                                                            .template_1)
                                                    as PrescriptionTemplates,
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
                            final String id = state.extra as String;
                            return AppointmentDetail(
                              id: id,
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

        UserModel? user = await UserModel.getCurrentUser();
        //String? token = await SharedPrefService.getAccessToken();
        //bool isExpired = token != null ? JwtDecoder.isExpired(token) : true;
        // bool isLoggedIn = token != null && user != null && !isExpired;
        bool isLoggedIn = user != null;

        if (currentLocation == '/onboarding' && isLoggedIn == true) {
          return '/home';
        } else if (currentLocation.startsWith('/home') && isLoggedIn == false) {
          return '/login';
        }

        log("NAVIGATING TO: $currentLocation");

        return null;
      });
}
