import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/constants/constants.dart';

class CreateDigitalPrescription extends StatefulWidget {
  const CreateDigitalPrescription({Key? key}) : super(key: key);

  @override
  State<CreateDigitalPrescription> createState() =>
      _CreateDigitalPrescriptionState();
}

class _CreateDigitalPrescriptionState extends State<CreateDigitalPrescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppText.digitalPrescription),
        backgroundColor: AppColors.whitColor,
        toolbarHeight: 93,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const Center(
            child: Text(
              AppText.medicalConditionInvestigation,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                height: 1.25,
                letterSpacing: 0.01,
                color: AppColors.blackColor,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    AppText.pastHistory,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      height: 1.25,
                      letterSpacing: 0.01,
                      color: AppColors.blackColor,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      AppText.add,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        height: 1.25,
                        letterSpacing: 0.01,
                        color: AppColors.greenColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 16),
                _buildConditionContainer('None'),
                const SizedBox(width: 8),
                _buildConditionContainer('Diabetics'),
                const SizedBox(width: 8),
                _buildConditionContainer('TB'),
                const SizedBox(width: 8),
                _buildConditionContainer('Hepatitis'),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConditionContainer(String text) {
    return Container(
      width: 120,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.whitColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: AppColors.blackColor),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.blackColor,
          ),
        ),
      ),
    );
  }
}
