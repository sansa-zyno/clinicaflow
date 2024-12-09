/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/business_logic/cubits/vitals_cubit/vitals_cubit.dart';
import 'package:healtether_clinic_app/data_layer/models/vitals_model.dart/vital.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:healtether_clinic_app/utils/mixins/ui_info_mixin.dart';
import 'package:healtether_clinic_app/widgets/components/my_circular_progress_indicator.dart';

class OtherVitalsScreen extends StatefulWidget {
  const OtherVitalsScreen({Key? key, required this.appointmentId, this.vitals}) : super(key: key);
  final List<Vital>? vitals;
  final String appointmentId;

  @override
  State<OtherVitalsScreen> createState() => _OtherVitalsScreenState();
}

class _OtherVitalsScreenState extends State<OtherVitalsScreen> with UiInfoMixin {
  late final List<Vital> _selectedDiseases;

  @override
  void initState() {
    super.initState();
    _selectedDiseases = widget.vitals ?? [];
    context.read<VitalsCubit>().getSavedVitals(appointmentId: widget.appointmentId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VitalsCubit, VitalsState>(
      listener: (context, state) {
        if (state.state == VitalsStates.fetchingVitalsFailed) {
          showMessage(context, "Error", state.error?.content ?? '');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  ' Vitals',
                  style: GoogleFonts.urbanist(
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.pop(_selectedDiseases);
                },
                child: GestureDetector(
                  onTap: () {
                    context.pop(_selectedDiseases);
                  },
                  child: Container(
                    width: 62,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color(0xFF32856E),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Center(
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "Poppins"),
                      ),
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
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            height: 1.2,
                            color: Color(0xFF110C2C),
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: 'Search & select ',
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
            BlocBuilder<VitalsCubit, VitalsState>(builder: (context, state) {
              return Expanded(
                child: state.state == VitalsStates.fetchingVitals
                    ? const Center(
                        child: MyCircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: state.vitals?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          final vital = state.vitals!.elementAt(index);
                          return Padding(padding: const EdgeInsets.only(bottom: 10), child: buildOption(vital));
                        },
                      ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget buildOption(Vital vital) {
    bool isSelected = _selectedDiseases.contains(vital);

    return SingleChildScrollView(
      child: GestureDetector(
        child: Container(
          height: 50,
          decoration: const BoxDecoration(
            color: Color(0xFFF8F7FC),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(children: [
            InkWell(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedDiseases.remove(vital);
                  } else {
                    _selectedDiseases.add(vital);
                  }
                });
              },
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
                vital.type!,
                style: GoogleFonts.urbanist(
                  textStyle: const TextStyle(
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 1.2,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}*/
