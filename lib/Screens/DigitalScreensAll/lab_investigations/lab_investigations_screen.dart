import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/symptoms_diagnosis/create_digital_prescription_screens.dart';
import 'package:healtether_clinic_app/business_logic/cubits/lab_test_cubit/lab_test_cubit.dart';
import 'package:healtether_clinic_app/constants/app_constants.dart';
import 'package:healtether_clinic_app/data_layer/models/lab_tests/lab_tests.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/widget_extensions.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';
import 'package:healtether_clinic_app/widgets/buttons/my_selectable_container.dart';
import 'package:healtether_clinic_app/widgets/components/dual_action_bottom_nav.dart';
import 'package:healtether_clinic_app/widgets/components/my_search_bar.dart';
import 'package:healtether_clinic_app/widgets/section_text.dart';
import 'package:healtether_clinic_app/widgets/text_list_tile.dart';

class LabInvestigationsScreen extends StatefulWidget {
  final List<LabTest> selectedTests;

  const LabInvestigationsScreen({Key? key, required this.selectedTests}) : super(key: key);

  @override
  State<LabInvestigationsScreen> createState() => _LabInvestigationsScreenState();
}

class _LabInvestigationsScreenState extends State<LabInvestigationsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  OverlayEntry? _overlayEntry;
  LayerLink layerLink = LayerLink();

  late List<LabTest> selectedTests;
  late List<LabTest> recommendedTests;
  late List<LabTest> frequentlySearchedTests;

  @override
  void initState() {
    super.initState();
    selectedTests = List<LabTest>.from(widget.selectedTests);
    //context.read<LabTestCubit>().fetchRecommendedTests();
    context.read<LabTestCubit>().fetchFrequentlySearchedTests();
  }

  // bool _isDrawerOpen = false;

  void _toggleDrawer() {
    if (_scaffoldKey.currentState!.isEndDrawerOpen) {
      Navigator.of(context).pop();
    } else {
      _scaffoldKey.currentState!.openEndDrawer();
    }
    // setState(() {
    // _isDrawerOpen = _scaffoldKey.currentState!.isEndDrawerOpen ? false : true;
    // });
  }

  final TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  //bool get isTyping => focusNode.hasFocus;
  TextStyle get boldTitleUrbanist =>
      GoogleFonts.urbanist(textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20, height: 24 / 20));

  TextStyle get hintStyle =>
      GoogleFonts.roboto(textStyle: const TextStyle(color: AppColors.grey, fontWeight: FontWeight.w500, fontSize: 13, height: 15.6 / 13));

  void selectTest(LabTest test) async {
    LabTest newTest = test;
    TextEditingController notes = TextEditingController();
    await showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: const BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //? HEADER
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //? TITLE
                          Text(test.name, style: boldTitleUrbanist),
                          //? ACTION
                          buildActionButton(
                              text: "Done",
                              onTap: () {
                                newTest = newTest.copyWith(note: [notes.text]);

                                if (selectedTests.contains(newTest)) {
                                  int index = selectedTests.indexOf(newTest);
                                  print("contains newTest");
                                  selectedTests[index] = newTest;
                                } else {
                                  selectedTests.add(newTest);
                                }

                                context.pop();
                                focusNode.unfocus();
                              }).pSymmetric()
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    //? SHOULD REPEAT
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: CheckboxListTile(
                          contentPadding: const EdgeInsets.all(0),
                          visualDensity: const VisualDensity(horizontal: -4, vertical: 4),
                          value: newTest.reapeat,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text("Repeat", style: hintStyle),
                          onChanged: (value) {
                            setState(() {
                              newTest = newTest.copyWith(reapeat: value);
                            });
                          }),
                    ),

                    //? NOTES
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text("Notes", style: boldTitleUrbanist).pOnly(bottom: 4),
                    ),

                    //? TEXTFIELD,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomTextField(
                          controller: notes,
                          hintText: "Write the remark here",
                          fillColor: AppColors.whiteSmoke,
                          hintStyle: hintStyle.copyWith(fontWeight: FontWeight.w400, height: 17.16 / 13),
                          minLines: 5,
                          maxLines: 10),
                    )
                  ],
                ),
              ),
            );
          });
        });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        // leadingWidth: 30,
        automaticallyImplyLeading: true,
        title: Text(
          AppText.digitalPrescription,
          style: GoogleFonts.urbanist(
            textStyle: const TextStyle(
              fontSize: 20,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w500,
              height: 1.25,
              color: AppColors.lightBlueColor,
            ),
          ),
        ),
        backgroundColor: AppColors.whitColor,
        actions: [
          IconButton(
            onPressed: _toggleDrawer,
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      //endDrawer: const VitalsAndPastHistoryEndDrawer(),
      body: SingleChildScrollView(
        child: BlocBuilder<LabTestCubit, LabTestState>(builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),

                    //? HEADER -> LAB INVESTIGATION
                    const SectionText(
                      "lab investigation",
                      underlineWidth: double.maxFinite,
                      underlineColor: AppColors.eerieBlack,
                    ).pSymmetric(horizontal: 8),

                    const SizedBox(height: 10),

                    //? SEARCH BAR
                    CompositedTransformTarget(
                      link: layerLink,
                      child: MySearchBar(
                          searchController: searchController,
                          fillColor: AppColors.whiteSmoke,
                          hintText: "Search by tests or domain",
                          onChanged: (value) {
                            context.read<LabTestCubit>().searchTests(value);
                            if (_overlayEntry == null) {
                              _showOverlay(context, buildTypingView());
                            } else {
                              _removeOverlay();
                              _showOverlay(context, buildTypingView());
                            }
                          },
                          focusNode: focusNode),
                    ),

                    Text("${selectedTests.length} selected",
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(color: AppColors.grey2, fontWeight: FontWeight.w500, fontSize: 13, height: 15.6 / 13)))
                        .pOnly(top: 4, bottom: 8),

                    buildNotTypingView(state)
                  ],
                ),
              ),
            ],
          );
        }),
      ),
      bottomNavigationBar: selectedTests.isNotEmpty
          ? DualActionBottomNav(
              text: "Clear",
              focusedText: "Save",
              onPressed: () {
                setState(() {
                  selectedTests.clear();
                });
              },
              onFocusedPressed: () {
                log("Commit selected tests");

                context.pop();
              })
          : null,
    );
  }

  void _showOverlay(BuildContext context, Widget widget) {
    _overlayEntry = _createOverlayEntry(widget);
    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry(Widget widget) {
    return OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        width: 360,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, 52.0),
          child: Material(elevation: 1.0, child: Container(height: 600, child: SingleChildScrollView(child: widget))),
        ),
      ),
    );
  }

  Widget buildTypingView() {
    return BlocBuilder<LabTestCubit, LabTestState>(builder: (context, state) {
      if (state.state == LabTestStates.searchingForTests) {
        return Container();
      } else if (state.state == LabTestStates.searchingForTestsFailed) {
        return Container();
      } else {
        return Column(
            children: List<Widget>.generate(state.availableTests?.length ?? 0, (index) {
          LabTest test = state.availableTests!.elementAt(index);

          return TextListTile(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
            text: test.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            /*leading: Checkbox(
            value: selectedTests.contains(test),
            onChanged: (value) {
              if (value == false) {
                selectedTests.remove(test);
              } else {
                selectTest(test);
              }
            }),*/
            onTap: () {
              _removeOverlay();
              if (selectedTests.contains(test) == true) {
                selectedTests.remove(test);
              } else {
                selectTest(test);
              }
            },
          ).pOnly(bottom: 8);
        }));
      }
    });
  }

  Column buildNotTypingView(LabTestState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //? SELECTED TESTS IF ANY
        Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List<Widget>.generate(selectedTests.length, (index) {
              final LabTest test = selectedTests.elementAt(index);
              return Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(color: AppColors.lightAqua2, borderRadius: BorderRadius.circular(7)),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Text(test.name),
                    const SizedBox(width: 10),
                    MyIconContainer(
                        backgroundColor: AppColors.whiteSmoke,
                        onTap: () {
                          setState(() {
                            selectedTests.remove(test);
                          });
                        },
                        size: 20,
                        icon: const Icon(Icons.close, color: AppColors.darkBlueViolet, size: 14))
                  ]));
            })),

        const SizedBox(height: 16),

        //? RECOMMENDED TESTS
        //BuildLabTestsSection(title: "Recommended Tests", tests: state.recommendedTests ?? [], onTap: selectTest).pOnly(bottom: 10),

        //? FREQUENTLY SEARCHED TESTS
        if (state.state == LabTestStates.fetchingFrequentlySearchedTests) AppConstants.buildPlaceHolder(title: 'Frequently Searched Tests'),
        if (state.state == LabTestStates.frequentlySearchedTestsFailed) AppConstants.buildPlaceHolder(title: 'Frequently Searched Tests'),
        if (state.state == LabTestStates.frequentlySearchedTestsFetched)
          BuildLabTestsSection(
              title: "Frequently Searched Tests",
              textStyle: const TextStyle(color: AppColors.grey),
              tests: state.frequentlySearchedTests ?? [],
              onTap: selectTest),
      ],
    );
  }

  SelectableContainer buildActionButton({required String text, required VoidCallback onTap}) {
    return SelectableContainer(
      selected: true,
      onTap: onTap,
      selectedTitle: Text(
        text,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class BuildLabTestsSection extends StatelessWidget {
  const BuildLabTestsSection({super.key, required this.title, required this.tests, this.textStyle, required this.onTap});
  final String title;
  final List<LabTest> tests;
  final TextStyle? textStyle;
  final void Function(LabTest test) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title,
            style: GoogleFonts.urbanist(
                textStyle:
                    const TextStyle(color: AppColors.deepAqua, fontWeight: FontWeight.bold, fontSize: 14, height: 17.36 / 14).merge(textStyle))),
        const SizedBox(
          height: 12,
        ),
        Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List<Widget>.generate(tests.length, (index) {
              final LabTest test = tests.elementAt(index);
              return SelectableContainer(
                title: Text(test.name),
                onTap: () {
                  onTap(test);
                },
              );
            })),
        const Divider()
      ],
    );
  }
}
