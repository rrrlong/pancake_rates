import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:pancake_rates/domain/model/pair_model.dart';
import 'package:pancake_rates/domain/model/token_list_model.dart';
import 'package:pancake_rates/domain/entities/token.dart';

import 'package:pancake_rates/view/widgets/common_layout.dart';
import 'package:pancake_rates/view/widgets/token_widget.dart';
import 'package:pancake_rates/view/widgets/error_text.dart';

class TokenListScreen extends StatelessWidget {
  final int pairTokenIndex;

  const TokenListScreen({
    Key? key,
    required this.pairTokenIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TokenListModel>();

    return CommonLayout(
      title: 'Choose token',
      isBackButton: true,
      child: model.loading
          ? const Center(child: Text('loading'))
          : model.tokenList == null
              ? const Center(child: ErrorText())
              : ListView.builder(
                  padding: const EdgeInsets.only(top: 20.0),
                  shrinkWrap: true,
                  itemCount: model.tokenList!.length,
                  itemBuilder: (_, index) {
                    return TokenWidget(
                      token: model.tokenList![index],
                      onTap: () {
                        _onTokenSelected(
                          context,
                          model.tokenList![index],
                          pairTokenIndex,
                        );
                      },
                    );
                  },
                ),
    );
  }

  void _onTokenSelected(
      BuildContext context, Token selectedToken, int pairTokenIndex) {
    final pairModel = context.read<PairModel>();

    pairModel.isTokenInPair(selectedToken)
        ? pairModel.swapTokens()
        : pairModel.setTokenByIndex(pairTokenIndex, selectedToken);

    context.goNamed('pair_choice');
  }
}
