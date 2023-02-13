import 'package:flutter/material.dart';
import 'package:pancake_rates/constants.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final void Function() onTap;

  const CustomTextButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: Container(
          height: 60.0,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(),
            borderRadius: const BorderRadius.all(Radius.circular(30.0)),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(fontSize: KDefaultFZ.medium),
            ),
          ),
        ),
      ),
    );
  }
}
