import 'package:flutter/material.dart';

class Tahsilat extends StatefulWidget {
  const Tahsilat({super.key, required this.title, required this.totalDebt});
  final String title;
  final String totalDebt; // Toplam borç bilgisini almak için

  @override
  State<Tahsilat> createState() => _TahsilatState();
}

class _TahsilatState extends State<Tahsilat> {
  final List<TextEditingController> _controllers = [];
  final List<String> _labels = [
    "Toplam Borç",
    "Ödeyen Kişi",
    "Ödenen Miktar",
    "Güncel Borç"
  ];

  final TextEditingController _dateController = TextEditingController();
  final List<Map<String, String>> _payments = []; // Ödeme bilgileri listesi

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _labels.length; i++) {
      _controllers.add(TextEditingController());
    }
    // "Toplam Borç" alanını gelen veriyle doldur
    _controllers[0].text = widget.totalDebt; // Toplam Borç
    _controllers[3].text = widget.totalDebt; // Güncel Borç başlangıçta aynı
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _dateController.dispose();
    super.dispose();
  }

  void _addPayment() {
    // Ödeme bilgilerini al ve listeye ekle
    final payment = {
      "payer": _controllers[1].text, // Ödeyen Kişi
      "date": _dateController.text, // Tahsilat Tarihi
      "amount": _controllers[2].text // Ödenen Miktar
    };

    setState(() {
      _payments.add(payment);
      // Formu temizle
      _controllers[1].clear();
      _controllers[2].clear();
      _dateController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: const Color(0xFF00796B),
          title: Text(
            "MÜŞTERİ TAHSİLAT BİLGİSİ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    controller: _controllers[0],
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: _labels[0],
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    controller: _dateController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: "Tahsilat Tarihi",
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
                ),
                ...List.generate(
                  _controllers.length - 2,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: TextFormField(
                      controller: _controllers[index + 1],
                      decoration: InputDecoration(
                        labelText: _labels[index + 1],
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    controller: _controllers[3],
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: _labels[3],
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: _addPayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Ödeme Ekle",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Ödemeler",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _payments.length,
                  itemBuilder: (context, index) {
                    final payment = _payments[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16.0),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ödeyen Kişi: ${payment['payer']}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Tahsilat Tarihi: ${payment['date']}",
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              "Ödenen Miktar: ${payment['amount']}₺",
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              _saveData();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Tahsilat Kaydet",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  void _saveData() {
    List<String> collectedData =
        _controllers.map((controller) => controller.text).toList();
    print("Toplam Borç: ${collectedData[0]}");
    print("Tahsilat Tarihi: ${_dateController.text}");
    print("Ödeyen Kişi: ${collectedData[1]}");
    print("Ödenen Miktar: ${collectedData[2]}");
    print("Güncel Borç: ${collectedData[3]}");
  }
}
