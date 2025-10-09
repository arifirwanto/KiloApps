import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SetorSampahScreen extends StatefulWidget {
  const SetorSampahScreen({super.key});

  @override
  State<SetorSampahScreen> createState() => _SetorSampahScreenState();
}

class _SetorSampahScreenState extends State<SetorSampahScreen> {
  String? selectedCategory;
  String? selectedSubCategory;
  double? selectedPrice;
  double total = 0;
  String? selectedPengepul;
  XFile? buktiFoto;

  final picker = ImagePicker();

  final Map<String, List<Map<String, dynamic>>> kategoriData = {
    'Plastik': [
      {'subName': 'Botol', 'price': 2000.0},
      {'subName': 'Gelas', 'price': 1500.0},
    ],
    'Kertas': [
      {'subName': 'Koran', 'price': 2500.0},
      {'subName': 'Karton', 'price': 1800.0},
    ],
    'Logam': [
      {'subName': 'Kaleng', 'price': 5000.0},
      {'subName': 'Besi', 'price': 7000.0},
    ],
  };

  Future<void> pilihFoto() async {
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() {
        buktiFoto = picked;
      });
    }
  }

  void konfirmasiSetor() async {
    if (selectedCategory == null ||
        selectedSubCategory == null ||
        selectedPengepul == null ||
        buktiFoto == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Lengkapi semua data sebelum konfirmasi."),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    Navigator.pop(context); // tutup loading
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Setoran berhasil dikirim!")));

    Navigator.pop(context); // kembali ke halaman sebelumnya
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setor Sampah"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Pilih kategori
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Pilih Kategori Sampah",
                border: OutlineInputBorder(),
              ),
              initialValue: selectedCategory,
              items: kategoriData.keys
                  .map(
                    (kategori) => DropdownMenuItem(
                      value: kategori,
                      child: Text(kategori),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                  selectedSubCategory = null;
                  selectedPrice = null;
                });
              },
            ),
            const SizedBox(height: 16),

            // 🔹 Pilih sub kategori
            if (selectedCategory != null)
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Pilih Jenis Sampah",
                  border: OutlineInputBorder(),
                ),
                initialValue: selectedSubCategory,
                items: kategoriData[selectedCategory]!
                    .map(
                      (item) => DropdownMenuItem(
                        value: item['subName'] as String,
                        child: Text(
                          "${item['subName']} - Rp${item['price'].toStringAsFixed(0)}/kg",
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSubCategory = value;
                    selectedPrice = kategoriData[selectedCategory]!.firstWhere(
                      (item) => item['subName'] == value,
                    )['price'];
                  });
                },
              ),
            const SizedBox(height: 16),

            // 🔹 Input berat
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Berat Sampah (kg)",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (val) {
                final berat = double.tryParse(val) ?? 0;
                setState(() {
                  total = (selectedPrice ?? 0) * berat;
                });
              },
            ),
            const SizedBox(height: 16),

            // 🔹 Pilih pengepul
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Pilih Pengepul",
                border: OutlineInputBorder(),
              ),
              initialValue: selectedPengepul,
              items: ["Pengepul A", "Pengepul B", "Pengepul C"]
                  .map(
                    (nama) => DropdownMenuItem(value: nama, child: Text(nama)),
                  )
                  .toList(),
              onChanged: (val) => setState(() => selectedPengepul = val),
            ),
            const SizedBox(height: 16),

            // 🔹 Upload bukti foto
            ElevatedButton.icon(
              icon: const Icon(Icons.camera_alt),
              label: const Text("Upload Bukti Foto"),
              onPressed: pilihFoto,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
            if (buktiFoto != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(buktiFoto!.path),
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

            const SizedBox(height: 20),

            // 🔹 Total hasil
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Total Estimasi: Rp${total.toStringAsFixed(0)}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 🔹 Tombol konfirmasi
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: konfirmasiSetor,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 20,
                  ),
                ),
                child: const Text(
                  "Konfirmasi Setor",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
