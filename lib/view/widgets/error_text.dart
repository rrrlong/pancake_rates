import 'package:flutter/material.dart';
import 'package:pancake_rates/constants.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Something goes wrong, try later',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: KDefaultFZ.medium,
      ),
    );
  }
}
