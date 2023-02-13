import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pancake_rates/domain/entities/token.dart';

/// Returns list of [Token] from PancakeSwap (whithout CAKE) or [null] if catch any error
Future<List<Token>?> fetchPancakeSwapTokens() async {
  const uri = 'https://tokens.pancakeswap.finance/pancakeswap-extended.json';

  try {
    final response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      try {
        final json = jsonDecode(response.body);
        final List<dynamic> rawTokens = json['tokens'];
        final List<Token> tokens =
            rawTokens.map((e) => Token.fromJson(e)).toList();
        // whithout first token (in this uri it`s CAKE)
        return tokens.sublist(1);
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}
