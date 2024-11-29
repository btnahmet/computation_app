// import 'package:computation_app/kayit_ekleme.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         // useMaterial3: true,
//       ),
//       home: const MyHomePage(title: ''),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     double deviceWidth = MediaQuery.of(context).size.width;
//     double deviceHeight = MediaQuery.of(context).size.height;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color.fromARGB(255, 233, 233, 228),
//         appBar: AppBar(
//           backgroundColor: const Color.fromARGB(255, 219, 219, 195),
//           title: Container(
//             child: const Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   "MÜŞTERİ LİSTESİ",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//         body: Padding(
//           //padding: EdgeInsets.symmetric(horizontal: deviceWidth/30),
//           padding: EdgeInsets.fromLTRB(
//               deviceWidth / 18, deviceHeight / 18, deviceWidth / 10, 0),
//           child: Row(
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const KayitEkleme(title: ""),
//                     ),
//                   );
//                 },
//                 child: Row(
//                   children: [
//                     // Image.asset(
//                     //   "lib/assets/images/plus_icon.png",
//                     //   height: deviceHeight * 0.03,
//                     // ),
//                     SizedBox(width: deviceWidth * 0.03),
//                     const Text(
//                       "Kayıt Ekle",
//                       style: TextStyle(fontSize: 20, color: Colors.black),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:computation_app/kayit_ekleme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F6F9), // Yumuşak bir arka plan rengi
        appBar: AppBar(
          backgroundColor: const Color(0xFF00796B), // Teal rengi AppBar
          title: const Text(
            "MÜŞTERİ LİSTESİ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(
              deviceWidth / 18, deviceHeight / 18, deviceWidth / 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KayitEkleme(title: ""),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Butonun arka plan rengi
                  foregroundColor: Colors.white, // Butonun metin rengi
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Yuvarlatılmış köşeler
                  ),
                  padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05, vertical: deviceHeight * 0.015), // Buton içi padding
                  elevation: 5, // Buton gölgesi
                ),
                child: Row(
                  children: [
                    SizedBox(width: deviceWidth * 0.03), // Butonun sol tarafında boşluk
                    const Text(
                      "Müşteri Kaydı Ekle",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
