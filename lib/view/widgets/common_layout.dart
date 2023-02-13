import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'package:pancake_rates/domain/model/pair_model.dart';
import 'package:pancake_rates/view/widgets/custom_icon_button.dart';
import 'package:pancake_rates/constants.dart';

/// Widget with App common layout
///
/// - Requires [title], [String] - text for header
///
/// - Requires [child], [Widget] - child widget
///
/// - [isBackButton], [bool] = [false] - if [true] build button that routes to [PairChoiceScreen] and calls [stopUpdatingRoute] function
class CommonLayout extends StatelessWidget {
  final String title;
  final Widget child;
  final bool isBackButton;

  const CommonLayout({
    super.key,
    required this.title,
    required this.child,
    this.isBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<PairModel>();

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Stack(
                children: [
                  if (isBackButton)
                    CustomIconButton(
                      icon: const Icon(Icons.arrow_back),
                      onTap: () {
                        context.goNamed('pair_choice');
                        model.stopUpdatingRoute();
                      },
                    ),
                  SizedBox(
                    height: 50.0,
                    child: Center(
                      child: Text(
                        title,
                        style: const TextStyle(fontSize: KDefaultFZ.medium),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
