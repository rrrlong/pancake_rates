import 'package:pancake_rates/domain/entities/token.dart';
import 'package:pancake_rates/domain/entities/token_amount.dart';
import 'package:pancake_rates/utils/compute_amount_out.dart';

/// Class for token pairs with reserves
class PairReserves {
  final Token token0;
  final Token token1;
  final BigInt reserve0;
  final BigInt reserve1;

  const PairReserves({
    required this.token0,
    required this.token1,
    required this.reserve0,
    required this.reserve1,
  });

  /// Computes tokenAmountOut for this pair given [tokenAmountIn]
  ///
  /// [tokenAmountIn.token] must be one of tokens  of the pair`s tokens
  ///
  /// Returns [null] if [tokenAmountIn.token] is not one of the pair`s tokens
  TokenAmount? getOutputAmount(TokenAmount tokenAmountIn) {
    if (tokenAmountIn.token == token0) {
      final BigInt amountOut = computeAmountOut(
        [reserve0, reserve1],
        tokenAmountIn.amount,
      );
      return TokenAmount(amount: amountOut, token: token1);
    } else if (tokenAmountIn.token == token1) {
      final BigInt amountOut = computeAmountOut(
        // if tokenAmountIn is second token - reverse reserves
        [reserve1, reserve0],
        tokenAmountIn.amount,
      );
      return TokenAmount(amount: amountOut, token: token0);
    } else {
      // tokenAmountIn incorrect
      return null;
    }
  }

  @override
  bool operator ==(Object other) {
    if (other is PairReserves) {
      return token0 == other.token0 && token1 == other.token1;
    }
    return false;
  }

  @override
  int get hashCode => token0.hashCode + token1.hashCode;
}
