import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clinica_flow/features/appointment/bloc/appointment_bloc.dart';
import 'package:clinica_flow/shared/widgets/custom_textfield.dart';
import 'package:clinica_flow/features/analytics/view/payment_analysis.dart';
import 'package:clinica_flow/features/analytics/viewmodel/age_cubit.dart';
import 'package:clinica_flow/features/analytics/state/age_state.dart';
import 'package:clinica_flow/features/analytics/viewmodel/gender_ratio_cubit.dart';
import 'package:clinica_flow/features/analytics/state/gender_ratio_state.dart';
import 'package:clinica_flow/features/analytics/viewmodel/patient_ratio_cubit.dart';
import 'package:clinica_flow/features/analytics/state/patient_ratio_state.dart';
import 'package:clinica_flow/features/analytics/model/patient_age_model.dart';
import 'package:clinica_flow/features/analytics/model/patient_ratio_custom_model.dart';
import 'package:clinica_flow/features/analytics/model/patient_ratio_monthly_model.dart';
import 'package:clinica_flow/features/analytics/model/patient_ratio_weekly_model.dart';
import 'package:clinica_flow/features/analytics/service/analytics_service.dart';
import 'package:clinica_flow/shared/widgets/piechart_card.dart';
import '../../appointment/bloc/appointment_event.dart';
import 'package:clinica_flow/shared/widgets/text_list_tile.dart';
import 'package:go_router/go_router.dart';
import 'package:clinica_flow/shared/widgets/section_text.dart';
import 'package:clinica_flow/core/utils/extensions.dart/widget_extensions.dart';

import '../../../core/constants/app_colors.dart';
import 'widget/bar_chart_card.dart';

/*final AppointmentService appointmentService = AppointmentService(
  "https://9316dbec-7490-466d-bc74-5e4bb14eefc2.mock.pstmn.io/",
);*/

class PatientAnalysis extends StatefulWidget {
  const PatientAnalysis({super.key});

  @override
  State<PatientAnalysis> createState() => _PatientAnalysisState();
}

class _PatientAnalysisState extends State<PatientAnalysis> {
  late final AppointmentBloc _appointmentBloc;
  String selectedAnalysis = 'Patients Analysis';
  String selectedDate = 'Today';
  int selectedVal = 1;
  DateTime? _firstDate;
  DateTime? _lastDate;
  final List<String> items = [
    'Patients Analysis',
    'Appointments Analysis',
  ];
  final List<String> dateOptions = ['Today', 'Monthly', 'Weekly', 'Custom'];
  String containerText = 'kimjones@ybl';
  TextEditingController additionalAnotherNumberController =
      TextEditingController();

  bool showAnotherNumber = false;

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: containerText));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied!'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _appointmentBloc = AppointmentBloc(AnalyticsService());
    _appointmentBloc.add(FetchDataEvent());
  }

  @override
  void dispose() {
    _appointmentBloc.close();
    super.dispose();
  }

  String formatDate(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> weeklyBody = {
      // 3
      "type": "weekly",
      "clinicId": "662ca0a41a2431e16c41ebaa"
    };
    Map<String, String> todayBody = {
      // 1
      "startDate": formatDate(
        DateTime(DateTime.now().year, DateTime.now().day, 6),
      ),
      "endDate":
          formatDate(DateTime(DateTime.now().year, DateTime.now().day, 22)),
      "clinicId": "662ca0a41a2431e16c41ebaa"
    };
    Map<String, String> monthlyBody = {
      // 2
      "type": "monthly",
      "clinicId": "662ca0a41a2431e16c41ebaa"
    };
    Map<String, String> customBody = {
      // 4
      "startDate": formatDate(_firstDate ?? DateTime.now()),
      "endDate": formatDate(_lastDate ?? DateTime.now()),
      "clinicId": "662ca0a41a2431e16c41ebaa"
    };
    Map<String, String>? finalBody;
    if (selectedDate == 'Today') finalBody = todayBody;
    if (selectedDate == 'Monthly') finalBody = monthlyBody;
    if (selectedDate == 'Weekly') finalBody = weeklyBody;
    if (selectedDate == 'Custom') finalBody = customBody;
    BlocProvider.of<PatientRatioCubit>(context).fetch(finalBody!, selectedVal);
    BlocProvider.of<PatientGenderRatioCubit>(context)
        .fetch(finalBody, selectedVal);
    BlocProvider.of<AgeRatioCubit>(context).fetch(finalBody);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
            Text(
              ' Analytics',
              style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 15, right: 15),
              child: GestureDetector(
                onTap: () {
                  showSwitchClinicsBottomSheet(context);
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xffF5F5F5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedAnalysis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_down_outlined),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            _buildSelectedAnalysis(),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedAnalysis() {
    switch (selectedAnalysis) {
      case 'Patients Analysis':
        return _buildPatientsAnalysis();
      case 'Appointments Analysis':
        return _buildAppointmentsAnalysis();
      case 'Payments Analysis':
        return _buildPaymentsAnalysis();
      default:
        return Container();
    }
  }

  Widget _buildPatientsAnalysis() {
    return Column(
      children: [
        SizedBox(
          height: 48,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 6),
            children: [
              DateCards(
                isSelected: selectedDate == 'Today',
                onTap: () {
                  setState(() {
                    selectedDate = 'Today';
                    selectedVal = 1;
                  });
                },
                text: 'Today',
              ),
              DateCards(
                isSelected: selectedDate == 'Monthly',
                onTap: () {
                  setState(() {
                    selectedDate = 'Monthly';
                    selectedVal = 2;
                  });
                },
                text: 'Monthly',
              ),
              DateCards(
                isSelected: selectedDate == 'Weekly',
                onTap: () {
                  setState(() {
                    selectedDate = 'Weekly';
                    selectedVal = 3;
                  });
                },
                text: 'Weekly',
              ),
              DateCards(
                isSelected: selectedDate == 'Custom',
                onTap: () async {
                  var dates = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2024),
                      lastDate: DateTime.now());
                  setState(() {
                    _firstDate = dates!.start;
                    _lastDate = dates.end;
                    selectedDate = 'Custom';
                    selectedVal = 4;
                  });
                },
                text: 'Custom',
              ),
            ],
          ),
        ),
        const SizedBox(height: 44),
        BlocBuilder<PatientRatioCubit, PatientRatioState>(
            builder: (context, state) {
          if (state is PatinetRatioLoadingState) {
            return const Center(
                // child: CircularProgressIndicator(
                //   color: Color(0xff44B092),
                // ),
                );
          }
          var data;
          if (selectedDate == "Weekly") data as List<PatientRatioWeeklyModel>?;
          if (selectedDate == "Today") data as List<PatientRatioCustomModel>?;
          if (selectedDate == "Monthly") {
            data as List<PatientRatioMonthlyModel>?;
          }
          if (selectedDate == "Custom") {
            data as List<PatientRatioCustomModel>?;
          }
          if (state is PatinetRatioLoadedState) {
            data = state.data;
          }
          double repeatedPatients = 0;
          double newPatients = 0;
          for (int i = 0; i < data!.length; i++) {
            repeatedPatients += data[i].repeatedPatients!;
            newPatients += data[i].newPatients!;
          }
          print(repeatedPatients);
          print(newPatients);
          return PieChartCard(
            paddingvalue: 0,
            degree: 100,
            text: 'Patients Ratio',
            dataMap: {
              'Repeated patients': repeatedPatients,
              'New patients': newPatients
            },
            colorList: const [
              Color(0xff85F8D5),
              Color(0xff205C4C),
            ],
          );
        }),
        const SizedBox(height: 28),
        BlocBuilder<PatientGenderRatioCubit, PatientGenderRatioState>(
            builder: (context, state) {
          if (state is PatinetGenderRatioLoadingState) {
            return const Center(
                // child: CircularProgressIndicator(
                //   color: Color(0xff44B092),
                // ),
                );
          }
          List<int>? data;
          if (state is PatinetGenderRatioLoadedState) {
            data = state.data;
          }

          print("GENDER DATA + $data");
          return PieChartCard(
            paddingvalue: 60,
            degree: 100,
            text: 'Gender Ratio',
            dataMap: {
              'Other': data![2].toDouble(),
              'Female': data[1].toDouble(),
              'Male': data[0].toDouble()
            },
            colorList: const [
              Color(0xffe205C4C),
              Color(0xff85F8D5),
              Color(0xff44B092),
            ],
          );
        }),
        const SizedBox(height: 28),
        BlocBuilder<AgeRatioCubit, PatientAgeState>(builder: (context, state) {
          if (state is PatinetAgeLoadingState) {
            return const Center(
                // child: CircularProgressIndicator(
                //   color: Color(0xff44B092),
                // ),
                );
          }
          List<PatientAgeModel>? data;
          if (state is PatinetAgeLoadedState) {
            data = state.data;
          }
          Map<String, double> ageGroupCounts = {};

          for (var item in data!) {
            ageGroupCounts[item.ageGroup!] = item.count!.toDouble();
          }
          print("AGE GROUP $ageGroupCounts");
          return buildBarChartCard(
            'Age group Analysis',
            ageGroupCounts,
            [
              const Color(0xff85F8D5),
              Colors.tealAccent,
              Colors.teal,
              const Color(0xff205C4C),
            ],
            25,
          );
        }),
      ],
    );
  }

  void showSwitchClinicsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(top: 16),
          width: double.maxFinite,
          // height: 280,
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SectionText('SELECT ANALYSIS').pSymmetric(),
                const SizedBox(
                  height: 9,
                ),
                TextListTile(
                    height: 58,
                    text: 'Patients Analysis',
                    padding: const EdgeInsets.only(left: 16),
                    onTap: () {
                      setState(() {
                        selectedAnalysis = 'Patients Analysis';
                        context.pop();
                      });
                    }).pOnly(bottom: 10),
                TextListTile(
                    height: 58,
                    text: 'Appointments Analysis',
                    padding: const EdgeInsets.only(left: 16),
                    onTap: () {
                      setState(() {
                        selectedAnalysis = 'Appointments Analysis';
                        Navigator.pop(context);
                      });
                    }).pOnly(bottom: 10),
              ],
            ).pAll(8),
          ),
        );
      },
    );
  }

  Widget _buildAppointmentsAnalysis() {
    return BlocBuilder<AppointmentBloc, AppointmentState>(
      bloc: _appointmentBloc,
      builder: (context, state) {
        if (state is AppointmentLoaded) {
          return SingleChildScrollView(
            child: Column(
              children: [
                buildDateOptions(),
                const SizedBox(height: 44),
                buildPieChartCard(
                    'Mode of consultation',
                    state.modeOfConsultationData,
                    const [
                      Color(0xff85F8D5),
                      Color(0xff205C4C),
                    ],
                    60,
                    0),
                buildPieChartCard(
                    'Appointments booking Analysis',
                    state.appointmentsBookingData,
                    const [Color(0xff85F8D5), Color(0xff205C4C)],
                    70,
                    0),
                buildPieChartCard(
                    'Appointments Analysis',
                    state.appointmentsAnalysisData,
                    const [
                      Color(0xff85F8D5),
                      Color(0xff205C4C),
                      Color(0xff44B092),
                    ],
                    120,
                    50),
              ],
            ),
          );
        } else if (state is AppointmentError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${state.errorMessage}'),
            ),
          );
        } else {
          // Loading state or initial state
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _buildPaymentsAnalysis() {
    final Size screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                DateCards(
                  isSelected: selectedDate == 'Today',
                  onTap: () {
                    setState(() {
                      selectedDate = 'Today';
                    });
                  },
                  text: 'Today',
                ),
                DateCards(
                  isSelected: selectedDate == 'Yearly',
                  onTap: () {
                    setState(() {
                      selectedDate = 'Yearly';
                    });
                  },
                  text: 'Yearly',
                ),
                DateCards(
                  isSelected: selectedDate == 'Monthly',
                  onTap: () {
                    setState(() {
                      selectedDate = 'Monthly';
                    });
                  },
                  text: 'Monthly',
                ),
                DateCards(
                  isSelected: selectedDate == 'Weekly',
                  onTap: () {
                    setState(() {
                      selectedDate = 'Weekly';
                    });
                  },
                  text: 'Weekly',
                ),
                DateCards(
                  isSelected: selectedDate == 'Custom',
                  onTap: () {
                    setState(() {
                      selectedDate = 'Custom';
                    });
                  },
                  text: 'Custom',
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 28,
          ),
          Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Container(
                height: 60,
                color: const Color(0xffF5F5F5),
                width: 220,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 18, bottom: 10, left: 10, right: 30),
                  child: Text(
                    containerText,
                    style: GoogleFonts.montserrat(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  _copyToClipboard();
                },
                child: Container(
                  height: 60,
                  width: 95,
                  decoration: BoxDecoration(
                    color: const Color(0xff32856E),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Copy',
                        style: GoogleFonts.montserrat(color: Colors.white),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      const Icon(
                        Icons.copy_outlined,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                if (showAnotherNumber) ...[
                  CustomTextField(
                    controller: additionalAnotherNumberController,
                    hintText: 'Additional another number',
                    height: 45,
                  ),
                  const SizedBox(height: 16),
                ],
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showAnotherNumber = true;
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: AppColors.blueViolet,
                          ),
                          Text(
                            'Add another number',
                            style: TextStyle(color: AppColors.blueViolet),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 2,
                          width: screenSize.width * 0.5,
                          color: AppColors.blueViolet,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RevenueCard(
                desc: 'Total revenue collected',
                amnt: '5.2',
                value: 'K',
              ),
              RevenueCard(
                desc: 'Total money deposited in Bank',
                amnt: '5',
                value: 'K',
              ),
            ],
          ),
          const PieChartCard(
            paddingvalue: 60,
            degree: -120,
            text: 'Mode of payments',
            dataMap: {'Cash': 10, 'Card': 32, 'UPI': 58},
            colorList: [
              Color(0xff205C4C),
              Color(0xff85F8D5),
              Color(0xff44B092)
            ],
          ),
          const SizedBox(
            height: 28,
          ),
          const PieChartCard(
            paddingvalue: 30,
            degree: 70,
            text: 'Payments Analysis',
            dataMap: {
              'Done': 90,
              'Pending': 10,
            },
            colorList: [
              Color(0xff85F8D5),
              Color(0xff205C4C),
            ],
          ),
          const SizedBox(
            height: 28,
          ),
        ],
      ),
    );
  }

  Widget buildDateOptions() {
    return SizedBox(
      height: 48,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        scrollDirection: Axis.horizontal,
        itemCount: dateOptions.length,
        itemBuilder: (context, index) {
          final dateOption = dateOptions[index];
          return DateCards(
            isSelected: selectedDate == dateOption,
            onTap: () {
              setState(() {
                selectedDate = dateOption;
              });
            },
            text: dateOption,
          );
        },
      ),
    );
  }

  Widget buildPieChartCard(String text, Map<String, double> dataMap,
      List<Color> colorList, double degree, double paddingValue) {
    if (dataMap.isNotEmpty) {
      return Column(
        children: [
          PieChartCard(
            paddingvalue: paddingValue,
            degree: degree,
            text: text,
            dataMap: dataMap,
            colorList: colorList,
          ),
          const SizedBox(height: 28),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget buildBarChartCard(String text, Map<String, double> dataMap,
      List<Color> colorList, double paddingValue) {
    if (dataMap.isNotEmpty) {
      return Column(
        children: [
          BarChartCard(
            paddingvalue: paddingValue,
            text: text,
            dataMap: dataMap,
            colorList: colorList,
          ),
          const SizedBox(height: 28),
        ],
      );
    } else {
      return Container();
    }
  }
}
