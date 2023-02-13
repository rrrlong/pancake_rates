/// Class for ERC-20 token
class Token {
  final String symbol;
  final String address;
  final int decimals;
  final String logoURI;

  const Token({
    required this.symbol,
    required this.address,
    required this.decimals,
    required this.logoURI,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      symbol: json['symbol'],
      address: json['address'],
      decimals: json['decimals'],
      logoURI: json['logoURI'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (other is Token) {
      return address == other.address;
    }
    return false;
  }

  @override
  int get hashCode => address.hashCode;
}
