import 'package:flutter/material.dart';

class AppendectomyInput extends StatefulWidget {
  final void Function(String)? onYearChanged;
  final void Function()? onSavePressed;

  const AppendectomyInput({
    Key? key,
    this.onYearChanged,
    this.onSavePressed,
  }) : super(key: key);

  @override
  AppendectomyInputState createState() => AppendectomyInputState();
}

class AppendectomyInputState extends State<AppendectomyInput> {
  String selectedYear = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(
                text: 'Appendectomy ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'performed in the year  ',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Center(
                    child: Container(
                      width: 140,
                      height: 46,
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF5F5F5),
                      ),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            selectedYear = value;
                            if (widget.onYearChanged != null) {
                              widget.onYearChanged!(selectedYear);
                            }
                          });
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Year',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (widget.onSavePressed != null) {
                        widget.onSavePressed!();
                      }
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 100,
                      height: 34,
                      decoration: BoxDecoration(
                        color: const Color(0xFF32856E),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Center(
                        child: Text(
                          "Save",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
