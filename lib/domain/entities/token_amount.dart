import 'package:pancake_rates/domain/entities/token.dart';

/// Class for ERC-20 token with amount
class TokenAmount {
  final Token token;
  final BigInt amount;

  const TokenAmount({
    required this.token,
    required this.amount,
  });
}
