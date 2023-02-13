/// Computes amount out for the second token of the pair
///
/// [pairReserves] must be a list of two [BigInt]s, where first variable is reserve for first token of the pair and second variable is reserve for second token of the pair
///
/// [amountIn] is the amount of the first token of the pair
///
/// Takes into Liquidity Provider Fee (last is 0.25%)
BigInt computeAmountOut(
  List<BigInt> pairReserves,
  BigInt amountIn,
) {
  const int feeNumerator = 25;
  const int feeDenominator = 10000;

  final BigInt amountInWithFee = amountIn *
      BigInt.from(feeDenominator - feeNumerator) ~/
      BigInt.from(feeDenominator);

  final BigInt constantProduct = pairReserves[1] * pairReserves[0];
  final BigInt newReserve0 = pairReserves[0] + amountInWithFee;
  final BigInt newReserve1 = constantProduct ~/ newReserve0;

  // amount out fo this pair
  final BigInt reserve1Subtraction = pairReserves[1] - newReserve1;

  return reserve1Subtraction;
}
