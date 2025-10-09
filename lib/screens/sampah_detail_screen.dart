import 'package:flutter/material.dart';

class SampahDetailScreen extends StatelessWidget {
  final Map<String, dynamic> categoryData;

  const SampahDetailScreen({super.key, required this.categoryData});

  @override
  Widget build(BuildContext context) {
    final categoryName = categoryData['name'] as String;
    final icon = categoryData['icon'] as String;
    final subCategories = categoryData['subCategories'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Harga Detail $categoryName',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(icon, style: const TextStyle(fontSize: 32)),
                const SizedBox(width: 8),
                Text(
                  'Daftar Harga $categoryName',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: subCategories.length,
                itemBuilder: (context, index) {
                  final item = subCategories[index] as Map<String, String>;
                  return Card(
                    elevation: 1,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  item['subName']!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                item['price']!,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: (item['price'] == 'Negotiable')
                                      ? Colors.red
                                      : Colors.green.shade700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['desc']!,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
