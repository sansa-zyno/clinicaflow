import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class MyBackArrowButton extends StatelessWidget {
  const MyBackArrowButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          context.pop();
        },
        child: const Icon(Icons.arrow_back));
  }
}
