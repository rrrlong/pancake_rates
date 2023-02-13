import 'package:flutter/services.dart';
import 'package:web3dart/crypto.dart';

/// Computes pair address using the Create2 function
///
/// Addresses of tokens must be sorted before
///
/// Requires [from] and [initCodeHash] like for [getCreate2Address] function
String getCreate2PairAddress(String from, String token0Address,
    String token1Address, String initCodeHash) {
  final Uint8List token0Bytes = hexToBytes(token0Address);
  final Uint8List token1Bytes = hexToBytes(token1Address);
  final Uint8List packedAddresses =
      Uint8List.fromList(token0Bytes + token1Bytes);
  final Uint8List salt = keccak256(packedAddresses);

  var pairAddress = getCreate2Address(from, salt, initCodeHash);
  return pairAddress;
}

/// An analog of ethers.utils.getCreate2Address function.
///
/// Docs: https://docs.ethers.org/v5/api/utils/address/#utils-getCreate2Address
///
/// Requires web3dart package to work
String getCreate2Address(String from, Uint8List salt, String initCodeHash) {
  final Uint8List part1 = hexToBytes('0xff');
  final Uint8List part2 = hexToBytes(from);
  final Uint8List part3 = salt;
  final Uint8List part4 = hexToBytes(initCodeHash);
  final Uint8List finalBytes =
      Uint8List.fromList(part1 + part2 + part3 + part4);

  final String rawHex = bytesToHex(keccak256(finalBytes));
  final String computedPairAddress = '0x${rawHex.substring(12 * 2)}';

  return computedPairAddress;
}
