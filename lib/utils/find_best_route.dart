import 'package:pancake_rates/domain/entities/token.dart';
import 'package:pancake_rates/domain/entities/token_amount.dart';
import 'package:pancake_rates/domain/entities/pair_reserves.dart';
import 'package:pancake_rates/domain/entities/swap_route.dart';

/// Returns route with bigest tokenAmountOut
SwapRoute selectBestRoute(SwapRoute? currentBestRoute, SwapRoute newRoute) {
  if (currentBestRoute == null ||
      currentBestRoute.tokenAmountOut.amount < newRoute.tokenAmountOut.amount) {
    return newRoute;
  }
  return currentBestRoute;
}

/// Finds best [SwapRoute] from tokenIn to tokenOut or returns [null] if no such route exists
///
/// Requires [pairs] - List of all known [PairReserves]
///
/// Requires [tokenAmountIn] - [TokenAmount] object of tokenIn
///
/// Requires [tokenOut] - [Token] object of tokenOut
///
/// [maxHops] - amount of max hops from pair to pair
///
/// This props using in recursion:
///
/// [currentPairs] - pairs chosen for curent route
///
/// Requires [originalAmountIn] - [TokenAmount] object of tokenIn
///
/// [bestRoute] - last best route to [tokenOut]
///
SwapRoute? findBestRoute({
  required List<PairReserves> pairs,
  required TokenAmount tokenAmountIn,
  required Token tokenOut,
  int maxHops = 3,
  // using in recursion
  List<PairReserves> currentPairs = const [],
  required TokenAmount originalAmountIn,
  SwapRoute? bestRoute,
}) {
  SwapRoute? curentBestRoute = bestRoute;

  for (int i = 0; i < pairs.length; i++) {
    final pair = pairs[i];
    // pair irrelevant
    // requires pair that contains current tokenAmountIn.token
    if (!(pair.token0 == tokenAmountIn.token) &&
        !(pair.token1 == tokenAmountIn.token)) continue;
    if (pair.reserve0 == BigInt.zero || pair.reserve1 == BigInt.zero) continue;

    // getting tokenAmountOut from current pair
    TokenAmount? tokenAmountOut = pair.getOutputAmount(tokenAmountIn);
    if (tokenAmountOut == null) continue;

    // when a new route to tokenOut is found, compare the routes
    if (tokenAmountOut.token == tokenOut) {
      curentBestRoute = selectBestRoute(
        curentBestRoute,
        SwapRoute(
          pairs: [...currentPairs, pair],
          tokenAmountIn: originalAmountIn,
          tokenAmountOut: tokenAmountOut,
        ),
      );
    } else if (maxHops > 1 && pairs.length > 1) {
      final List<PairReserves> pairsExcludingThisPair = [
        ...pairs.sublist(0, i),
        ...(pairs.sublist(i + 1, pairs.length))
      ];

      // otherwise, consider all the other paths that lead from this token as long as we have not exceeded maxHops
      final SwapRoute? newRoute = findBestRoute(
        pairs: pairsExcludingThisPair,
        tokenAmountIn: tokenAmountOut,
        tokenOut: tokenOut,
        maxHops: maxHops - 1,
        currentPairs: [...currentPairs, pair],
        originalAmountIn: originalAmountIn,
        bestRoute: curentBestRoute,
      );

      if (newRoute != null) curentBestRoute = newRoute;
    }
  }

  return curentBestRoute;
}
