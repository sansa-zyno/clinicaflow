import 'package:flutter/material.dart';

class PersonalEdit extends StatefulWidget {
  const PersonalEdit({super.key});

  @override
  State<PersonalEdit> createState() => _PersonalEditState();
}

class _PersonalEditState extends State<PersonalEdit> {
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isSelected = false;
  String? genderText = "Female";
  bool colorChange = false;
  bool isRowVisible = true;
  DateTime? _selectedDate;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Personal Details ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            // const SizedBox(
            //   height: 12,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     GestureDetector(
            //       onTap: (){},
            //       child: const CircleAvatar(
            //         radius: 50,
            //         backgroundImage: AssetImage('assets/homeimages/janaDoe.png'),
            //       ),
            //     ),
            //     const SizedBox(width: 7,),
            //     const Expanded(
            //       child: Text(
            //         "Click on the Profile photo to change it.",
            //         style: TextStyle(color: Color(0XFF7A7A7A)),
            //       ),
            //     )
            //   ],
            // ),
            // const SizedBox(
            //   height: 16,
            // ),
            // CustomTextField(
            //   controller: TextEditingController(),
            //   hintText: "Jana Doe"),
            //   const SizedBox(
            //     height: 8,
            //   ),

            //  GestureDetector(
            //           onTap: () async {
            //             final DateTime? pickedDate = await showDatePicker(
            //               context: context,
            //               initialDate: DateTime.now(),
            //               firstDate: DateTime(2000),
            //               lastDate: DateTime(2101),
            //               builder: (BuildContext context, Widget? child) {
            //                 return Theme(
            //                   data: ThemeData.light().copyWith(
            //                     colorScheme: const ColorScheme.light(
            //                       primary: Color(0xff32856E), // Your chosen color
            //                       onPrimary: Colors.white,
            //                     ),
            //                   ),
            //                   child: child!,
            //                 );
            //               },
            //             );
            //             if (pickedDate != null && pickedDate != _selectedDate) {
            //               setState(() {
            //                 _selectedDate = pickedDate;
            //               });
            //             }
            //           },
            //           child: Container(
            //             height: 70,
            //             color: const Color(0xffF5F5F5),

            //             child: Padding(
            //               padding: const EdgeInsets.only(
            //                   top: 15, bottom: 10,),
            //               child: Row(
            //                 children: [
            //                   Expanded(
            //                     child: Text(
            //                       _selectedDate != null
            //                           ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
            //                           : '14-07-1992',
            //                       style: GoogleFonts.montserrat(
            //                         fontSize: 14,
            //                         fontWeight: FontWeight.w500,
            //                         color: _selectedDate != null
            //                             ? Colors.black
            //                             : Colors.grey,
            //                       ),
            //                     ),
            //                   ),
            //                   const Icon(
            //                     Icons.arrow_drop_down,
            //                     color: Colors.grey,
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ),
            //   const SizedBox(
            //     height: 16,
            //   ),
            //   // CustomTextField(controller: TextEditingController(), hintText: "31" , keyBoardType: TextInputType.numberWithOptions(),),
            //   const SizedBox(
            //     height: 8,
            //   ),
            //   Container(
            //       height: 70,
            //       color: const Color(0xffF5F5F5),

            //       child: Padding(
            //         padding: const EdgeInsets.only(
            //             top: 15, bottom: 10,),
            //         child: DropdownButtonFormField<String>(
            //           decoration: const InputDecoration(
            //             border: InputBorder.none,
            //             isDense: true,
            //           ),
            //           value: genderText,
            //           items: ['Male', 'Female', 'Others']
            //               .map((String value) {
            //             return DropdownMenuItem<String>(
            //               value:  value,
            //               child: Text(
            //                 value,
            //                 style: GoogleFonts.montserrat(
            //                   fontSize: 14,
            //                   fontWeight: FontWeight.w500,
            //                   color:
            //                       value == 'Female' ? Colors.grey : Colors.black,
            //                 ),
            //               ),
            //             );
            //           }).toList(),
            //           onChanged: (String? newValue) {
            //             setState(() {
            //               genderText = newValue;
            //             });
            //           },
            //         ),
            //       ),
            //     ),

            //     const SizedBox(height: 8,),
            //  Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Expanded(child: CustomTextField(controller: TextEditingController(), hintText: "175",width:MediaQuery.of(context).size.width/2-32,suffixText:"Cm", keyBoardType: const TextInputType.numberWithOptions(),)),
            //       Expanded(child: CustomTextField(controller: TextEditingController(), hintText: "75",width: MediaQuery.of(context).size.width/2-32,suffixText: "Kg", keyBoardType: const TextInputType.numberWithOptions(),))
            //     ],
            //   ),
            // const SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}
