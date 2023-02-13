import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pancake_rates/domain/model/pair_model.dart';
import 'package:pancake_rates/domain/model/token_list_model.dart';

import 'package:pancake_rates/view/router.dart';

void main() {
  runApp(const PancakeRatesApp());
}

class PancakeRatesApp extends StatelessWidget {
  const PancakeRatesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PairModel()),
        ChangeNotifierProvider(create: (context) => TokenListModel()),
      ],
      child: MaterialApp.router(
        title: 'Pancake Rates',
        routerConfig: router(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
