
import 'package:flutter/material.dart';
import 'tahsilat.dart';
import 'kayit_ekleme.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  List<Map<String, dynamic>> _customers = []; // Müşteri listesi

  // Yeni müşteri ekleme
  void _navigateToKayitEkleme() async {
    final customerData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const KayitEkleme(title: "Yeni Müşteri Kaydı"),
      ),
    );

    if (customerData != null) {
      setState(() {
        _customers.add({
          ...customerData,
          'payments': [], // Yeni müşteri için boş ödeme kaydı
          'currentDebt': customerData['totalDebt'], // Güncel borç toplam borç
        });
      });
    }
  }

  // Müşteri düzenleme
  void _editCustomer(int index) async {
    final customer = _customers[index];
    final updatedCustomer = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => KayitEkleme(
          title: "Müşteri Düzenle",
          existingCustomer: customer,
        ),
      ),
    );

    if (updatedCustomer != null) {
      setState(() {
        double newTotalDebt = double.tryParse(updatedCustomer['totalDebt']) ?? 0.0;
        double currentDebt = double.tryParse(customer['currentDebt']) ?? 0.0;

        // Borcu yalnızca eklenen öğün maliyeti kadar artır
        double previousTotalDebt = double.tryParse(customer['totalDebt']) ?? 0.0;
        double debtDifference = newTotalDebt - previousTotalDebt;

        _customers[index] = {
          ...customer,
          ...updatedCustomer,
          'currentDebt': (currentDebt + debtDifference).toStringAsFixed(2),
        };
      });
    }
  }

  // Tahsilat sayfasına yönlendirme
  void _navigateToTahsilat(int index) async {
    final customer = _customers[index];

    final tahsilatData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Tahsilat(
          title: "Tahsilat Bilgisi",
          totalDebt: customer['totalDebt'],
          previousPayments: customer['payments'] != null
              ? (customer['payments'] as List<dynamic>)
                  .map((e) => Map<String, String>.from(e))
                  .toList()
              : [],
        ),
      ),
    );

    if (tahsilatData != null) {
      setState(() {
        customer['payments'] = tahsilatData['payments'];
        customer['currentDebt'] = tahsilatData['currentDebt'];
      });
    }
  }

  // Silme işlemi için onay diyaloğu
  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text("Silmek istediğinizden emin misiniz?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Diyaloğu kapat
              },
              child: const Text("Hayır"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Diyaloğu kapat
                setState(() {
                  _customers.removeAt(index); // Kaydı sil
                });
              },
              child: const Text("Evet"),
            ),
          ],
        );
      },
    );
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
                    final customer = _customers[index];
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
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        subtitle: Text("Tarih: ${customer['date']}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _editCustomer(index),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Color.fromARGB(255, 22, 15, 14)),
                              onPressed: () => _confirmDelete(index),
                            ),
                          ],
                        ),
                        children: [
                          const Divider(),
                          ListTile(
                            title: Text("Toplam Borç: ${customer['totalDebt']}₺"),
                            subtitle:
                                Text("Güncel Borç: ${customer['currentDebt']}₺"),
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () => _navigateToTahsilat(index),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 80, 230, 215),
                              ),
                              child: const Text("Müşteri Tahsilat Bilgisi"),
                            ),
                          ),
                          const Divider(),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              "Öğünler",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          ...List.generate(customer['meals'].length,
                              (mealIndex) {
                            final meal = customer['meals'][mealIndex];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: ListTile(
                                title: Text(
                                  meal['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle:
                                    Text("Maliyet: ${meal['cost3']}₺"),
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
