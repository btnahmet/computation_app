// >>>>>>>>>>>>>> KAYIT EKLEME ESKİ CLASS
// import 'package:flutter/material.dart';

// class OgunEkleme extends StatefulWidget {
//   const OgunEkleme({
//     super.key,
//     required this.title,
//     required this.onSave,
//     this.initialMealName,
//     this.initialMealCost3,
//     this.initialMealCost2,
//     this.initialMealCost1,
//   });
//   final String title;
//   final Function(String, double, double, double) onSave;
//   final String? initialMealName;
//   final double? initialMealCost3;
//   final double? initialMealCost2;
//   final double? initialMealCost1;

//   // final Function(String, double, double, double) onSave;// Öğün kaydetme fonksiyonu

//   @override
//   State<OgunEkleme> createState() => _OgunEklemeState();
  
// }

// class _OgunEklemeState extends State<OgunEkleme> {
//   // Öğün adı için controller
// TextEditingController _mealNameController = TextEditingController();

// // Öğün maliyetleri için 3 farklı controller
// TextEditingController _mealCostController3 = TextEditingController();
// TextEditingController _mealCostController2 = TextEditingController();
// TextEditingController _mealCostController1 = TextEditingController();

//   TextEditingController _numberController1 =
//       TextEditingController(); // Kişi Sayısı
//   TextEditingController _numberController2 =
//       TextEditingController(); // Güncel Porsiyon Fiyatı
//   TextEditingController _numberController3 =
//       TextEditingController(); // Toplam Maliyet (readonly)
//   TextEditingController _additionalController =
//       TextEditingController(); // Öğün İsmi

//   // Eşittir butonuna basıldığında yapılacak işlem
//   void _calculateResult() {
//     double? number1 = double.tryParse(_numberController1.text); // Kişi Sayısı
//     double? number2 =
//         double.tryParse(_numberController2.text); // Güncel Porsiyon Fiyatı

//     if (number1 != null && number2 != null) {
//       setState(() {
//         _numberController3.text =
//             (number1 * number2).toStringAsFixed(2); // Toplam Maliyet
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Lütfen geçerli sayılar girin!")),
//       );
//     }
//   }
  
//   @override
// void initState() {
//   super.initState();
  
//   // Eğer mevcut öğün adı varsa, bunu kontrol edip alıyoruz
//   if (widget.initialMealName != null) {
//     _mealNameController.text = widget.initialMealName!;
//   }
  
//   // Eğer mevcut öğün maliyetleri varsa, bunları kontrol edip alıyoruz
//   if (widget.initialMealCost3 != null) {
//     _mealCostController3.text = widget.initialMealCost3!.toString();
//   }
  
//   if (widget.initialMealCost2 != null) {
//     _mealCostController2.text = widget.initialMealCost2!.toString();
//   }
  
//   if (widget.initialMealCost1 != null) {
//     _mealCostController1.text = widget.initialMealCost1!.toString();
//   }
// }


//   void _save() {
//     final mealName = _additionalController.text; // Öğün adı
//     final mealCost3 =
//         double.tryParse(_numberController3.text); // Toplam maliyet
//     final mealCost2 =
//         double.tryParse(_numberController2.text); // Güncel porsiyon fiyatı
//     final mealCost1 = double.tryParse(_numberController1.text); // Kişi sayısı

//     if (mealName.isNotEmpty &&
//         mealCost3 != null &&
//         mealCost2 != null &&
//         mealCost1 != null) {
//       widget.onSave(mealName, mealCost3, mealCost2,
//           mealCost1); // 4 parametre ile veriyi KayitEkleme'ye gönder
//       Navigator.pop(context,{
//         'mealName': _additionalController.text,
//         'mealCost3': _numberController3.text,
//         'mealCost2': _numberController2.text,
//         'mealCost1':_numberController1.text,
//       }); // Öğün Ekleme sayfasını kapatıp geri dön
//     } else {
//       // Kullanıcı eksik bilgi girmişse uyarı mesajı göster
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
//           title: Text(widget.title),
//           backgroundColor: Colors.teal, // AppBar rengini yeşil yapıyoruz
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

//                 // Kişi Sayısı
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
//                 const SizedBox(height: 16),

//                 // Güncel Porsiyon Fiyatı
//                 TextFormField(
//                   controller: _numberController2,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     labelText: 'Güncel Porsiyon Fiyatı',
//                     border: OutlineInputBorder(),
//                     filled: true,
//                     fillColor: Colors.teal.shade50,
//                     labelStyle: TextStyle(color: Colors.teal),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 // Eşittir butonu
//                 ElevatedButton(
//                   onPressed: _calculateResult,
//                   child: const Text("Öğün Maliyetini Hesapla"),
//                   style: ElevatedButton.styleFrom(
//                       // primary: Colors.teal, // Buton rengi
//                       ),
//                 ),
//                 const SizedBox(height: 16),
//                 // Toplam Maliyet (readonly)
//                 TextFormField(
//                   controller: _numberController3,
//                   readOnly: true, // Kullanıcıya yazdırılamaz
//                   decoration: InputDecoration(
//                     labelText: 'Toplam Maliyet',
//                     border: OutlineInputBorder(),
//                     filled: true,
//                     fillColor: Colors.teal.shade50,
//                     labelStyle: TextStyle(color: Colors.teal),
//                   ),
//                 ),
//                 const SizedBox(height: 16),

//                 // Kaydet butonu
//                 ElevatedButton(
//                   onPressed: _save,
//                   child: const Text("Kaydet"),
//                   // style: ElevatedButton.styleFrom(
//                   //     primary: Colors.teal, // Buton rengi
//                   //     ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//>>>>>>>>>>> ÖĞÜN EKLEME ESKİ CLASS
// import 'package:flutter/material.dart';

// class OgunEkleme extends StatefulWidget {
//   const OgunEkleme({super.key, required this.title, required this.onSave});
//   final String title;
//   final Function(String, double, double, double) onSave;// Öğün kaydetme fonksiyonu

//   @override
//   State<OgunEkleme> createState() => _OgunEklemeState();
// }

// class _OgunEklemeState extends State<OgunEkleme> {
//   TextEditingController _numberController1 =
//       TextEditingController(); // Kişi Sayısı
//   TextEditingController _numberController2 =
//       TextEditingController(); // Güncel Porsiyon Fiyatı
//   TextEditingController _numberController3 =
//       TextEditingController(); // Toplam Maliyet (readonly)
//   TextEditingController _additionalController =
//       TextEditingController(); // Öğün İsmi

//   // Eşittir butonuna basıldığında yapılacak işlem
//   void _calculateResult() {
//     double? number1 = double.tryParse(_numberController1.text); // Kişi Sayısı
//     double? number2 =
//         double.tryParse(_numberController2.text); // Güncel Porsiyon Fiyatı

//     if (number1 != null && number2 != null) {
//       setState(() {
//         _numberController3.text =
//             (number1 * number2).toStringAsFixed(2); // Toplam Maliyet
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Lütfen geçerli sayılar girin!")),
//       );
//     }
//   }
//   void _save() {
//     final mealName = _additionalController.text; // Öğün adı
//     final mealCost3 =
//         double.tryParse(_numberController3.text); // Toplam maliyet
//     final mealCost2 =
//         double.tryParse(_numberController2.text); // Güncel porsiyon fiyatı
//     final mealCost1 = double.tryParse(_numberController1.text); // Kişi sayısı

//     if (mealName.isNotEmpty &&
//         mealCost3 != null &&
//         mealCost2 != null &&
//         mealCost1 != null) {
//       widget.onSave(mealName, mealCost3, mealCost2,
//           mealCost1); // 4 parametre ile veriyi KayitEkleme'ye gönder
//       Navigator.pop(context); // Öğün Ekleme sayfasını kapatıp geri dön
//     } else {
//       // Kullanıcı eksik bilgi girmişse uyarı mesajı göster
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
//           title: Text(widget.title),
//           backgroundColor: Colors.teal, // AppBar rengini yeşil yapıyoruz
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

//                 // Kişi Sayısı
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
//                 const SizedBox(height: 16),

//                 // Güncel Porsiyon Fiyatı
//                 TextFormField(
//                   controller: _numberController2,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     labelText: 'Güncel Porsiyon Fiyatı',
//                     border: OutlineInputBorder(),
//                     filled: true,
//                     fillColor: Colors.teal.shade50,
//                     labelStyle: TextStyle(color: Colors.teal),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 // Eşittir butonu
//                 ElevatedButton(
//                   onPressed: _calculateResult,
//                   child: const Text("Öğün Maliyetini Hesapla"),
//                   style: ElevatedButton.styleFrom(
//                       // primary: Colors.teal, // Buton rengi
//                       ),
//                 ),
//                 const SizedBox(height: 16),
//                 // Toplam Maliyet (readonly)
//                 TextFormField(
//                   controller: _numberController3,
//                   readOnly: true, // Kullanıcıya yazdırılamaz
//                   decoration: InputDecoration(
//                     labelText: 'Toplam Maliyet',
//                     border: OutlineInputBorder(),
//                     filled: true,
//                     fillColor: Colors.teal.shade50,
//                     labelStyle: TextStyle(color: Colors.teal),
//                   ),
//                 ),
//                 const SizedBox(height: 16),

//                 // Kaydet butonu
//                 ElevatedButton(
//                   onPressed: _save,
//                   child: const Text("Kaydet"),
//                   style: ElevatedButton.styleFrom(
//                       // primary: Colors.teal, // Buton rengi
//                       ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

