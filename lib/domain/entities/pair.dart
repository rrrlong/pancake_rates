import 'package:pancake_rates/domain/entities/token.dart';

/// Class for pair of two [Token] objects
class Pair {
  final Token token0;
  final Token token1;

  const Pair({
    required this.token0,
    required this.token1,
  });

  /// Creates a [Pair] whose tokens are sorted by addresses
  factory Pair.sorted(
    Token token0,
    Token token1,
  ) {
    // require for correct compare
    final String lowercasedToken0Address = token0.address.toLowerCase();
    final String lowercasedToken1Address = token1.address.toLowerCase();
    final int compareResult =
        lowercasedToken0Address.compareTo(lowercasedToken1Address);

    // returns Pair whose token0.address less than token1.address
    if (compareResult > 0) {
      return Pair(token0: token1, token1: token0);
    }
    return Pair(token0: token0, token1: token1);
  }

  @override
  bool operator ==(Object other) {
    if (other is Pair) {
      return token0 == other.token0 && token1 == other.token1;
    }
    return false;
  }

  @override
  int get hashCode => token0.hashCode + token1.hashCode;
}
