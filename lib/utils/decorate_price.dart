/// Returns decorated price
///
/// Exsample:
/// ```dart
/// decoratePrice(321.0043523); // 321.00435
/// decoratePrice(54321.0043523); // 54321.004
/// decoratePrice(0.00435238692); // 0.0043523
/// ```
/// But:
/// ```dart
/// decoratePrice(10000000.123); // > 1000000
/// decoratePrice(0.000000123); // < 0.000001
/// ```
String decoratePrice(double price) {
  if (price < 0.000001) {
    return '< 0.000001';
  } else if (price > 1000000) {
    return '> 1000000';
  } else {
    final fractionDigits = 8 - price.round().toString().length;
    return price.toStringAsFixed(fractionDigits);
  }
}
