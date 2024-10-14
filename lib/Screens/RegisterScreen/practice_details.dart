import 'package:flutter/cupertino.dart';
import 'package:healtether_clinic_app/widgets/CustomTextField.dart';

class PracticeDetailsRegisterScreen extends StatelessWidget {
  final TextEditingController specializationController;
  final TextEditingController registrationNumber;
  const PracticeDetailsRegisterScreen({super.key,required this.registrationNumber,required this.specializationController});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ 
          SizedBox(height: 10,),
      
          Text("Practice Details",style: TextStyle(fontWeight: FontWeight.bold),),
      
          SizedBox(height: 20,),
      
          Text("Enter your field of Specialization *",style: TextStyle(fontSize: 14),),
          SizedBox(height: 8,),
          CustomTextField(
            hintText:"Ex - General Physicist" ,
          ),
          SizedBox(height: 10,),
      
          Text("Enter your medical registration number *",style: TextStyle(fontSize: 14),),
          SizedBox(height: 8,),
          CustomTextField(
            hintText:"Ex - MD1234" ,
          ),
      
        SizedBox(height: 30,),
       
      
      
      
      
        ],
      
      ),
    );
  }
}