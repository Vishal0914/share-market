import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../model/portfoloioEntry.dart';
import '../model/stock.dart';

class StockProvider extends ChangeNotifier {
  final Random _rng = Random();
  Timer? _ticker;

  double _wallet = 10000;
  double get wallet => _wallet;

  final Map<String, PortfolioEntry> _portfolio = {};
  Map<String, PortfolioEntry> get portfolio => _portfolio;

  final List<Stock> _stocks = [
    Stock(name: 'Apple',     symbol: 'AAPL', price: 0),
    Stock(name: 'Tesla',     symbol: 'TSLA', price: 0),
    Stock(name: 'Amazon',    symbol: 'AMZN', price: 0),
    Stock(name: 'Google',    symbol: 'GOOG', price: 0),
    Stock(name: 'Microsoft', symbol: 'MSFT', price: 0),

  ];
  List<Stock> get stocks => _stocks;

  StockProvider() {
    for (final s in _stocks) {
      s.price = 100 + _rng.nextDouble() * 400;
    }
    _ticker = Timer.periodic( Duration(seconds: 2), (_) {
      for (final s in _stocks) {
        final delta = 1.0 + _rng.nextDouble() * 19;
        s.change = _rng.nextBool() ? delta : -delta;
        s.price = max(1.0, s.price + s.change);
      }
      notifyListeners();
    });
  }

  double get portfolioValue {
    double total = 0;
    for (final e in _portfolio.entries) {
      final s = _stocks.firstWhere((s) => s.symbol == e.key,
          orElse: () => Stock(name: '', symbol: '', price: 0));
      total += s.price * e.value.shares;
    }
    return total;
  }

  double get netWorth => _wallet + portfolioValue;

  int sharesOwned(String symbol) => _portfolio[symbol]?.shares ?? 0;

  String? buyStock(Stock stock, int qty) {
    if (qty <= 0) return 'Enter a valid quantity';
    final total = qty * stock.price;
    if (total > _wallet) return 'Insufficient balance';
    _wallet -= total;
    _portfolio.putIfAbsent(stock.symbol, () => PortfolioEntry(shares: 0));
    _portfolio[stock.symbol]!.shares += qty;
    notifyListeners();
    return null;
  }

  String? sellStock(Stock stock, int qty) {
    if (qty <= 0) return 'Enter a valid quantity';
    final owned = sharesOwned(stock.symbol);
    if (owned < qty) return 'Not enough shares to sell';
    _wallet += qty * stock.price;
    _portfolio[stock.symbol]!.shares -= qty;
    if (_portfolio[stock.symbol]!.shares == 0) _portfolio.remove(stock.symbol);
    notifyListeners();
    return null;
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }
}