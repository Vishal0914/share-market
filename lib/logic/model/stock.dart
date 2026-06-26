class Stock {
  final String name;
  final String symbol;
  double price;
  double change;

  Stock({required this.name, required this.symbol, required this.price})
      : change = 0;

  bool get isUp => change >= 0;
}