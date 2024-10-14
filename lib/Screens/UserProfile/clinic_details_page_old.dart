/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/buttons/my_elevated_button.dart';

class ClinicDetails extends StatefulWidget {
  const ClinicDetails({super.key});

  @override
  State<ClinicDetails> createState() => _ClinicDetailsState();
}

class _ClinicDetailsState extends State<ClinicDetails> {
  int startSelectedHours = 0;
  int startSelectedMinutes = 0;
  int endSelectedHours = 0;
  int endSelectedMinutes = 0;
  String startselectedPeriod = 'am';
  String endselectedPeriod = 'am';
  List<Map<String, String>> slotTimes = [];
  String startFormattedTime = '';
  String endFormattedTime = '';

  void _showTimePickerPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "ADD NEW SLOT",
            style: GoogleFonts.montserrat(
                fontSize: 15, fontWeight: FontWeight.w600),
          ),
          content: SizedBox(
            width: 600,
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    right: 178.0,
                  ),
                  child: const SizedBox(
                    height: 1,
                    width: 54,
                    child: Divider(
                      thickness: 2,
                      color: Color(0xff52CFAC),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Text(
                  "Start time",
                  style: GoogleFonts.montserrat(
                      fontSize: 15, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              height: 40,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey[300],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 7.0),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      startSelectedHours = int.parse(value);
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'hrs',
                                    hintStyle: GoogleFonts.montserrat(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            ':',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Container(
                              height: 40,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey[300],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 7.0),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      startSelectedMinutes = int.parse(value);
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'mins',
                                    hintStyle: GoogleFonts.montserrat(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              startselectedPeriod = 'am';
                            });
                          },
                          child: Container(
                            height: 32,
                            width: 45,
                            decoration: BoxDecoration(
                              color: const Color(0xff32856E),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'am',
                                style: GoogleFonts.montserrat(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              startselectedPeriod = 'pm';
                            });
                          },
                          child: Container(
                            height: 32,
                            width: 45,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'pm',
                                style: GoogleFonts.montserrat(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "End time",
                  style: GoogleFonts.montserrat(
                      fontSize: 15, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              height: 40,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey[300],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 7.0),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      endSelectedHours = int.parse(value);
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'hrs',
                                    hintStyle: GoogleFonts.montserrat(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            ':',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Container(
                              height: 40,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey[300],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 7.0),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      endSelectedMinutes = int.parse(value);
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'mins',
                                    hintStyle: GoogleFonts.montserrat(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              endselectedPeriod = 'am';
                            });
                          },
                          child: Container(
                            height: 32,
                            width: 45,
                            decoration: BoxDecoration(
                              color: const Color(0xff32856E),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'am',
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              endselectedPeriod = 'pm';
                            });
                          },
                          child: Container(
                            height: 32,
                            width: 45,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'pm',
                                style: GoogleFonts.montserrat(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    startFormattedTime =
                        '$startSelectedHours:${startSelectedMinutes.toString().padLeft(2, '0')} $startselectedPeriod';
                    endFormattedTime =
                        '$endSelectedHours:${endSelectedMinutes.toString().padLeft(2, '0')} $endselectedPeriod';

                    slotTimes.add({
                      'start': startFormattedTime,
                      'end': endFormattedTime,
                    });

                    print("Slot Times: $slotTimes");
                    Navigator.of(context).pop();
                  },
                  child: Center(
                    child: Container(
                      height: 45,
                      width: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xff32856E),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          'Save',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Center(
                    child: Container(
                      height: 45,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          'Exit',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ).then((value) {
      setState(() {
        startFormattedTime =
            '$startSelectedHours:${startSelectedMinutes.toString().padLeft(2, '0')} $startselectedPeriod';
        endFormattedTime =
            '$endSelectedHours:${endSelectedMinutes.toString().padLeft(2, '0')} $endselectedPeriod';

        slotTimes.add({'start': startFormattedTime, 'end': endFormattedTime});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Text(
                  'PATIENT ID',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    right: 38.0,
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
              height: 10,
            ),
            Text(
              'Set default text to patient id prefix and suffix',
              style: GoogleFonts.montserrat(
                color: Colors.grey,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Container(
                  height: 58,
                  width: 150,
                  decoration: const BoxDecoration(
                    color: Color(0xffEEEEEE),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 10, left: 14, right: 30),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Prefix',
                        hintStyle: GoogleFonts.montserrat(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                const Text(
                  '-',
                  style: TextStyle(
                    fontSize: 34,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Container(
                  height: 58,
                  width: 150,
                  decoration: const BoxDecoration(
                    color: Color(0xffEEEEEE),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 10, left: 14, right: 30),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Suffix',
                        hintStyle: GoogleFonts.montserrat(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Column(
              children: [
                Text(
                  'APPOINTMENT SLOTS',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    right: 122.0,
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
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: slotTimes.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        height: 58,
                        width: 320,
                        decoration: const BoxDecoration(
                          color: Color(0xffEEEEEE),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, bottom: 15, left: 14, right: 10),
                              child: Text(
                                'Slot ${index + 1}',
                                style: GoogleFonts.montserrat(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text(
                              '-',
                              style: GoogleFonts.montserrat(
                                color: Colors.grey,
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            // Expanded(
                            //   child: Text(
                            //     '${slotTimes[index]['start']} to ${slotTimes[index]['end']}',
                            //     style: GoogleFonts.montserrat(
                            //         color: Colors.black,
                            //         fontWeight: FontWeight.bold,
                            //         fontSize: 15),
                            //   ),
                            // ),
                            Expanded(
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '${slotTimes[index]['start']} ',
                                        style: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'to',
                                        style: GoogleFonts.montserrat(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' ${slotTimes[index]['end']}',
                                        style: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(
                              width: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    slotTimes.removeAt(index);
                                  });
                                },
                                child: const Icon(Icons.delete),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 54),
        child: MyElevatedButton(
          height: MediaQuery.sizeOf(context).height * 0.07,
          text: 'Add new Slot',
          onPressed: () => _showTimePickerPopup(context),
        ),
      ),
    );
  }
}*/
