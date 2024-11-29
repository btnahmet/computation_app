import 'package:flutter/material.dart';

class OgunEkleme extends StatefulWidget {
  const OgunEkleme({super.key, required this.title});
  final String title;

  @override
  State<OgunEkleme> createState() => _OgunEklemeState();
}

class _OgunEklemeState extends State<OgunEkleme> {
  TextEditingController _numberController1 = TextEditingController(); // İlk sayısal input controller
  TextEditingController _numberController2 = TextEditingController(); // İkinci sayısal input controller
  TextEditingController _numberController3 = TextEditingController(); // Üçüncü sayısal input controller
  TextEditingController _additionalController = TextEditingController(); // Yeni text field controller

  // Eşittir butonuna basıldığında yapılacak işlem
  void _calculateResult() {
    // Sayı 1 ve Sayı 2'yi al, çarpma işlemi yap
    double? number1 = double.tryParse(_numberController1.text);
    double? number2 = double.tryParse(_numberController2.text);

    if (number1 != null && number2 != null) {
      // Sonucu hesapla ve sayi3'e yerleştir
      setState(() {
        _numberController3.text = (number1 * number2).toString();
      });
    } else {
      // Eğer geçersiz giriş varsa kullanıcıya bilgi ver
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen geçerli sayılar girin!")),
      );
    }
  }

  // Kaydet butonuna basıldığında yapılacak işlem
  void _save() {
    // Burada istediğiniz işlemi gerçekleştirebilirsiniz
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Öğün Kaydedildi!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Yeni TextFormField - En üste ekleniyor
              TextFormField(
                controller: _additionalController,
                decoration: InputDecoration(
                  labelText: 'Öğün İsmi',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16), // Diğer alanlardan önce boşluk

              // Sayı 1
              TextFormField(
                controller: _numberController1,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Kişi Sayısı',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Sayı 2
              TextFormField(
                controller: _numberController2,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Güncel Porsiyon Fiyatı',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Eşittir Butonu
              ElevatedButton(
                onPressed: _calculateResult,
                child: const Text("Eşittir"),
              ),
              const SizedBox(height: 16),

              // Sayı 3 (Sonuç)
              TextFormField(
                controller: _numberController3,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Toplam Öğün Borcu',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Kaydet Butonu
              ElevatedButton(
                onPressed: _save,
                child: const Text("Kaydet"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
