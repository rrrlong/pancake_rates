import 'package:flutter/material.dart';
import 'package:pancake_rates/domain/entities/token.dart';
import 'package:pancake_rates/constants.dart';

class TokenWidget extends StatelessWidget {
  final Token token;
  final void Function()? onTap;

  const TokenWidget({
    Key? key,
    required this.token,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Container(
          height: 60.0,
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(),
            borderRadius: const BorderRadius.all(Radius.circular(30.0)),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: _TokenImage(
                  imageSrc: token.logoURI,
                  tokenSybmol: token.symbol,
                ),
              ),
              Text(token.symbol,
                  style: const TextStyle(fontSize: KDefaultFZ.small))
            ],
          ),
        ),
      ),
    );
  }
}

class _TokenImage extends StatelessWidget {
  final String imageSrc;
  final String tokenSybmol;

  const _TokenImage({
    super.key,
    required this.imageSrc,
    required this.tokenSybmol,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        height: 50.0,
        width: 50.0,
        decoration: const BoxDecoration(color: kPrimaryColor),
        child: imageSrc.isNotEmpty
            ? Image.network(
                imageSrc,
                fit: BoxFit.cover,
              )
            // if imageSrc is empty takes last letter of tokenSybmol
            : Center(
                child: Text(
                  tokenSybmol[tokenSybmol.length - 1],
                  style: const TextStyle(fontSize: KDefaultFZ.small),
                ),
              ),
      ),
    );
  }
}
