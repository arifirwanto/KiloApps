import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  final List<Map<String, dynamic>> transaksi = const [
    {"title": "Setor Plastik", "date": "20 Apr 2024", "amount": "+Rp10.000"},
    {"title": "Tarik Saldo", "date": "15 Apr 2024", "amount": "-Rp50.000"},
    {"title": "Tukar Pulsa", "date": "15 Apr 2024", "amount": "-Rp26.000"},
    {"title": "Setor Kertas", "date": "10 Apr 2024", "amount": "+Rp2.500"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Riwayat Transaksi"),
      ),
      body: ListView.builder(
        itemCount: transaksi.length,
        itemBuilder: (context, index) {
          final item = transaksi[index];
          return ListTile(
            leading: const Icon(Icons.receipt_long, color: Colors.green),
            title: Text(item["title"]),
            subtitle: Text(item["date"]),
            trailing: Text(
              item["amount"],
              style: TextStyle(
                color: item["amount"].toString().startsWith("+")
                    ? Colors.green
                    : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}
