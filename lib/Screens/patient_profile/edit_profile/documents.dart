import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/widgets/CustomTextField.dart';
import 'package:healtether_clinic_app/widgets/customButton.dart';

class DocumentDetails extends StatefulWidget {
   const DocumentDetails({super.key});

  @override
  State<DocumentDetails> createState() => _DocumentDetailsState();
}

class _DocumentDetailsState extends State<DocumentDetails> {
  String? documentText="Aadhar";
 final TextEditingController _number1controller=TextEditingController(text:"9658 4521 6563 8954" );

final TextEditingController _number2controller=TextEditingController(text: "+91 9865 632142");

final TextEditingController _emailcontroller=TextEditingController(text: "Jana Doe");

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child:  SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
            children: [
               const Text(
                "Documents ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 7,),
              Container(
                height: 70,
                color: const Color(0xffF5F5F5),
               
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 10,),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    value: documentText,
                    items: ['Aadhar', 'VoterId', 'PanCard']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        
                        value: value,
                        child: Text(
                          value,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color:
                                 Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        documentText = newValue;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 7,),
              CustomTextField(
                controller: _number1controller,
                hintText: "9658 4521 6563 8954",suffIcon:IconButton(onPressed: (){}, icon: const Icon(Icons.minimize_outlined,color: Colors.black,)),),
              const SizedBox(height: 7,),
            
          
              
              TextButton(onPressed: (){}, child: const Text("+  Add another ID",style: TextStyle(decoration: TextDecoration.underline,color: Color(0xff009394),fontSize: 16,fontWeight: FontWeight.w700),)),

               const Text(
                "Add Documents ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 7,),
               const CustomButton(data: "browse Documents",color:Color.fromARGB(221, 55, 55, 55),Textcolor: Colors.white,),
               TextButton(onPressed: (){}, child: const Text("+  Add other Documnets",style: TextStyle(decoration: TextDecoration.underline,color: Color(0xff009394),fontSize: 16,fontWeight: FontWeight.w700),)),
               const Divider(thickness: 1,color: Colors.grey,),
             const Text(
                "List ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),


              ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("${index+1} Aadhar card"),
                  
                  Row(
                   
                    children: [IconButton(onPressed: (){}, icon: const Icon(Icons.delete)),IconButton(onPressed: (){}, icon: Icon(Icons.image_search_sharp))],)],);
                },)
            ],
          ),
        ),
      
    );
  }
}