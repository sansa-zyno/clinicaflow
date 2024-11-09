/*import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/diabetics_screen.dart';
import 'package:healtether_clinic_app/data_layer/models/past_history/past_history.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';
import 'package:healtether_clinic_app/constants/app_text.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/data_layer/models/user_model/user_model.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/string_extensions.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';
import 'package:healtether_clinic_app/utils/mixins/ui_info_mixin.dart';
import 'package:healtether_clinic_app/widgets/components/my_circular_progress_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';

class PastHistoryScreen extends StatefulWidget {
  const PastHistoryScreen({Key? key, this.userId, this.appointmentId}) : super(key: key);
  final String? userId;
  final String? appointmentId;

  @override
  State<PastHistoryScreen> createState() => _PastHistoryScreenState();
}

class _PastHistoryScreenState extends State<PastHistoryScreen> with UiInfoMixin {
  final Set<PastHistory> _selectedDiseases = {};
  bool isSelected = false;
  String? diseaseToCreate;

  void _toggleSelected() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  late final UserModel? user;

  void fetchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userJson = prefs.getString('user');
    final user = userJson != null ? UserModel.fromJson(userJson) : null;
    log("USER: $user");

    if (user?.linkedClinics.isEmpty == true) {
      log("LINKED CLINICS EMPTY");
      return;
    }
    if (mounted) {
      context.read<PastHistoryCubit>().fetchHistory(user?.linkedClinics[0]['clinic']['_id'] ?? '');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PastHistoryCubit, PastHistoryState>(
      listener: (context, state) {
        if (state.state == PastHistoryStates.creatingHistory) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Creating history"),
            duration: Duration(milliseconds: 1000),
          ));
        } else if (state.state == PastHistoryStates.creatingHistoryFailed) {
          showMessage(context, "Error", state.error!.content);
        } else if (state.state == PastHistoryStates.historyCreated) {
          showMessage(context, "Success", state.message ?? "Past history created successfully");
          if (diseaseToCreate != null) {
            setState(() {
              // _selectedDiseases.add(diseaseToCreate!);
            });
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Past history',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.pop(_selectedDiseases);
                },
                child: Container(
                  width: 70,
                  height: 35,
                  decoration: BoxDecoration(
                    color: const Color(0xFF32856E),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Text(
                      AppText.save,
                      style: TextStyle(color: AppColors.whiteColor, fontSize: 14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(width: 4),
                      Flexible(
                        child: TextField(
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            height: 1.2,
                            color: AppColors.blue1Color,
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: 'Search & select disease',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Text(
                "${_selectedDiseases.length} selected",
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  height: 1.2,
                  color: Color(0xFFA5A5A5),
                ),
              ),
            ),
            const SizedBox(height: 16),
            BlocBuilder<PastHistoryCubit, PastHistoryState>(builder: (context, state) {
              return state.state == PastHistoryStates.fetchingHistory
                  ? const Center(child: MyCircularProgressIndicator())
                  : Expanded(
                      child: ListView.builder(
                        itemCount: state.pastHistories?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          final history = state.pastHistories!.elementAt(index);

                          return Padding(padding: const EdgeInsets.only(bottom: 10), child: buildOption(history));
                        },
                      ),
                    );
            }),
          ],
        ),
      ),
    );
  }

  Widget buildOption(PastHistory pastHistory) {
    bool isSelected = _selectedDiseases.contains(pastHistory);
    return InkWell(
      onTap: () {
        log("Selected: $isSelected");
        setState(() {
          if (isSelected) {
            _selectedDiseases.remove(pastHistory);
          } else {
            showDetailsDialog(pastHistory);
          }
        });
      },
      child: Container(
        height: 50,
        color: const Color(0xffF7F7F7),
        child: GestureDetector(
          onTap: () async {
            if (!isSelected) {
              final PastHistory? body = await showDetailsDialog(pastHistory);

              log("NEW HISTORY: $body");
            } else {
              setState(() {
                if (isSelected) {
                  _selectedDiseases.remove(pastHistory);
                } else {
                  _selectedDiseases.add(pastHistory);
                }
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: const Color(0xFFA1A1A1),
                      ),
                      color: isSelected ? const Color(0xFFFEFEFE) : Colors.transparent,
                    ),
                    child: isSelected
                        ? const Icon(
                            Icons.check,
                            size: 18,
                            color: Colors.black,
                          )
                        : null,
                  ),
                ),
                const SizedBox(width: 16),
                Center(
                  child: Text(
                    pastHistory.disease.capitalize,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 1.2,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createHistory(body) {
    log("Creating history");

    if (body == null) return;
    context.read<PastHistoryCubit>().createHistory(body);
  }

  Future<PastHistory?> showDetailsDialog(PastHistory pastHistory) async {
    final PastHistory? newHistory = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return DiabeticsScreen(pastHistory: pastHistory);
      },
    );

    log("NEW HISTORY: $newHistory");

    if (newHistory == null) return null;
    setState(() {
      _selectedDiseases.add(newHistory);
    });
  }
}*/
