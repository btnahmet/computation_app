import 'package:flutter/material.dart';
import 'tahsilat.dart';
import 'kayit_ekleme.dart';
import 'database_helper.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key, required this.title});
  final String title;

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  List<Map<String, dynamic>> _customers = []; // Müşteri listesi
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadCustomers();
  }

  Future<void> _loadCustomers() async {
    final customers = await _databaseHelper.getCustomers();
    List<Map<String, dynamic>> newCustomers = [];
    for (var customer in customers) {
      final meals = await _databaseHelper.getMeals(customer['id']);
      final payments = await _databaseHelper.getPaymentsAsStringMap(customer['id']);
      newCustomers.add({
        ...customer,
        'meals': meals,
        'payments': payments,
      });
    }
    setState(() {
      _customers = newCustomers;
    });
  }

  // Yeni müşteri ekleme
  void _navigateToKayitEkleme() async {
    final customerData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const KayitEkleme(title: "Yeni Müşteri Kaydı"),
      ),
    );
    if (customerData != null) {
      final customerId = await _databaseHelper.insertCustomer({
        'name': customerData['name'],
        'date': customerData['date'],
        'totalDebt': customerData['totalDebt'],
        'currentDebt': customerData['totalDebt'],
      });
      for (var meal in customerData['meals']) {
        await _databaseHelper.insertMeal({
          ...meal,
          'customerId': customerId,
        });
      }
      await _loadCustomers();
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
      double newTotalDebt = double.tryParse(updatedCustomer['totalDebt']?.toString() ?? '') ?? 0.0;
      double currentDebt = double.tryParse(customer['currentDebt']?.toString() ?? '') ?? 0.0;
      double previousTotalDebt = double.tryParse(customer['totalDebt']?.toString() ?? '') ?? 0.0;
      double debtDifference = newTotalDebt - previousTotalDebt;

      await _databaseHelper.updateCustomer({
        'id': customer['id'],
        'name': updatedCustomer['name'],
        'date': updatedCustomer['date'],
        'totalDebt': updatedCustomer['totalDebt'],
        'currentDebt': (currentDebt + debtDifference).toStringAsFixed(2),
      });

      // Mevcut öğünleri sil
      final meals = await _databaseHelper.getMeals(customer['id']);
      for (var meal in meals) {
        await _databaseHelper.deleteMeal(meal['id']);
      }

      // Yeni öğünleri ekle
      for (var meal in updatedCustomer['meals']) {
        await _databaseHelper.insertMeal({
          ...meal,
          'customerId': customer['id'],
        });
      }

      setState(() {
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
          totalDebt: customer['totalDebt']?.toString() ?? '0.0',
          previousPayments: (customer['payments'] as List<dynamic>)
            .map((e) {
              final newMap = <String, String>{};
              (e as Map).forEach((k, v) {
                newMap[k.toString()] = v?.toString() ?? '';
              });
              return newMap;
            }).toList(),
          customerId: customer['id'],
        ),
      ),
    );
    if (tahsilatData != null) {
      await _databaseHelper.updateCustomerDebt(
        customer['id'],
        double.parse(tahsilatData['currentDebt']),
      );
      await _loadCustomers();
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
                Navigator.of(context).pop();
              },
              child: const Text("Hayır"),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final customer = _customers[index];
                await _databaseHelper.deleteCustomer(customer['id']);
                await _loadCustomers();
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
                        subtitle: Text("Tarih: ${customer['date']?.toString()}"),
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
                            title: Text(
                                "Güncel Borç: ${customer['currentDebt']?.toString()}₺",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                ),
                            subtitle:
                                Text("Toplam Borç: ${customer['totalDebt']?.toString()}₺"),
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
                                  meal['name']?.toString() ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text("Maliyet: ${meal['cost3']?.toString()}₺"),
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
