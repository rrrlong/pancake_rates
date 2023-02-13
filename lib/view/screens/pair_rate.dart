import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pancake_rates/domain/model/pair_model.dart';

import 'package:pancake_rates/view/widgets/common_layout.dart';
import 'package:pancake_rates/view/widgets/error_text.dart';
import 'package:pancake_rates/view/widgets/token_widget.dart';
import 'package:pancake_rates/view/widgets/custom_icon_button.dart';

import 'package:pancake_rates/utils/decorate_price.dart';
import 'package:pancake_rates/utils/formate_date.dart';
import 'package:pancake_rates/constants.dart';

class PairRateScreen extends StatelessWidget {
  const PairRateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      title: 'Pair course',
      isBackButton: true,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            _TokensRow(),
            SizedBox(
              height: 20.0,
            ),
            _RouteInfo(),
          ],
        ),
      ),
    );
  }
}

class _TokensRow extends StatelessWidget {
  const _TokensRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PairModel>();

    return Row(
      children: [
        Expanded(
          child: TokenWidget(
            token: model.token0,
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        CustomIconButton(
          icon: const Icon(Icons.swap_horiz),
          onTap: () => model.swapTokens(true),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: TokenWidget(
            token: model.token1,
          ),
        ),
      ],
    );
  }
}

class _RouteInfo extends StatelessWidget {
  const _RouteInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PairModel>();

    return model.loading
        ? const SizedBox(
            height: 140.0,
            child: Text('loading'),
          )
        : model.route == null
            ? const ErrorText()
            : Column(
                children: [
                  Text(
                    decoratePrice(model.route!.getPrice()),
                    style: const TextStyle(
                      fontSize: KDefaultFZ.large,
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    model.route!.toString(),
                    style: const TextStyle(
                      fontSize: KDefaultFZ.small,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    formateDate(model.lastUpdate),
                    style: const TextStyle(
                      fontSize: KDefaultFZ.small,
                    ),
                  ),
                ],
              );
  }
}
