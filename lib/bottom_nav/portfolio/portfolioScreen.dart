import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_market/bottom_nav/tradeDialog.dart';

import '../../logic/provider/stock_provider.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StockProvider>();
    final portfolio = provider.portfolio;
    final stocks = provider.stocks;

    if (portfolio.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 48, color: Colors.grey),
            SizedBox(height: 12),
            Text('No holdings yet',
                style: TextStyle(color: Colors.grey, fontSize: 16)),
            SizedBox(height: 4),
            Text('Buy stocks from the Market tab',
                style: TextStyle(color: Colors.grey, fontSize: 13)),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Summary bar
        Container(
          color: Colors.white,
          padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _SummaryItem(
                  label: 'Invested',
                  value: '₹${provider.portfolioValue.toStringAsFixed(2)}',
                  color: Colors.blue),
              _SummaryItem(
                  label: 'Wallet',
                  value: '₹${provider.wallet.toStringAsFixed(2)}',
                  color: Colors.orange),
              _SummaryItem(
                  label: 'Net Worth',
                  value: '₹${provider.netWorth.toStringAsFixed(2)}',
                  color: Colors.green),
            ],
          ),
        ),
        const Divider(height: 1),
        // Holdings list
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: portfolio.length,
            separatorBuilder: (_, __) =>  SizedBox(height: 8),
            itemBuilder: (context, index) {
              final entry = portfolio.entries.elementAt(index);
              final stock =
              stocks.firstWhere((s) => s.symbol == entry.key);
              final totalValue = stock.price * entry.value.shares;

              return Card(
                child: ListTile(
                  contentPadding:  EdgeInsets.symmetric(
                      horizontal: 14, vertical: 6),
                  leading: CircleAvatar(
                    backgroundColor: Colors.green.shade50,
                    child: Text(stock.symbol[0],
                        style:  TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                  ),
                  title: Text(stock.name,
                      style:  TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15)),
                  subtitle: Text(
                      '${entry.value.shares} shares  •  ₹${stock.price.toStringAsFixed(2)} each',
                      style:  TextStyle(
                          color: Colors.grey, fontSize: 12)),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('₹${totalValue.toStringAsFixed(2)}',
                          style:  TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.green)),
                       Text('Total Value',
                          style: TextStyle(
                              color: Colors.grey, fontSize: 11)),
                    ],
                  ),
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => TradeDialog(stock: stock),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _SummaryItem(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label,
            style:  TextStyle(fontSize: 11, color: Colors.grey)),
         SizedBox(height: 2),
        Text(value,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: color)),
      ],
    );
  }
}