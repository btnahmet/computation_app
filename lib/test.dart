// import 'package:flutter/material.dart';

// class KayitEkleme extends StatefulWidget {
//   const KayitEkleme({super.key, required this.title});
//   final String title;

//   @override
//   State<KayitEkleme> createState() => _KayitEklemeState();
// }

// class _KayitEklemeState extends State<KayitEkleme> {
//   TextEditingController _dateController = TextEditingController(); // Tarih için controller
//   TextEditingController _textController = TextEditingController(); // TextFormField için controller

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Tarih seçme kutucuğu
//               TextFormField(
//                 controller: _dateController,
//                 readOnly: true, // Kullanıcı tarih kutusuna yazamaz, sadece seçebilir
//                 decoration: InputDecoration(
//                   labelText: 'Tarih Seçin',
//                   suffixIcon: Icon(Icons.calendar_today),
//                   border: OutlineInputBorder(),
//                 ),
//                 onTap: () async {
//                   DateTime? pickedDate = await showDatePicker(
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime(2000),
//                     lastDate: DateTime(2101),
//                   );
//                   if (pickedDate != null) {
//                     setState(() {
//                       _dateController.text = "${pickedDate.toLocal()}".split(' ')[0]; // Seçilen tarihi göster
//                     });
//                   }
//                 },
//               ),
//               const SizedBox(height: 20), // Alanlar arasında boşluk

//               // TextFormField
//               TextFormField(
//                 controller: _textController,
//                 decoration: InputDecoration(
//                   labelText: 'İsim - Soyisim - Köy',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';

// class KayitEkleme extends StatefulWidget {
//   const KayitEkleme({super.key, required this.title});
//   final String title;

//   @override
//   State<KayitEkleme> createState() => _KayitEklemeState();
// }

// class _KayitEklemeState extends State<KayitEkleme> {
//   TextEditingController _dateController = TextEditingController(); // Tarih için controller
//   TextEditingController _textController = TextEditingController(); // TextFormField için controller
//   TextEditingController _numberController1 = TextEditingController(); // İlk sayısal input controller
//   TextEditingController _numberController2 = TextEditingController(); // İkinci sayısal input controller
//   TextEditingController _numberController3 = TextEditingController(); // Üçüncü sayısal input controller

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Tarih seçme kutucuğu
//               TextFormField(
//                 controller: _dateController,
//                 readOnly: true, // Kullanıcı tarih kutusuna yazamaz, sadece seçebilir
//                 decoration: InputDecoration(
//                   labelText: 'Tarih Seçin',
//                   suffixIcon: Icon(Icons.calendar_today),
//                   border: OutlineInputBorder(),
//                 ),
//                 onTap: () async {
//                   DateTime? pickedDate = await showDatePicker(
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime(2000),
//                     lastDate: DateTime(2101),
//                   );
//                   if (pickedDate != null) {
//                     setState(() {
//                       _dateController.text = "${pickedDate.toLocal()}".split(' ')[0]; // Seçilen tarihi göster
//                     });
//                   }
//                 },
//               ),
//               const SizedBox(height: 20), // Alanlar arasında boşluk

//               // TextFormField açıklama
//               TextFormField(
//                 controller: _textController,
//                 decoration: InputDecoration(
//                   labelText: 'Açıklama',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20), // Alanlar arasında boşluk

//               // Sayısal input alanları - Yan yana 3 TextFormField
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       controller: _numberController1,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         labelText: 'Sayı 1',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10), // Alanlar arasında boşluk
//                   Expanded(
//                     child: TextFormField(
//                       controller: _numberController2,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         labelText: 'Sayı 2',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10), // Alanlar arasında boşluk
//                   Expanded(
//                     child: TextFormField(
//                       controller: _numberController3,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         labelText: 'Sayı 3',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';

// class KayitEkleme extends StatefulWidget {
//   const KayitEkleme({super.key, required this.title});
//   final String title;

//   @override
//   State<KayitEkleme> createState() => _KayitEklemeState();
// }

// class _KayitEklemeState extends State<KayitEkleme> {
//   TextEditingController _dateController = TextEditingController(); // Tarih için controller
//   TextEditingController _textController = TextEditingController(); // TextFormField için controller
//   TextEditingController _numberController1 = TextEditingController(); // İlk sayısal input controller
//   TextEditingController _numberController2 = TextEditingController(); // İkinci sayısal input controller
//   TextEditingController _numberController3 = TextEditingController(); // Üçüncü sayısal input controller

//   // Eşittir butonuna basıldığında yapılacak işlem
//   void _calculateResult() {
//     // Sayı 1 ve Sayı 2'yi al, çarpma işlemi yap
//     double? number1 = double.tryParse(_numberController1.text);
//     double? number2 = double.tryParse(_numberController2.text);

//     if (number1 != null && number2 != null) {
//       // Sonucu hesapla ve sayi3'e yerleştir
//       setState(() {
//         _numberController3.text = (number1 * number2).toString();
//       });
//     } else {
//       // Eğer geçersiz giriş varsa kullanıcıya bilgi ver
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Lütfen geçerli sayılar girin!")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Tarih seçme kutucuğu
//               TextFormField(
//                 controller: _dateController,
//                 readOnly: true, // Kullanıcı tarih kutusuna yazamaz, sadece seçebilir
//                 decoration: InputDecoration(
//                   labelText: 'Tarih Seçin',
//                   suffixIcon: Icon(Icons.calendar_today),
//                   border: OutlineInputBorder(),
//                 ),
//                 onTap: () async {
//                   DateTime? pickedDate = await showDatePicker(
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime(2000),
//                     lastDate: DateTime(2101),
//                   );
//                   if (pickedDate != null) {
//                     setState(() {
//                       _dateController.text = "${pickedDate.toLocal()}".split(' ')[0]; // Seçilen tarihi göster
//                     });
//                   }
//                 },
//               ),
//               const SizedBox(height: 20), // Alanlar arasında boşluk

//               // TextFormField açıklama
//               TextFormField(
//                 controller: _textController,
//                 decoration: InputDecoration(
//                   labelText: 'İsim - Soyisim - Köy',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20), // Alanlar arasında boşluk

//               // Sayısal input alanları - Yan yana 3 TextFormField
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       controller: _numberController1,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         labelText: 'Kişi Sayısı',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10), // Alanlar arasında boşluk
//                   Expanded(
//                     child: TextFormField(
//                       controller: _numberController2,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         labelText: 'Güncel Fiyat',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10), // Alanlar arasında boşluk

//                   // Eşittir butonu
//                   ElevatedButton(
//                     onPressed: _calculateResult,
//                     child: const Text('='),
//                   ),
//                   const SizedBox(width: 10), // Alanlar arasında boşluk
//                   Expanded(
//                     child: TextFormField(
//                       controller: _numberController3,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         labelText: 'Öğün Borc',
//                         border: OutlineInputBorder(),
//                       ),
//                       readOnly: true, // Sayı 3 sadece okuma modunda olacak
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }