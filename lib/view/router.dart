import 'package:go_router/go_router.dart';

import 'package:pancake_rates/domain/model/pair_model.dart';

import 'package:pancake_rates/view/screens/pair_choice.dart';
import 'package:pancake_rates/view/screens/pair_rate.dart';
import 'package:pancake_rates/view/screens/token_list.dart';

GoRouter router() {
  return GoRouter(
    initialLocation: '/pair_choice',
    routes: [
      GoRoute(
        path: '/pair_choice',
        name: 'pair_choice',
        builder: (context, state) => const PairChoiceScreen(),
        routes: [
          GoRoute(
            path: 'token_list/:pairTokenIndex',
            name: 'token_list',
            builder: (context, state) {
              final String? param = state.params['pairTokenIndex'];

              if (param != null) {
                final int pairTokenIndex = int.parse(param);
                if (PairModel.isPairTokenIndexValid(pairTokenIndex)) {
                  return TokenListScreen(
                    pairTokenIndex: pairTokenIndex,
                  );
                }
              }

              return const PairChoiceScreen();
            },
          ),
          GoRoute(
            path: 'pair_rate',
            name: 'pair_rate',
            builder: (context, state) => const PairRateScreen(),
          ),
        ],
      ),
    ],
  );
}
