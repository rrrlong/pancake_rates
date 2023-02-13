import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:pancake_rates/domain/data_providers/reserves_data_provider.dart';

import 'package:pancake_rates/domain/entities/token.dart';
import 'package:pancake_rates/domain/entities/token_amount.dart';
import 'package:pancake_rates/domain/entities/pair_reserves.dart';
import 'package:pancake_rates/domain/entities/swap_route.dart';

import 'package:pancake_rates/utils/find_best_route.dart';
import 'package:pancake_rates/constants.dart';

/// ### Stores:
/// Selected Tokens, type [Token] (for each token)
/// - has getters [token0] and [token1]
/// - can be edited using the [setTokenByIndex] function
///
/// Swap Route, type [SwapRoute]
/// - has getter [route]
/// - can be [null] if the route does not exist
/// - can be updated using the [updateRoute] function
///
/// Last Update, type [DateTime]
/// - has getter [lastUpdate]
/// - updates with route
///
/// Loading, type [bool]
/// - has getter [loading]
/// - [true] in case of first [updateRoute] for selected tokens
///
/// Route Update Timer, type [Timer]
/// - starts updating the Swap Route every 5 seconds after the first [updateRoute]
/// - can be [null] - means doesn`t update the Swap Route regularly
/// - can be stopped using the [stopUpdatingRoute] function
///
class PairModel extends ChangeNotifier {
  List<Token> _tokens = [kTokenA, kTokenB];
  SwapRoute? _route;
  DateTime _lastUpdate = DateTime.now();
  bool _loading = false;
  Timer? _routeUpdateTimer;

  Token get token0 => _tokens[0];
  Token get token1 => _tokens[1];
  SwapRoute? get route => _route;
  DateTime get lastUpdate => _lastUpdate;
  bool get loading => _loading;

  /// Static function to check pair token index
  ///
  /// Requires [pairTokenIndex] equals `0` or `1`
  static bool isPairTokenIndexValid(int pairTokenIndex) {
    return pairTokenIndex == 1 || pairTokenIndex == 0;
  }

  /// Checks that both tokens are selected (their addresses not empty)
  bool isTokensSelected() {
    return _tokens.every((e) => e.address.isNotEmpty);
  }

  /// Checks that [token] is one of the Selected Tokens
  bool isTokenInPair(Token token) {
    return _tokens.any((e) => e == token);
  }

  /// Requires [pairTokenIndex] equals `0` or `1`
  void setTokenByIndex(int pairTokenIndex, Token token) {
    if (isPairTokenIndexValid(pairTokenIndex)) {
      _tokens[pairTokenIndex] = token;
    } else {
      throw Exception('PairModel: Incorrect pairTokenIndex');
    }
  }

  /// Swap selected tokens
  ///
  /// if [shouldUpdateRoute] calls [updateRoute]
  Future<void> swapTokens([bool shouldUpdateRoute = false]) async {
    _tokens = [_tokens[1], _tokens[0]];
    notifyListeners();
    if (shouldUpdateRoute) {
      await updateRoute();
    }
  }

  /// Updates [route] and inits every 5 seconds updating [route] if it hasn't already been done
  ///
  /// Edits [loading] for first update
  Future<void> updateRoute() async {
    _loading = true;
    notifyListeners();

    await _updateRoute();
    if (_routeUpdateTimer == null || !_routeUpdateTimer!.isActive) {
      _routeUpdateTimer =
          Timer.periodic(const Duration(seconds: 5), (timer) async {
        await _updateRoute();
      });
    }

    _loading = false;
    notifyListeners();
  }

  /// Stops regular [route] updating
  void stopUpdatingRoute() {
    _routeUpdateTimer?.cancel();
  }

  /// Private function that updates [route] and [lastUpdate]
  ///
  /// Computes best [SwapRoute] for Selected Tokens
  Future<void> _updateRoute() async {
    _lastUpdate = DateTime.now();

    final List<PairReserves> allPairReserves =
        await fetchAllPairReserves(_tokens[0], _tokens[1]);

    final TokenAmount tokenAmountIn = TokenAmount(
      token: _tokens[0],
      amount: BigInt.from(pow(10, _tokens[0].decimals)),
    );

    _route = findBestRoute(
      pairs: allPairReserves,
      tokenAmountIn: tokenAmountIn,
      tokenOut: _tokens[1],
      originalAmountIn: tokenAmountIn,
    );

    notifyListeners();
  }
}
