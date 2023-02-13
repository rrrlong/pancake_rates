import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:pancake_rates/domain/model/pair_model.dart';
import 'package:pancake_rates/domain/model/token_list_model.dart';

import 'package:pancake_rates/view/widgets/common_layout.dart';
import 'package:pancake_rates/view/widgets/custom_icon_button.dart';
import 'package:pancake_rates/view/widgets/custom_text_button.dart';
import 'package:pancake_rates/view/widgets/token_widget.dart';

class PairChoiceScreen extends StatelessWidget {
  const PairChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pairModel = context.watch<PairModel>();
    final tokenListModel = context.read<TokenListModel>();

    return CommonLayout(
      title: 'Choose tokens',
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TokenWidget(
                  token: pairModel.token0,
                  onTap: () {
                    context
                        .goNamed('token_list', params: {'pairTokenIndex': '0'});
                    tokenListModel.loadTokens();
                  },
                ),
                const SizedBox(height: 20.0),
                const _SwapButton(),
                const SizedBox(height: 20.0),
                TokenWidget(
                  token: pairModel.token1,
                  onTap: () {
                    context
                        .goNamed('token_list', params: {'pairTokenIndex': '1'});
                    tokenListModel.loadTokens();
                  },
                ),
              ],
            ),
          ),
          const _WatchCourseButton(),
        ],
      ),
    );
  }
}

class _WatchCourseButton extends StatelessWidget {
  const _WatchCourseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final pairModel = context.read<PairModel>();

    return CustomTextButton(
      text: 'Watch course',
      onTap: () {
        if (pairModel.isTokensSelected()) {
          context.goNamed('pair_rate');
          pairModel.updateRoute();
        }
      },
    );
  }
}

class _SwapButton extends StatelessWidget {
  const _SwapButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final pairModel = context.read<PairModel>();

    return CustomIconButton(
      icon: const Icon(Icons.swap_vert),
      onTap: pairModel.swapTokens,
    );
  }
}
