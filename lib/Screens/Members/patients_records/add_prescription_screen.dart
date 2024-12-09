import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/constants/constants.dart';

class AddPrescriptionScreen extends StatefulWidget {
  const AddPrescriptionScreen({super.key});

  @override
  State<AddPrescriptionScreen> createState() => _AddPrescriptionScreenState();
}

class _AddPrescriptionScreenState extends State<AddPrescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: const Text(AppText.addRecords),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppText.addPrescription,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 14,
            ),
            Container(
              width: screenWidth,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xffA1A1A1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Browse to upload documents",
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.backup_outlined,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            const Text(
              "Please upload image/document of size less than 10Mb",
              style: TextStyle(
                color: Color(0xff6D6D6D),
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            const Text(
              "PRESCRIPTIONS RECORDS",
              style: TextStyle(
                color: AppColors.blue1Color,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              height: 2,
              width: screenWidth * 0.12,
              decoration: const BoxDecoration(
                color: Color(0xff52CFAC),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "1. Consultation_01july23.png",
                    style: TextStyle(
                      color: Color(0xff6D6D6D),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(Icons.find_in_page),
                ),
                const SizedBox(
                  width: 30,
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(Icons.delete),
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "2. Consultation_28may23.png",
                    style: TextStyle(
                      color: Color(0xff6D6D6D),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(Icons.find_in_page),
                ),
                const SizedBox(
                  width: 30,
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(Icons.delete),
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
