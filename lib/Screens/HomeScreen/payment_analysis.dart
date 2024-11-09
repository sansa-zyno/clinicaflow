import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/services.dart';

import 'package:healtether_clinic_app/widgets/piechart_card.dart';

class PaymentAnalysis extends StatefulWidget {
  const PaymentAnalysis({super.key});

  @override
  State<PaymentAnalysis> createState() => _PaymentAnalysisState();
}

class _PaymentAnalysisState extends State<PaymentAnalysis> {
  String containerText = 'kimjones@ybl';
  String selectedDoctor = '';
  String selectedDate = 'Today';
  final List<String> items = ['Dr. Kim Jones'];

  @override
  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: containerText));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment Analysis',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 15, right: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffF5F5F5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(border: InputBorder.none),
                    items: items.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      selectedDoctor = newValue!;
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
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
                    padding: const EdgeInsets.only(top: 18, bottom: 10, left: 10, right: 30),
                    child: Text(
                      containerText,
                      style: GoogleFonts.montserrat(color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ),
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
              colorList: [Color(0xff5351c7), Color(0xffe4e0f3), Color(0xffAEA4E2)],
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
                Color(0xffe4e0f3),
                Color(0xff5351c7),
              ],
            ),
            const SizedBox(
              height: 28,
            ),
          ],
        ),
      ),
    );
  }
}

class DateCards extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const DateCards({
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
          width: 75,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xff6CEBC6) : const Color(0xffF5F5F5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 13,
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

class RevenueCard extends StatelessWidget {
  final String desc;
  final String amnt;
  final String value;

  const RevenueCard({super.key, required this.desc, required this.amnt, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3, bottom: 18, left: 6, right: 12),
      child: Container(
        height: 130,
        width: 150,
        decoration: BoxDecoration(
          color: const Color(0xffF9F4FE),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                desc,
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 12),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                verticalDirection: VerticalDirection.down,
                children: [
                  const Icon(
                    Icons.currency_rupee,
                    size: 40,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    amnt,
                    style: const TextStyle(fontSize: 40),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14.0),
                    child: Text(
                      value,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
