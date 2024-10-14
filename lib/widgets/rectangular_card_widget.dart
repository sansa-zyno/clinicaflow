import 'package:flutter/material.dart';

class RectangularCard extends StatelessWidget {
  final String text;
  final IconData iconData;
  final VoidCallback onPressed;

  const RectangularCard({
    Key? key,
    required this.text,
    required this.iconData,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: "Urbanist",
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();

        final textWidth = textPainter.size.width;
        const padding = 60.0;
        final cardWidth = textWidth + padding;
        final maxWidth = constraints.maxWidth * 0.7;

        return SizedBox(
          height: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Card(
              color: const Color(0xFF85F8D5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          text,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Urbanist",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: onPressed,
                      child: CircleAvatar(
                        maxRadius: 10,
                        backgroundColor: const Color(0xFFE8F5F3),
                        child: Icon(
                          iconData,
                          color: Colors.black,
                          size: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
