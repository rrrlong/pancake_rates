import 'package:flutter/material.dart';

import 'package:pancake_rates/domain/data_providers/tokens_data_provider.dart';
import 'package:pancake_rates/domain/entities/token.dart';

import 'package:pancake_rates/constants.dart';

/// ### Stores:
/// Token List, type List<[Token]>
/// - has getter [tokenList]
/// - can be [null]
/// - can be updated using the [loadTokens] function
///
/// Loading, type [bool]
/// - has getter [loading]
/// - [true] when await for [loadTokens] function
///
class TokenListModel extends ChangeNotifier {
  List<Token>? _tokenList;
  bool _loading = false;

  List<Token>? get tokenList => _tokenList;
  bool get loading => _loading;

  /// if [tokenList] is [null] fetches PancakeSwap tokens
  ///
  /// Updates [loading]
  Future<void> loadTokens() async {
    if (_tokenList == null) {
      _loading = true;
      notifyListeners();

      final allTokens = await fetchPancakeSwapTokens();
      // if successful fetched tokens, adds default swap tokens to the beginning
      _tokenList =
          allTokens == null ? null : [...kDefaultSwapTokens, ...allTokens];

      _loading = false;
      notifyListeners();
    }
  }
}
