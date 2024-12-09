import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/utils/mixins/app_bar_mixin.dart';

class PaymentSettings extends StatefulWidget {
  const PaymentSettings({super.key});

  @override
  State<PaymentSettings> createState() => _PaymentSettingsState();
}

class _PaymentSettingsState extends State<PaymentSettings> with AppBarMixin {
  String selectedOptions = 'Phone Pe';

  bool isStarVisible = true;

  TextEditingController text1 = TextEditingController();

  TextEditingController text2 = TextEditingController();

  TextEditingController text3 = TextEditingController();

  TextEditingController text4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: "Clinic Settings", showDefaultActions: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    'PAYMENTS SETTINGS',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      right: 112.0,
                    ),
                    child: SizedBox(
                      height: 5,
                      width: 54,
                      child: Divider(
                        thickness: 2,
                        color: Color(0xff52CFAC),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 48,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    PayOptionsCards(
                      text: 'Phone Pe',
                      isSelected: selectedOptions == 'Phone Pe',
                      onTap: () {
                        setState(() {
                          selectedOptions = 'Phone Pe';
                        });
                      },
                    ),
                    PayOptionsCards(
                      text: 'Others',
                      isSelected: selectedOptions == 'Others',
                      onTap: () {
                        setState(() {
                          selectedOptions = 'Others';
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Merchant ID*',
                style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.lightGrey8),
              ),
              const SizedBox(height: 6),
              Container(
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xffEEEEEE),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                isStarVisible = false;
                              });
                            } else {
                              setState(() {
                                isStarVisible = true;
                              });
                            }
                          },
                          controller: text1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Merchant ID',
                            hintStyle: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 200),
                        child: Visibility(
                          visible: isStarVisible,
                          child: const Text(
                            '*',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Salt Key*',
                style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.lightGrey8),
              ),
              const SizedBox(height: 6),
              Container(
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xffEEEEEE),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                isStarVisible = false;
                              });
                            } else {
                              setState(() {
                                isStarVisible = true;
                              });
                            }
                          },
                          controller: text2,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Salt Key',
                            hintStyle: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 200),
                        child: Visibility(
                          visible: isStarVisible,
                          child: const Text(
                            '*',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Salt Index*',
                style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.lightGrey8),
              ),
              const SizedBox(height: 6),
              Container(
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xffEEEEEE),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                isStarVisible = false;
                              });
                            } else {
                              setState(() {
                                isStarVisible = true;
                              });
                            }
                          },
                          controller: text3,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Salt Index',
                            hintStyle: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 200),
                        child: Visibility(
                          visible: isStarVisible,
                          child: const Text(
                            '*',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 230,
              ),
              GestureDetector(
                onTap: () {
                  if (text1.text.isEmpty && text2.text.isEmpty && text3.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill in all the details')),
                    );
                  }
                },
                child: Center(
                  child: Container(
                    height: 52,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: text1.text.isEmpty && text2.text.isEmpty && text3.text.isEmpty ? const Color(0xffF8F7FC) : const Color(0xff32856E),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        'Save',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          color: text1.text.isEmpty && text2.text.isEmpty && text3.text.isEmpty ? Colors.grey : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PayOptionsCards extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const PayOptionsCards({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 20,
          width: 88,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xff6CEBC6) : const Color(0xffF5F5F5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: Colors.black,
                fontFamily: GoogleFonts.montserrat().fontFamily,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
