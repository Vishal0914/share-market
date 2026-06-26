import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../logic/model/stock.dart';
import '../logic/provider/stock_provider.dart';

class TradeDialog extends StatefulWidget {
  final Stock stock;
  const TradeDialog({super.key, required this.stock});

  @override
  State<TradeDialog> createState() => _TradeDialogState();
}

class _TradeDialogState extends State<TradeDialog> {
  final _controller = TextEditingController(text: '1');
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int get _qty => int.tryParse(_controller.text) ?? 0;

  void _handle(String? Function(Stock, int) action) {
    final provider = context.read<StockProvider>();
    final err = action(widget.stock, _qty);
    if (err != null) {
      setState(() => _error = err);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StockProvider>();
    final stock = widget.stock;
    final owned = provider.sharesOwned(stock.symbol);
    final cost = _qty * stock.price;

    return AlertDialog(
      title: Text(stock.name),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Table(
              children: [
                _row('Price', '₹${stock.price.toStringAsFixed(2)}'),
                _row('Wallet', '₹${provider.wallet.toStringAsFixed(2)}'),
                _row('Owned', '$owned shares'),
              ],
            ),
             SizedBox(height: 14),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration:  InputDecoration(
                labelText: 'Quantity',
                prefixIcon: Icon(Icons.numbers),
              ),
              onChanged: (_) => setState(() => _error = null),
            ),
             SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text('Total Cost',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Text('₹${cost.toStringAsFixed(2)}',
                    style:  TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue)),
              ],
            ),
            if (_error != null) ...[
               SizedBox(height: 8),
              Text(_error!,
                  style:
                   TextStyle(color: Colors.red, fontSize: 12)),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child:  Text('Cancel')),
        ElevatedButton(
          style:
          ElevatedButton.styleFrom(backgroundColor: Colors.green),
          onPressed: () => _handle(context.read<StockProvider>().buyStock),
          child:  Text('BUY',
              style: TextStyle(color: Colors.white)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () =>
              _handle(context.read<StockProvider>().sellStock),
          child:  Text('SELL',
              style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  TableRow _row(String label, String value) => TableRow(children: [
    Padding(
      padding:  EdgeInsets.symmetric(vertical: 3),
      child: Text(label,
          style:
           TextStyle(color: Colors.grey, fontSize: 13)),
    ),
    Padding(
      padding:  EdgeInsets.symmetric(vertical: 3),
      child: Text(value,
          textAlign: TextAlign.right,
          style:  TextStyle(
              fontWeight: FontWeight.w600, fontSize: 13)),
    ),
  ]);
}