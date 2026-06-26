import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_market/bottom_nav/portfolio/portfolioScreen.dart';
import 'logic/provider/stock_provider.dart';
import 'bottom_nav/market/market_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final wallet = context.watch<StockProvider>().wallet;

    return Scaffold(
      appBar: AppBar(
        title:  Text('Stocks',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding:  EdgeInsets.only(right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                 Text('Wallet',
                    style: TextStyle(fontSize: 11, color: Colors.grey)),
                Text('₹${wallet.toStringAsFixed(2)}',
                    style:  TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
              ],
            ),
          ),
        ],
      ),
      body: _currentIndex == 0 ?  MarketScreen() :  PortfolioScreen(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blueAccent,
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.show_chart), label: 'Market'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet), label: 'Portfolio'),
        ],
      ),
    );
  }
}