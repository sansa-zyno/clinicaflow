import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';
import 'package:healtether_clinic_app/Screens/ManageStaff/id_proof_dropdown.dart';

class EditDocumentScreen extends StatefulWidget {
  final PageController? pageController;

  const EditDocumentScreen({super.key, this.pageController});

  @override
  State<EditDocumentScreen> createState() => _EditDocumentScreenState();
}

class _EditDocumentScreenState extends State<EditDocumentScreen> {
  TextEditingController idController =TextEditingController();
  TextEditingController additionalIDController = TextEditingController();
  String? idProofText;
  bool showIDPhone = false;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Documents',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: IdProofDropDown(
                    value: idProofText,
                    onChanged: (String? newValue) {
                      setState(() {
                        idProofText = newValue;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            CustomTextField(
              controller: idController,
              hintText: ' ID no.',
              height: 52,
            ),
            SizedBox(height: 10),
            if (showIDPhone) ...[
              CustomTextField(
                controller: additionalIDController,
                hintText: 'Additional Phone',
                height: 52,
              ),
            ],
            GestureDetector(
              onTap: () {
                setState(() {
                  showIDPhone = true;
                });
              },
              child: const Row(
                children: [
                  Icon(Icons.add, color: Color(0xff5351C7)),
                  Text(
                    "Add another number",
                    style: TextStyle(color: Color(0xff5351C7)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 2,
                width: screenSize.width * 0.6,
                color: const Color(0xff5351C7),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const Text(
              'Add documents',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Please upload image/document at size less than 50Mb',
              style: TextStyle(fontSize: 10,),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 35,
              width: 370,
              decoration: BoxDecoration(
                color: const Color(0xffA1A1A1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Text(
                      'Browse to upload documents',
                      style:TextStyle(
                        fontSize: 12,
                        color: const Color(0xffFFFFFF),
                      ),
                    ),
                    const SizedBox(
                      width: 65,
                    ),
                    const Icon(
                      Icons.cloud_upload_outlined,
                      color: Color(0xffFFFFFF),
                    )
                  ],
                ),
              ),
            ),
            const Divider(),
            const Text(
              'List',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                const Text(
                  '1. Aadhar card.png',
                  style: TextStyle(
                      color: Color(
                        0xff6D6D6D,
                      ),
                      fontSize: 12),
                ),
                const SizedBox(
                  width: 85,
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.pageview_outlined)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
              ],
            ),
            const SizedBox(
              height: 170,
            ),
            Container(
              height: 60,
              width: 326,
              decoration: BoxDecoration(
                color: const Color(0xff32856E),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'Save',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xffFFFFFF),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
