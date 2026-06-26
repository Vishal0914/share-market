import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_market/bottom_nav/tradeDialog.dart';

import '../../logic/provider/stock_provider.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stocks = context.watch<StockProvider>().stocks;

    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: stocks.length,
      separatorBuilder: (_, __) =>  SizedBox(height: 8),
      itemBuilder: (context, index) {
        final stock = stocks[index];
        final changeColor = stock.isUp ? Colors.green : Colors.red;

        return Card(
          child: ListTile(
            contentPadding:
             EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade50,
              child: Text(stock.symbol[0],
                  style:  TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue)),
            ),
            title: Text(stock.name,
                style:  TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 15)),
            subtitle: Text(stock.symbol,
                style:  TextStyle(color: Colors.grey, fontSize: 12)),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('₹${stock.price.toStringAsFixed(2)}',
                    style:  TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15)),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                        stock.isUp
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        size: 12,
                        color: changeColor),
                     SizedBox(width: 2),
                    Text('₹${stock.change.abs().toStringAsFixed(2)}',
                        style: TextStyle(
                            color: changeColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
            onTap: () => showDialog(
              context: context,
              builder: (_) => TradeDialog(stock: stock),
            ),
          ),
        );
      },
    );
  }
}