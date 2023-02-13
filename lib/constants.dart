// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:pancake_rates/domain/entities/token.dart';

const Color kPrimaryColor = Color(0xFFFFE082);
const Color kBackgroundColor = Color(0xFFFFF8E1);

abstract class KDefaultFZ {
  static const small = 16.0;
  static const medium = 32.0;
  static const large = 64.0;
}

const Token kTokenA = Token(
  symbol: 'Token A',
  address: '',
  decimals: 0,
  logoURI: '',
);
const Token kTokenB = Token(
  symbol: 'Token B',
  address: '',
  decimals: 0,
  logoURI: '',
);

const String PANCAKESWAP_FACTORY_ADDRESS =
    '0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73';
const String PANCAKESWAP_INIT_CODE_HASH =
    '0x00fb7f630766e6a796048ea87d01acd3068e8ff67d078148a3fa3f4a84f69bd5';

const List<Token> kDefaultSwapTokens = [
  Token(
    symbol: 'WBNB',
    address: '0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c',
    decimals: 18,
    logoURI:
        'https://tokens.pancakeswap.finance/images/0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c.png',
  ),
  Token(
    symbol: 'CAKE',
    address: '0x0E09FaBB73Bd3Ade0a17ECC321fD13a19e81cE82',
    decimals: 18,
    logoURI:
        'https://tokens.pancakeswap.finance/images/0x0E09FaBB73Bd3Ade0a17ECC321fD13a19e81cE82.png',
  ),
  Token(
    symbol: 'BUSD',
    address: '0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56',
    decimals: 18,
    logoURI:
        'https://tokens.pancakeswap.finance/images/0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56.png',
  ),
  Token(
    symbol: 'USDT',
    address: '0x55d398326f99059fF775485246999027B3197955',
    decimals: 18,
    logoURI:
        'https://tokens.pancakeswap.finance/images/0x55d398326f99059fF775485246999027B3197955.png',
  ),
  Token(
    symbol: 'BTCB',
    address: '0x7130d2A12B9BCbFAe4f2634d864A1Ee1Ce3Ead9c',
    decimals: 18,
    logoURI:
        'https://tokens.pancakeswap.finance/images/0x7130d2A12B9BCbFAe4f2634d864A1Ee1Ce3Ead9c.png',
  ),
  Token(
    symbol: 'ETH',
    address: '0x2170Ed0880ac9A755fd29B2688956BD959F933F8',
    decimals: 18,
    logoURI:
        'https://tokens.pancakeswap.finance/images/0x2170Ed0880ac9A755fd29B2688956BD959F933F8.png',
  ),
  Token(
    symbol: 'USDC',
    address: '0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d',
    decimals: 18,
    logoURI:
        'https://tokens.pancakeswap.finance/images/0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d.png',
  ),
];
