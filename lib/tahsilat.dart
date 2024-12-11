// import 'package:flutter/material.dart';

// class Tahsilat extends StatefulWidget {
//   const Tahsilat({super.key, required this.title});
//   final String title;

//   @override
//   State<Tahsilat> createState() => _TahsilatState();
// }

// class _TahsilatState extends State<Tahsilat> {
//   final List<TextEditingController> _controllers = [];
//   final List<String> _labels = [
//     "Toplam Borç",
//     "Ödeyen Kişi",
//     "Ödenen Miktar",
//     "Güncel Borç"
//   ]; // Kalan TextFormField'ler için labelText değerleri

//   final TextEditingController _dateController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     // Diğer TextFormField'ler için bir TextEditingController oluştur ve ekle
//     for (int i = 0; i < _labels.length; i++) {
//       _controllers.add(TextEditingController());
//     }
//     // Örnek veriler (Toplam Borç ve Güncel Borç)
//     _controllers[0].text = "Toplam Borç"; // Toplam Borç
//     _controllers[3].text = "Güncel Borç";  // Güncel Borç
//   }

//   @override
//   void dispose() {
//     // Tüm TextEditingController'ları temizle
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     _dateController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: true, // Klavye açıldığında overflow'u engeller
//         appBar: AppBar(
//           backgroundColor: const Color(0xFF00796B),
//           title: Text(
//             "MÜŞTERİ TAHSİLAT BİLGİSİ",
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 22,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 // Toplam Borç (ReadOnly)
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 16.0),
//                   child: TextFormField(
//                     controller: _controllers[0],
//                     readOnly: true,
//                     decoration: InputDecoration(
//                       labelText: _labels[0], // "Toplam Borç"
//                       border: const OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 // Tarih Alanı
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 16.0),
//                   child: TextFormField(
//                     controller: _dateController,
//                     readOnly: true,
//                     decoration: const InputDecoration(
//                       labelText: "Tahsilat Tarihi",
//                       suffixIcon: Icon(Icons.calendar_today),
//                       border: OutlineInputBorder(),
//                     ),
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime(2101),
//                       );
//                       if (pickedDate != null) {
//                         setState(() {
//                           _dateController.text =
//                               "${pickedDate.toLocal()}".split(' ')[0];
//                         });
//                       }
//                     },
//                   ),
//                 ),
//                 // Dinamik Alanlar (Ödeyen Kişi ve Ödenen Miktar)
//                 ...List.generate(
//                   _controllers.length - 2,
//                   (index) => Padding(
//                     padding: const EdgeInsets.only(bottom: 16.0),
//                     child: TextFormField(
//                       controller: _controllers[index + 1],
//                       decoration: InputDecoration(
//                         labelText: _labels[index + 1],
//                         border: const OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Güncel Borç (ReadOnly)
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 16.0),
//                   child: TextFormField(
//                     controller: _controllers[3],
//                     readOnly: true,
//                     decoration: InputDecoration(
//                       labelText: _labels[3], // "Güncel Borç"
//                       border: const OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         bottomNavigationBar: Container(
//           color: Colors.transparent,
//           padding: const EdgeInsets.all(16.0),
//           child: ElevatedButton(
//             onPressed: () {
//               _saveData();
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.teal,
//               foregroundColor: Colors.white,
//               padding: const EdgeInsets.symmetric(vertical: 16.0),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: const Text(
//               "Tahsilat Kaydet",
//               style: TextStyle(fontSize: 18),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _saveData() {
//     // Tüm TextEditingController'lardaki veriyi bir listeye dönüştür
//     List<String> collectedData =
//         _controllers.map((controller) => controller.text).toList();
//     print("Toplam Borç: ${collectedData[0]}");
//     print("Tahsilat Tarihi: ${_dateController.text}");
//     print("Ödeyen Kişi: ${collectedData[1]}");
//     print("Ödenen Miktar: ${collectedData[2]}");
//     print("Güncel Borç: ${collectedData[3]}");
//     // İhtiyacınıza göre bu verileri başka bir yere gönderebilirsiniz
//   }
// }
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
