import 'dart:math';

import 'package:pancake_rates/domain/entities/pair_reserves.dart';
import 'package:pancake_rates/domain/entities/token_amount.dart';

/// Class for route from [tokenAmountIn.token] to [tokenAmountOut.token]
class SwapRoute {
  final List<PairReserves> pairs;
  final TokenAmount tokenAmountIn;
  final TokenAmount tokenAmountOut;

  const SwapRoute({
    required this.pairs,
    required this.tokenAmountIn,
    required this.tokenAmountOut,
  });

  /// Returns price for [tokenAmountOut] for this route
  double getPrice() {
    return tokenAmountOut.amount /
        BigInt.from(pow(10, tokenAmountOut.token.decimals));
  }

  /// Returns this route as [String]
  ///
  /// Exsamle output: `CAKE > WBNB > ETH`
  @override
  String toString() {
    var tokens = [tokenAmountIn.token.symbol];
    for (final pair in pairs) {
      pair.token0.symbol == tokens.last
          ? tokens.add(pair.token1.symbol)
          : tokens.add(pair.token0.symbol);
    }
    return tokens.join(' > ');
  }
}
