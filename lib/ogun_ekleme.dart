// import 'package:flutter/material.dart';

// class OgunEkleme extends StatefulWidget {
//   const OgunEkleme({super.key, required this.title, required this.onSave});
//   final String title;
//   final Function(String, double) onSave; // Öğün kaydetme fonksiyonu

//   @override
//   State<OgunEkleme> createState() => _OgunEklemeState();
// }

// class _OgunEklemeState extends State<OgunEkleme> {
//   TextEditingController _numberController1 = TextEditingController(); // İlk sayısal input controller
//   TextEditingController _numberController2 = TextEditingController(); // İkinci sayısal input controller
//   TextEditingController _numberController3 = TextEditingController(); // Üçüncü sayısal input controller
//   TextEditingController _additionalController = TextEditingController(); // Öğün ismi için controller

//   // Eşittir butonuna basıldığında yapılacak işlem
//   void _calculateResult() {
//     double? number1 = double.tryParse(_numberController1.text);
//     double? number2 = double.tryParse(_numberController2.text);

//     if (number1 != null && number2 != null) {
//       setState(() {
//         _numberController3.text = (number1 * number2).toString();
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Lütfen geçerli sayılar girin!")),
//       );
//     }
//   }

//   // Kaydet butonuna basıldığında yapılacak işlem
//   void _save() {
//     final mealName = _additionalController.text;
//     final mealCost = double.tryParse(_numberController3.text);

//     if (mealName.isNotEmpty && mealCost != null) {
//       widget.onSave(mealName, mealCost);
//       Navigator.pop(context); // Kayıt ekleme sayfasına dön
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Lütfen tüm alanları doldurun!")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title,
//           style: TextStyle(
//             fontWeight: FontWeight.bold
//           ),),
//           backgroundColor: Color.fromARGB(255, 40, 216, 198), // AppBar rengini yeşil yapıyoruz
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Öğün İsmi
//                 TextFormField(
//                   controller: _additionalController,
//                   decoration: InputDecoration(
//                     labelText: 'Öğün İsmi',
//                     border: OutlineInputBorder(),
//                     filled: true,
//                     fillColor: Colors.teal.shade50, // Yumuşak arka plan rengi
//                     labelStyle: TextStyle(color: Colors.teal), // Etiket rengi
//                   ),
//                 ),
//                 const SizedBox(height: 16), // Diğer alanlardan önce boşluk

//                 // Sayı 1 (Kişi Sayısı)
//                 TextFormField(
//                   controller: _numberController1,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     labelText: 'Kişi Sayısı',
//                     border: OutlineInputBorder(),
//                     filled: true,
//                     fillColor: Colors.teal.shade50,
//                     labelStyle: TextStyle(color: Colors.teal),
//                   ),
//                 ),
//                 const SizedBox(height: 16), // Diğer alanlardan önce boşluk

//                 // Sayı 2 (Porsiyon Fiyatı)
//                 TextFormField(
//                   controller: _numberController2,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     labelText: 'Porsiyon Fiyatı',
//                     border: OutlineInputBorder(),
//                     filled: true,
//                     fillColor: Colors.teal.shade50,
//                     labelStyle: TextStyle(color: Colors.teal),
//                   ),
//                 ),
//                 const SizedBox(height: 16), // Diğer alanlardan önce boşluk

//                 // Eşittir Butonu
//                 ElevatedButton(
//                   onPressed: _calculateResult,
//                   style: ElevatedButton.styleFrom(
//                     // primary: Colors.teal, // Buton rengini yeşil yapıyoruz
//                   ),
//                   child: const Text("Eşittir"),
//                 ),
//                 const SizedBox(height: 16), // Buton ile diğer alanlar arasında boşluk

//                 // Sayı 3 (Sonuç)
//                 TextFormField(
//                   controller: _numberController3,
//                   readOnly: true,
//                   decoration: InputDecoration(
//                     labelText: 'Toplam Borç',
//                     border: OutlineInputBorder(),
//                     filled: true,
//                     fillColor: Colors.teal.shade50,
//                     labelStyle: TextStyle(color: Colors.teal),
//                   ),
//                 ),
//                 const SizedBox(height: 16), // Diğer alanlardan önce boşluk

//                 // Kaydet Butonu
//                 ElevatedButton(
//                   onPressed: _save,
//                   style: ElevatedButton.styleFrom(
//                     // primary: Colors.teal, // Buton rengini yeşil yapıyoruz
//                   ),
//                   child: const Text("Kaydet"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class OgunEkleme extends StatefulWidget {
  const OgunEkleme({super.key, required this.title, required this.onSave});
  final String title;
  final Function(String, double) onSave; // Öğün kaydetme fonksiyonu

  @override
  State<OgunEkleme> createState() => _OgunEklemeState();
}

class _OgunEklemeState extends State<OgunEkleme> {
  // Dinamik controller listesi
  final List<Map<String, dynamic>> _controllers = [];
  final List<String> _labels = ['Öğün İsmi', 'Kişi Sayısı', 'Güncel Porsiyon Fiyatı', 'Toplam Maliyet'];

  @override
  void initState() {
    super.initState();

    // Dinamik form alanlarını oluşturuyoruz
    for (int i = 0; i < _labels.length; i++) {
      _controllers.add({
        'label': _labels[i],
        'controller': TextEditingController(),
        'isReadonly': i == 3, // "Toplam Maliyet" readonly olacak
      });
    }
  }

  // Eşittir butonuna basıldığında yapılacak işlem
  void _calculateTotalCost() {
    double? personCount = double.tryParse(_controllers[1]['controller'].text);  // 'Kişi Sayısı' alanından
    double? portionPrice = double.tryParse(_controllers[2]['controller'].text);  // 'Güncel Porsiyon Fiyatı' alanından

    if (personCount != null && portionPrice != null) {
      double totalCost = personCount * portionPrice;
      setState(() {
        _controllers[3]['controller'].text = totalCost.toStringAsFixed(2); // Toplam maliyeti gösteriyoruz
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen geçerli sayılar girin!")),
      );
    }
  }

  // Kaydet butonuna basıldığında yapılacak işlem
  void _save() {
    final mealName = _controllers[0]['controller'].text;
    final mealCost = double.tryParse(_controllers[3]['controller'].text);

    if (mealName.isNotEmpty && mealCost != null) {
      widget.onSave(mealName, mealCost); // Öğün bilgilerini kaydetme fonksiyonuna gönder
      Navigator.pop(context); // Kayıt ekleme sayfasına geri dön
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen tüm alanları doldurun!")),
      );
    }
  }

  @override
  void dispose() {
    // Belleği temizlemek için controller'ları dispose etmeliyiz
    for (var controller in _controllers) {
      controller['controller'].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.teal, // AppBar rengini yeşil yapıyoruz
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Öğün İsmi
                TextFormField(
                  controller: _controllers[0]['controller'],
                  decoration: InputDecoration(
                    labelText: _controllers[0]['label'],
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.teal.shade50, // Yumuşak arka plan rengi
                    labelStyle: TextStyle(color: Colors.teal), // Etiket rengi
                  ),
                ),
                const SizedBox(height: 16),

                // Kişi Sayısı
                TextFormField(
                  controller: _controllers[1]['controller'],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: _controllers[1]['label'],
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.teal.shade50,
                    labelStyle: TextStyle(color: Colors.teal),
                  ),
                ),
                const SizedBox(height: 16),

                // Güncel Porsiyon Fiyatı
                TextFormField(
                  controller: _controllers[2]['controller'],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: _controllers[2]['label'],
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.teal.shade50,
                    labelStyle: TextStyle(color: Colors.teal),
                  ),
                ),
                const SizedBox(height: 16),

                // Eşittir butonu
                ElevatedButton(
                  onPressed: _calculateTotalCost,
                  child: const Text("Eşittir"),
                  style: ElevatedButton.styleFrom(
                    // primary: Colors.teal,
                    // onPrimary: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),

                // Toplam Maliyet (readonly)
                TextFormField(
                  controller: _controllers[3]['controller'],
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: _controllers[3]['label'],
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.teal.shade50,
                    labelStyle: TextStyle(color: Colors.teal),
                  ),
                ),
                const SizedBox(height: 16),

                // Kaydet butonu
                ElevatedButton(
                  onPressed: _save,
                  child: const Text("Kaydet"),
                  style: ElevatedButton.styleFrom(
                    // primary: Colors.teal,
                    // onPrimary: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
