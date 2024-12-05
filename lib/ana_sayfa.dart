import 'package:flutter/material.dart';
import 'package:computation_app/kayit_ekleme.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Burada müşteri listesi gibi ek içeriklerinizi ekleyebilirsiniz
              const Expanded(
                child: Center(
                  child: Text(
                    "Müşteri listesi burada görünecek.",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
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
              padding: const EdgeInsets.symmetric(vertical: 16), // Buton içi padding
              elevation: 5, // Buton gölgesi
            ),
            child: const Text(
              "Müşteri Kaydı Ekle",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
    ),
    );
  }
}