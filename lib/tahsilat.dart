import 'package:flutter/material.dart';
import 'database_helper.dart';

class Tahsilat extends StatefulWidget {
  const Tahsilat({
    super.key,
    required this.title,
    required this.totalDebt,
    this.previousPayments,
    required this.customerId,
  });

  final String title;
  final String totalDebt; // Toplam borç bilgisini almak için
  final List<Map<String, String>>? previousPayments; // Önceki ödemeler
  final int customerId;

  @override
  State<Tahsilat> createState() => _TahsilatState();
}

class _TahsilatState extends State<Tahsilat> {
  final List<TextEditingController> _controllers = [];
  final List<String> _labels = [
    "Toplam Borç",
    "Ödeyen Kişi",
    "Ödenen Miktar",
    "Son Ödemeden Sonraki Güncel Borç"
  ];

  final TextEditingController _dateController = TextEditingController();
  late List<Map<String, String>> _payments;
  int? _editingIndex; // Düzenlenen ödeme için index
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _payments = <Map<String, String>>[];
    for (var e in (widget.previousPayments ?? [])) {
      if (e is Map) {
        final newMap = <String, String>{};
        e.forEach((k, v) {
          newMap[k.toString()] = v?.toString() ?? '';
        });
        _payments.add(newMap);
      }
    }
    for (int i = 0; i < _labels.length; i++) {
      _controllers.add(TextEditingController());
    }
    _controllers[0].text = widget.totalDebt;
    _updateCurrentDebt();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _dateController.dispose();
    super.dispose();
  }

  void _updateCurrentDebt() {
    double totalDebt = double.tryParse(widget.totalDebt.toString()) ?? 0.0;
    double totalPaid = _payments.fold(0.0, (sum, payment) {
      return sum + (double.tryParse(payment['amount'].toString()) ?? 0.0);
    });

    setState(() {
      _controllers[3].text = (totalDebt - totalPaid).toStringAsFixed(2);
    });
  }

  Future<void> _addOrUpdatePayment() async {
    if (_editingIndex != null) {
      final payment = _payments[_editingIndex!];
      await _databaseHelper.updatePayment({
        'id': int.parse(payment['id'] ?? '0'),
        'payer': _controllers[1].text,
        'date': _dateController.text,
        'amount': _controllers[2].text,
        'customerId': widget.customerId,
      });
      setState(() {
        _payments[_editingIndex!] = {
          'id': payment['id'] ?? '',
          'payer': _controllers[1].text,
          'date': _dateController.text,
          'amount': _controllers[2].text,
        }.map((k, v) => MapEntry(k.toString(), v?.toString() ?? ''));
        _editingIndex = null;
      });
    } else {
      final paymentId = await _databaseHelper.insertPayment({
        'payer': _controllers[1].text,
        'date': _dateController.text,
        'amount': _controllers[2].text,
        'customerId': widget.customerId,
      });
      setState(() {
        _payments.add({
          'id': paymentId.toString(),
          'payer': _controllers[1].text,
          'date': _dateController.text,
          'amount': _controllers[2].text,
        }.map((k, v) => MapEntry(k.toString(), v?.toString() ?? '')));
      });
    }
    _controllers[1].clear();
    _controllers[2].clear();
    _dateController.clear();
    _updateCurrentDebt();
  }

  void _editPayment(int index) {
    // Düzenlenecek ödeme bilgilerini alanlara yükle
    final payment = _payments[index];
    _controllers[1].text = payment['payer']?.toString() ?? '';
    _dateController.text = payment['date']?.toString() ?? '';
    _controllers[2].text = payment['amount']?.toString() ?? '';
    setState(() {
      _editingIndex = index; // Düzenlenen ödeme indexi
    });
  }

  Future<void> _deletePayment(int index) async {
    // Silme işlemi öncesinde onay mesajı göster
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Ödemeyi Sil"),
          content: const Text("Bu ödemeyi silmek istediğinizden emin misiniz?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Diyaloğu kapat, silme işlemini iptal et
              },
              child: const Text("Hayır"),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context); // Diyaloğu kapat
                final payment = _payments[index];
                await _databaseHelper.deletePayment(int.parse(payment['id']!));
                setState(() {
                  _payments.removeAt(index); // Ödemeyi listeden sil
                  _updateCurrentDebt(); // Güncel borcu hesapla
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 236, 227, 226)),
              child: const Text("Evet"),
            ),
          ],
        );
      },
    );
  }

  void _saveAndReturn() {
    Navigator.pop(context, {
      "payments": _payments,
      "currentDebt": _controllers[3].text, // Güncel borç bilgisi
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
            widget.title,
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
                    onPressed: _addOrUpdatePayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      _editingIndex != null ? "Ödemeyi Güncelle" : "Ödeme Ekle",
                      style: const TextStyle(fontSize: 20),
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
                      child: ListTile(
                        title: Text("Ödeyen Kişi: ${payment['payer']}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Tahsilat Tarihi: ${payment['date']}"),
                            Text("Tahsil Edilen Miktar: ${payment['amount']}₺"),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _editPayment(index),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Color.fromARGB(255, 0, 0, 0)),
                              onPressed: () => _deletePayment(index),
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
            onPressed: _saveAndReturn,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Tahsilatı Kaydet",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
