import 'package:flutter/material.dart';
import 'package:computation_app/kayit_ekleme.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  List<Map<String, dynamic>> _customers = []; // Müşteri listesi

  // Kayıt Ekleme sayfasına yönlendirme ve veri alma
  void _navigateToKayitEkleme() async {
    final customerData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const KayitEkleme(title: "Yeni Müşteri Kaydı"),
      ),
    );

    if (customerData != null) {
      setState(() {
        _customers.add(customerData); // Gelen veriyi müşteri listesine ekle
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F6F9), // Yumuşak arka plan rengi
        appBar: AppBar(
          backgroundColor: const Color(0xFF00796B), // Teal rengi AppBar
          title: const Text(
            "MÜŞTERİ LİSTESİ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _customers.isEmpty
              ? const Center(
                  child: Text(
                    "Müşteri listesi burada görünecek.",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                )
              : ListView.builder(
                  itemCount: _customers.length,
                  itemBuilder: (context, index) {
                    var customer = _customers[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ExpansionTile(
                        leading: const Icon(Icons.account_circle,
                            color: Colors.teal),
                        title: Text(
                          "${customer['name']}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("Tarih: ${customer['date']}"),
                        children: [
                          ListTile(
                            title:
                                Text("Toplam Borç: ${customer['totalDebt']}₺"),
                          ),
                          const Divider(),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              "Öğünler:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ...List.generate(customer['meals'].length,
                              (mealIndex) {
                            var meal = customer['meals'][mealIndex];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: ListTile(
                                title: Text(meal['name']),
                                subtitle: Text("Maliyet: ${meal['cost3']}₺"),
                              ),
                            );
                          }),
                        ],
                      ),
                    );
                  },
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _navigateToKayitEkleme,
          backgroundColor: const Color(0xFF00796B),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
