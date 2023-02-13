import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Icon icon;
  final void Function() onTap;

  const CustomIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: Container(
          height: 50.0,
          width: 50.0,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(),
            borderRadius: const BorderRadius.all(
              Radius.circular(25.0),
            ),
          ),
          child: icon,
        ),
      ),
    );
  }
}
