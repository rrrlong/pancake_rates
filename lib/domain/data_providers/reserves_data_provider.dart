import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import 'package:pancake_rates/domain/entities/token.dart';
import 'package:pancake_rates/domain/entities/pair.dart';
import 'package:pancake_rates/domain/entities/pair_reserves.dart';

import 'package:pancake_rates/utils/create2.dart';
import 'package:pancake_rates/constants.dart';

// public ankr rpcUrl for BSC
const String _rpcUrl = 'https://rpc.ankr.com/bsc';

late Web3Client _web3cient;
late ContractAbi _pairAbiCode;

/// Returns list of [PairReserves] for selected tokens and default swap tokens
Future<List<PairReserves>> fetchAllPairReserves(
    Token token0, Token token1) async {
  List<PairReserves> allReserves = [];

  // init _web3cient and _pairAbiCode
  await _init();

  final List<Token> allTokens = _getAllTokens(token0, token1);
  final Map<Pair, String> allPairAddresses = _getAllPairAddresses(allTokens);
  final List<Pair> allPairs = allPairAddresses.keys.toList();

  // getting reserves for all pairs
  await Future.wait(allPairs.map((pair) async {
    final List<dynamic> response =
        await _getPairReserves(_getPairContract(allPairAddresses[pair]!));
    if (response[0] != BigInt.zero) {
      allReserves.add(PairReserves(
        token0: pair.token0,
        token1: pair.token1,
        reserve0: response[0] as BigInt,
        reserve1: response[1] as BigInt,
      ));
    }
  }));

  _web3cient.dispose();

  return allReserves;
}

Future<void> _init() async {
  _web3cient = Web3Client(
    _rpcUrl,
    Client(),
  );

  final String abiJson =
      await rootBundle.loadString('lib/domain/abi/IPancakePair.json');
  _pairAbiCode = ContractAbi.fromJson(abiJson, 'pair');
}

/// Returns seected tokens + default swap tokens
List<Token> _getAllTokens(Token token0, Token token1) {
  List<Token> allTokens = [token0, token1];
  for (final token in kDefaultSwapTokens) {
    if (!allTokens.contains(token)) {
      allTokens.add(token);
    }
  }
  return allTokens;
}

/// Returns all unique [Pair]s and their pair contract addresses
///
/// Computes pair contract addresses using the Create2 function
///
/// Note: computed pair contract address may not exist
Map<Pair, String> _getAllPairAddresses(List<Token> allTokens) {
  Map<Pair, String> allPairs = {};

  for (final Token token0 in allTokens) {
    for (final Token token1 in allTokens) {
      if (token0 == token1) continue;

      final Pair currentPair = Pair.sorted(token0, token1);
      if (allPairs.containsKey(currentPair)) continue;

      final String pairAddress = _getPairAddress(
        currentPair.token0.address,
        currentPair.token1.address,
      );
      allPairs[currentPair] = pairAddress;
    }
  }

  return allPairs;
}

/// Returns the pair contract address for PancakeSwap computed using the Create2 function
///
/// Note: computed pair contract address may not exist
String _getPairAddress(String strToken0Address, String strToken1Address) {
  return getCreate2PairAddress(
    PANCAKESWAP_FACTORY_ADDRESS,
    strToken0Address,
    strToken1Address,
    PANCAKESWAP_INIT_CODE_HASH,
  );
}

DeployedContract _getPairContract(String pairAddress) {
  return DeployedContract(_pairAbiCode, EthereumAddress.fromHex(pairAddress));
}

/// Returns response of pair contract 'getReserves' call
///
/// Returns list of [BigInt.zero] if pair contract does not exist
Future<List<dynamic>> _getPairReserves(DeployedContract pairContract) async {
  try {
    final List<dynamic> response = await _web3cient.call(
      contract: pairContract,
      function: pairContract.function('getReserves'),
      params: [],
    );
    return response;
  } catch (error) {
    // catching error means that the pair of current tokens does not exist
    return List.filled(3, BigInt.zero);
  }
}
