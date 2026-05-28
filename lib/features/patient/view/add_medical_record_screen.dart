import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text.dart';

class AddMedicalRecordScreen extends StatefulWidget {
  const AddMedicalRecordScreen({super.key});

  @override
  State<AddMedicalRecordScreen> createState() => _AddMedicalRecordScreenState();
}

class _AddMedicalRecordScreenState extends State<AddMedicalRecordScreen> {
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
              "Add Medical Record",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),
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
            const SizedBox(height: 8),
            const Text(
              "Please upload image/document of size less than 10Mb",
              style: TextStyle(
                color: Color(0xff6D6D6D),
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "MEDICAL RECORDS",
              style: TextStyle(
                color: AppColors.blue1Color,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              height: 2,
              width: screenWidth * 0.12,
              decoration: const BoxDecoration(color: Color(0xff52CFAC)),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "1. X-ray report_28may23.pdf",
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
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "2. X-ray report_28may23.pdf",
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
