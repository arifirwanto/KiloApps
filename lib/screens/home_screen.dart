import 'package:flutter/material.dart';
import 'profile_screen.dart';
import '../data/sampah_data.dart';
import 'sampah_detail_screen.dart';
import 'setor_sampah_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  double saldo = 120000; // saldo awal
  int poin = 500; // poin awal

  // Fungsi tarik saldo
  void tarikSaldo(double jumlah) {
    if (jumlah <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Jumlah tidak boleh 0 atau negatif")),
      );
      return;
    }

    if (jumlah > saldo) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Saldo tidak cukup")));
      return;
    }

    setState(() {
      saldo -= jumlah;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Berhasil tarik Rp${jumlah.toStringAsFixed(0)}")),
    );
  }

  // Dialog input tarik saldo
  void showTarikSaldoDialog() {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Tarik Saldo"),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: "Masukkan jumlah (Rp)"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                final input = double.tryParse(
                  controller.text.replaceAll(',', ''),
                );
                if (input != null) {
                  tarikSaldo(input);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Masukkan angka yang valid")),
                  );
                }
              },
              child: const Text("Tarik"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = allCategoriesData;
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth < 600 ? 4 : 5;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          '',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Material(
              color: Colors.transparent,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                splashColor: Colors.green.withAlpha(77),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
                child: const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 26, color: Colors.green),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🟢 Saldo Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.shade900.withAlpha(77),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ROW 1: Saldo Tunai
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Saldo (Cash)",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        Text(
                          "Rp${saldo.toStringAsFixed(0)}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // ROW 2: Poin Reward
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Poin Reward",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        Text(
                          "$poin Poin",
                          style: const TextStyle(
                            color: Colors.amberAccent,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 25,
                      thickness: 1,
                      color: Colors.white30,
                    ),

                    // ROW 3: Tombol Tarik Saldo
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: const Icon(
                          Icons.account_balance_wallet,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Tarik Saldo",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: showTarikSaldoDialog,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Colors.white,
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Harga Sampah Hari Ini",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),

              // 🧩 Grid Harga
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final item = categories[index];
                  return SampahItem(
                    key: ValueKey(item['gridLabel']),
                    iconEmoji: item['icon'],
                    label: item['gridLabel'],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SampahDetailScreen(categoryData: item),
                        ),
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 25),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SetorSampahScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Setor Sampah",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "Edukasi",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 380) {
                    return const Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        EdukasiCard(
                          key: ValueKey("cara_pilah"),
                          icon: Icons.lightbulb,
                          title: "Cara Pilah Sampah",
                        ),
                        SizedBox(height: 8),
                        EdukasiCard(
                          key: ValueKey("tantangan_minggu"),
                          icon: Icons.flag,
                          title: "Tantangan Minggu Ini",
                        ),
                        SizedBox(height: 8),
                        EdukasiCard(
                          key: ValueKey("tips_menabung"),
                          icon: Icons.attach_money,
                          title: "Tips Menabung",
                        ),
                      ],
                    );
                  }
                  return const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: EdukasiCard(
                          key: ValueKey("cara_pilah"),
                          icon: Icons.lightbulb,
                          title: "Cara Pilah Sampah",
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: EdukasiCard(
                          key: ValueKey("tantangan_minggu"),
                          icon: Icons.flag,
                          title: "Tantangan Minggu Ini",
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: EdukasiCard(
                          key: ValueKey("tips_menabung"),
                          icon: Icons.savings,
                          title: "Tips Menabung",
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// 🧩 Widget Item Grid (SampahItem)
class SampahItem extends StatelessWidget {
  final String iconEmoji;
  final String label;
  final VoidCallback? onTap;

  const SampahItem({
    super.key,
    required this.iconEmoji,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(iconEmoji, style: const TextStyle(fontSize: 32)),
              const SizedBox(height: 2),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 🧠 Reusable EdukasiCard (public)
class EdukasiCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const EdukasiCard({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.green, size: 28),
              const SizedBox(height: 6),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
