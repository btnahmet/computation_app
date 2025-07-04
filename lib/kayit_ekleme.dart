import 'package:flutter/material.dart';
import 'package:computation_app/ogun_ekleme.dart';
// import 'tahsilat.dart';

class KayitEkleme extends StatefulWidget {
  const KayitEkleme({
    super.key,
    required this.title,
    this.existingCustomer, // Mevcut müşteri bilgileri
  });

  final String title;
  final Map<String, dynamic>? existingCustomer;

  @override
  State<KayitEkleme> createState() => _KayitEklemeState();
}

class _KayitEklemeState extends State<KayitEkleme> {
  late TextEditingController _dateController;
  late TextEditingController _textController;
  late TextEditingController _totalDebtController;

  List<Map<String, dynamic>> _meals = []; // Öğünlerin listesi

  @override
  void initState() {
    super.initState();

    // Başlangıç değerleri
    _dateController = TextEditingController(
        text: widget.existingCustomer?['date']?.toString() ?? ''); // Tarih
    _textController = TextEditingController(
        text: widget.existingCustomer?['name']?.toString() ?? ''); // İsim
    _totalDebtController = TextEditingController(
        text: widget.existingCustomer?['totalDebt']?.toString() ?? '0.0'); // Borç

    // Öğünler mevcutsa yükle
    _meals = widget.existingCustomer?['meals'] ?? [];
  }

  @override
  void dispose() {
    _dateController.dispose();
    _textController.dispose();
    _totalDebtController.dispose();
    super.dispose();
  }

  void _updateTotalDebt() {
    double totalDebt = 0.0;
    for (var meal in _meals) {
      totalDebt += double.tryParse(meal['cost3']?.toString() ?? '0.0') ?? 0.0;
    }
    _totalDebtController.text = totalDebt.toStringAsFixed(2);
  }

  void _addMeal(
      String mealName, double mealCost3, double mealCost2, double mealCost1) {
    setState(() {
      _meals.add({
        'name': mealName,
        'cost3': mealCost3,
        'cost2': mealCost2,
        'cost1': mealCost1,
      });
      _updateTotalDebt(); // Borcu güncelle
    });
  }

  void _removeMeal(int index) {
    setState(() {
      _meals.removeAt(index);
      _updateTotalDebt(); // Borcu güncelle
    });
  }

  void _confirmDelete2(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text("Silme Onayı"),
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
                _removeMeal(index); // Kaydı sil
              },
              // style: ElevatedButton.styleFrom(
              //   backgroundColor: Colors.red,
              // ),
              child: const Text("Evet"),
            ),
          ],
        );
      },
    );
  }

  void _editMeal(int index, String newMealName, double newMealCost3,
      double newMealCost2, double newMealCost1) {
    setState(() {
      _meals[index] = {
        'name': newMealName,
        'cost3': newMealCost3,
        'cost2': newMealCost2,
        'cost1': newMealCost1,
      };
      _updateTotalDebt(); // Borcu güncelle
    });
  }

  void _navigateToMealAddPage(
      {String? currentMealName,
      double? currentMealCost3,
      double? currentMealCost2,
      double? currentMealCost1,
      int? index}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OgunEkleme(
          title: 'Öğün Ekleme',
          onSave: (mealName, mealCost3, mealCost2, mealCost1) {
            if (index != null) {
              _editMeal(index, mealName, mealCost3, mealCost2, mealCost1);
            } else {
              _addMeal(mealName, mealCost3, mealCost2, mealCost1);
            }
          },
          initialMealName: currentMealName,
          initialMealCost3: currentMealCost3,
          initialMealCost2: currentMealCost2,
          initialMealCost1: currentMealCost1,
        ),
      ),
    );
  }

  void _saveData() {
    Map<String, dynamic> customerData = {
      'date': _dateController.text,
      'name': _textController.text,
      'totalDebt': _totalDebtController.text,
      'meals': _meals,
    };
    Navigator.pop(context, customerData);
  }

//   void _saveData() {
//   // Tahsilat bilgilerini ve güncel borcu koruyarak verileri kaydet
//   Map<String, dynamic> customerData = {
//     'date': _dateController.text,
//     'name': _textController.text,
//     'totalDebt': _totalDebtController.text,
//     'meals': _meals,
//     'payments': widget.existingCustomer?['payments'] ?? [], // Tahsilat bilgisi
//     'currentDebt': widget.existingCustomer?['currentDebt'] ?? double.parse(_totalDebtController.text), // Güncel borç
//   };
//   Navigator.pop(context, customerData);
// }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF00796B),
          title: Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _dateController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Tarih Seçin',
                    suffixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _dateController.text =
                            "${pickedDate.toLocal()}".split(' ')[0];
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    labelText: 'İsim - Soyisim - Köy',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _totalDebtController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Müşteri Toplam Borcu',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _navigateToMealAddPage();
                  },
                  child: const Text("Öğün Ekleme"),
                ),
                const SizedBox(height: 20),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _meals.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          title: Text('${_meals[index]['name']?.toString() ?? ''}'),
                          subtitle:
                              Text('Toplam Maliyet: ${_meals[index]['cost3']?.toString() ?? '0.0'}₺'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  _navigateToMealAddPage(
                                    currentMealName: _meals[index]['name']?.toString(),
                                    currentMealCost3: double.tryParse(_meals[index]['cost3']?.toString() ?? '0.0'),
                                    currentMealCost2: double.tryParse(_meals[index]['cost2']?.toString() ?? '0.0'),
                                    currentMealCost1: double.tryParse(_meals[index]['cost1']?.toString() ?? '0.0'),
                                    index: index,
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  _confirmDelete2(index);
                                },
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
        ),
        bottomNavigationBar: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: _saveData,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Müşteriyi Kaydet",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
