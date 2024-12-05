import 'package:flutter/material.dart';

class OgunEkleme extends StatefulWidget {
  const OgunEkleme({
    super.key,
    required this.title,
    required this.onSave,
    this.initialMealName,
    this.initialMealCost3,
    this.initialMealCost2,
    this.initialMealCost1,
  });
  final String title;
  final Function(String, double, double, double) onSave;
  final String? initialMealName;
  final double? initialMealCost3;
  final double? initialMealCost2;
  final double? initialMealCost1;

  @override
  State<OgunEkleme> createState() => _OgunEklemeState();
}

class _OgunEklemeState extends State<OgunEkleme> {
  TextEditingController _additionalController = TextEditingController();
  TextEditingController _numberController1 = TextEditingController();
  TextEditingController _numberController2 = TextEditingController();
  TextEditingController _numberController3 = TextEditingController();

  void _calculateResult() {
    double? number1 = double.tryParse(_numberController1.text);
    double? number2 = double.tryParse(_numberController2.text);

    if (number1 != null && number2 != null) {
      setState(() {
        _numberController3.text = (number1 * number2).toStringAsFixed(2);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen geçerli sayılar girin!")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialMealName != null) {
      _additionalController.text = widget.initialMealName!;
    }
    if (widget.initialMealCost3 != null) {
      _numberController3.text = widget.initialMealCost3!.toString();
    }
    if (widget.initialMealCost2 != null) {
      _numberController2.text = widget.initialMealCost2!.toString();
    }
    if (widget.initialMealCost1 != null) {
      _numberController1.text = widget.initialMealCost1!.toString();
    }
  }

  void _save() {
    final mealName = _additionalController.text;
    final mealCost3 = double.tryParse(_numberController3.text);
    final mealCost2 = double.tryParse(_numberController2.text);
    final mealCost1 = double.tryParse(_numberController1.text);

    if (mealName.isNotEmpty &&
        mealCost3 != null &&
        mealCost2 != null &&
        mealCost1 != null) {
      widget.onSave(mealName, mealCost3, mealCost2, mealCost1);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen tüm alanları doldurun!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.teal,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _additionalController,
                  decoration: InputDecoration(
                    labelText: 'Öğün İsmi',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.teal.shade50,
                    labelStyle: TextStyle(color: Colors.teal),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _numberController1,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Kişi Sayısı',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.teal.shade50,
                    labelStyle: TextStyle(color: Colors.teal),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _numberController2,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Güncel Porsiyon Fiyatı',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.teal.shade50,
                    labelStyle: TextStyle(color: Colors.teal),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _calculateResult,
                  child: const Text("Öğün Maliyetini Hesapla"),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _numberController3,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Toplam Maliyet',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.teal.shade50,
                    labelStyle: TextStyle(color: Colors.teal),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _save,
                  child: const Text("Kaydet"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}