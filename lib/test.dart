// >>>>>>>>>>>>>> KAYIT EKLEME ESKİ CLASS
// import 'package:flutter/material.dart';
// import 'package:computation_app/ogun_ekleme.dart';

// class KayitEkleme extends StatefulWidget {
//   const KayitEkleme({super.key, required this.title});
//   final String title;

//   @override
//   State<KayitEkleme> createState() => _KayitEklemeState();
// }

// class _KayitEklemeState extends State<KayitEkleme> {
//   TextEditingController _dateController = TextEditingController();
//   TextEditingController _textController = TextEditingController();
//   TextEditingController _totalDebtController = TextEditingController();

//   List<Map<String, dynamic>> _meals = []; // Öğünlerin listesi

//   @override
//   void initState() {
//     super.initState();
//     _totalDebtController.text = "0.0"; // Başlangıç borç değeri
//   }

//   void _updateTotalDebt() {
//     double totalDebt = 0.0;
//     for (var meal in _meals) {
//       totalDebt += meal['cost3'] ?? 0.0;
//     }
//     _totalDebtController.text = totalDebt.toStringAsFixed(2);
//   }

//   void _addMeal(
//       String mealName, double mealCost3, double mealCost2, double mealCost1) {
//     setState(() {
//       _meals.add({
//         'name': mealName,
//         'cost3': mealCost3,
//         'cost2': mealCost2,
//         'cost1': mealCost1,
//       });
//       _updateTotalDebt(); // Borcu güncelle
//     });
//   }

//   void _removeMeal(int index) {
//     setState(() {
//       _meals.removeAt(index);
//       _updateTotalDebt(); // Borcu güncelle
//     });
//   }

//   void _editMeal(int index, String newMealName, double newMealCost3,
//       double newMealCost2, double newMealCost1) {
//     setState(() {
//       _meals[index] = {
//         'name': newMealName,
//         'cost3': newMealCost3,
//         'cost2': newMealCost2,
//         'cost1': newMealCost1,
//       };
//       _updateTotalDebt(); // Borcu güncelle
//     });
//   }

//   void _navigateToMealAddPage(
//       {String? currentMealName,
//       double? currentMealCost3,
//       double? currentMealCost2,
//       double? currentMealCost1,
//       int? index}) async {
//     await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => OgunEkleme(
//           title: 'Öğün Ekleme',
//           onSave: (mealName, mealCost3, mealCost2, mealCost1) {
//             if (index != null) {
//               _editMeal(index, mealName, mealCost3, mealCost2, mealCost1);
//             } else {
//               _addMeal(mealName, mealCost3, mealCost2, mealCost1);
//             }
//           },
//           initialMealName: currentMealName,
//           initialMealCost3: currentMealCost3,
//           initialMealCost2: currentMealCost2,
//           initialMealCost1: currentMealCost1,
//         ),
//       ),
//     );
//   }

//   void _saveCustomer() {
//     // Müşteriyi kaydetme işlemleri buraya eklenecek
//     // Örneğin:
//     print("Müşteri kaydedildi: ${_textController.text}");
//     print("Toplam Borç: ${_totalDebtController.text}");
//     print("Eklenen Öğünler: $_meals");

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Müşteri kaydedildi!")),
//     );
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
//               TextFormField(
//                 controller: _dateController,
//                 readOnly: true,
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
//                       _dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
//                     });
//                   }
//                 },
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: _textController,
//                 decoration: InputDecoration(
//                   labelText: 'İsim - Soyisim - Köy',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: _totalDebtController,
//                 readOnly: true,
//                 decoration: InputDecoration(
//                   labelText: 'Müşteri Toplam Borcu',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   _navigateToMealAddPage();
//                 },
//                 child: const Text("Öğün Ekleme"),
//               ),
//               const SizedBox(height: 20),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: _meals.length,
//                   itemBuilder: (context, index) {
//                     return Card(
//                       margin: const EdgeInsets.symmetric(vertical: 10),
//                       child: ListTile(
//                         title: Text('${_meals[index]['name']}'),
//                         subtitle:
//                             Text('Toplam Maliyet: ${_meals[index]['cost3']}'),
//                         trailing: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             IconButton(
//                               icon: Icon(Icons.edit),
//                               onPressed: () {
//                                 _navigateToMealAddPage(
//                                   currentMealName: _meals[index]['name'],
//                                   currentMealCost3: _meals[index]['cost3'],
//                                   currentMealCost2: _meals[index]['cost2'],
//                                   currentMealCost1: _meals[index]['cost1'],
//                                   index: index,
//                                 );
//                               },
//                             ),
//                             IconButton(
//                               icon: Icon(Icons.delete),
//                               onPressed: () {
//                                 _removeMeal(index);
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//         bottomNavigationBar: Container(
//           color: Colors.transparent,
//           padding: const EdgeInsets.all(16.0),
//           child: ElevatedButton(
//             onPressed: _saveCustomer,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.teal, // Buton rengi
//               foregroundColor: Colors.white, // Metin rengi
//               padding: const EdgeInsets.symmetric(vertical: 16.0),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8), // Yuvarlatılmış köşeler
//               ),
//             ),
//             child: const Text(
//               "Müşteriyi Kaydet",
//               style: TextStyle(fontSize: 18),
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
// ANA SAYFA CLASS ESKİ HALİ
// // import 'package:flutter/material.dart';
// // import 'package:computation_app/kayit_ekleme.dart';

// // class AnaSayfa extends StatefulWidget {
// //   const AnaSayfa({super.key});

// //   @override
// //   State<AnaSayfa> createState() => _AnaSayfaState();
// // }

// // class _AnaSayfaState extends State<AnaSayfa> {
// //   List<Map<String, dynamic>> _customers = []; // Müşteri listesi

// //   // Kayıt Ekleme sayfasına yönlendirme ve veri alma
// //   void _navigateToKayitEkleme() async {
// //     final customerData = await Navigator.push(
// //       context,
// //       MaterialPageRoute(
// //         builder: (context) => const KayitEkleme(title: "Yeni Müşteri Kaydı"),
// //       ),
// //     );

// //     if (customerData != null) {
// //       setState(() {
// //         _customers.add(customerData); // Gelen veriyi müşteri listesine ekle
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: Scaffold(
// //         backgroundColor: const Color(0xFFF4F6F9), // Yumuşak arka plan rengi
// //         appBar: AppBar(
// //           backgroundColor: const Color(0xFF00796B), // Teal rengi AppBar
// //           title: const Text(
// //             "MÜŞTERİ LİSTESİ",
// //             style: TextStyle(
// //               fontWeight: FontWeight.bold,
// //               fontSize: 22,
// //               color: Colors.white,
// //             ),
// //           ),
// //         ),
// //         body: Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: _customers.isEmpty
// //               ? const Center(
// //                   child: Text(
// //                     "Müşteri listesi burada görünecek.",
// //                     style: TextStyle(fontSize: 18, color: Colors.black54),
// //                   ),
// //                 )
// //               : ListView.builder(
// //                   itemCount: _customers.length,
// //                   itemBuilder: (context, index) {
// //                     var customer = _customers[index];
// //                     return Card(
// //                       margin: const EdgeInsets.symmetric(vertical: 8),
// //                       elevation: 5,
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(10),
// //                       ),
// //                       child: ExpansionTile(
// //                         leading: const Icon(Icons.account_circle,
// //                             color: Colors.teal),
// //                         title: Text(
// //                           "${customer['name']}",
// //                           style: const TextStyle(fontWeight: FontWeight.bold),
// //                         ),
// //                         subtitle: Text("Tarih: ${customer['date']}"),
// //                         children: [
// //                           ListTile(
// //                             title:
// //                                 Text("Toplam Borç: ${customer['totalDebt']}₺"),
// //                           ),
// //                           const Divider(),
// //                           const Padding(
// //                             padding: EdgeInsets.symmetric(horizontal: 16.0),
// //                             child: Text(
// //                               "Öğünler:",
// //                               style: TextStyle(
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             ),
// //                           ),
// //                           ...List.generate(customer['meals'].length,
// //                               (mealIndex) {
// //                             var meal = customer['meals'][mealIndex];
// //                             return Padding(
// //                               padding:
// //                                   const EdgeInsets.symmetric(vertical: 4.0),
// //                               child: ListTile(
// //                                 title: Text(meal['name']),
// //                                 subtitle: Text("Maliyet: ${meal['cost3']}₺"),
// //                               ),
// //                             );
// //                           }),
// //                         ],
// //                       ),
// //                     );
// //                   },
// //                 ),
// //         ),
// //         floatingActionButton: FloatingActionButton(
// //           onPressed: _navigateToKayitEkleme,
// //           backgroundColor: const Color(0xFF00796B),
// //           child: const Icon(Icons.add),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:computation_app/kayit_ekleme.dart';

// class AnaSayfa extends StatefulWidget {
//   const AnaSayfa({super.key});

//   @override
//   State<AnaSayfa> createState() => _AnaSayfaState();
// }

// class _AnaSayfaState extends State<AnaSayfa> {
//   List<Map<String, dynamic>> _customers = []; // Müşteri listesi

//   // Kayıt Ekleme sayfasına yönlendirme ve veri alma
//   void _navigateToKayitEkleme() async {
//     final customerData = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const KayitEkleme(title: "Yeni Müşteri Kaydı"),
//       ),
//     );

//     if (customerData != null) {
//       setState(() {
//         _customers.add(customerData); // Gelen veriyi müşteri listesine ekle
//       });
//     }
//   }

//     // Kayıt silme fonksiyonu
//   void _deleteCustomer(int index) {
//     setState(() {
//       _customers.removeAt(index); // Belirtilen indeksteki kaydı sil
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color(0xFFF4F6F9), // Yumuşak arka plan rengi
//         appBar: AppBar(
//           backgroundColor: const Color(0xFF00796B), // Teal rengi AppBar
//           title: const Text(
//             "MÜŞTERİ LİSTESİ",
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 22,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: _customers.isEmpty
//               ? const Center(
//                   child: Text(
//                     "Müşteri listesi burada görünecek.",
//                     style: TextStyle(fontSize: 18, color: Colors.black54),
//                   ),
//                 )
//               : ListView.builder(
//                   itemCount: _customers.length,
//                   itemBuilder: (context, index) {
//                     var customer = _customers[index];
//                     return Card(
//                       margin: const EdgeInsets.symmetric(vertical: 8),
//                       elevation: 5,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: ExpansionTile(
//                         leading: const Icon(Icons.account_circle,
//                             color: Colors.teal),
//                         title: Text(
//                           "${customer['name']}",
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         subtitle: Text("Tarih: ${customer['date']}"),
//                         trailing: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             IconButton(
//                               icon: const Icon(Icons.edit, color: Colors.blue),
//                               onPressed: () {
//                                 // Düzenleme işlemi burada yapılacak
//                               },
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.delete, color: Colors.red),
//                               onPressed: () => _deleteCustomer(index),
//                             ),
//                           ],
//                         ),
//                         children: [
//                           ListTile(
//                             title:
//                                 Text("Toplam Borç: ${customer['totalDebt']}₺"),
//                           ),
//                           const Divider(),
//                           const Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 16.0),
//                             child: Text(
//                               "Öğünler:",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           ...List.generate(customer['meals'].length,
//                               (mealIndex) {
//                             var meal = customer['meals'][mealIndex];
//                             return Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(vertical: 4.0),
//                               child: ListTile(
//                                 title: Text(meal['name']),
//                                 subtitle: Text("Maliyet: ${meal['cost3']}₺"),
//                               ),
//                             );
//                           }),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: _navigateToKayitEkleme,
//           backgroundColor: const Color(0xFF00796B),
//           child: const Icon(Icons.add),
//         ),
//       ),
//     );
//   }
// }