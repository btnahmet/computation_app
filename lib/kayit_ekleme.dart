import 'package:computation_app/ogun_ekleme.dart';
import 'package:flutter/material.dart';

class KayitEkleme extends StatefulWidget {
  const KayitEkleme({super.key, required this.title});
  final String title;

  @override
  State<KayitEkleme> createState() => _KayitEklemeState();
}

class _KayitEklemeState extends State<KayitEkleme> {
  TextEditingController _dateController =
      TextEditingController(); // Tarih için controller
  TextEditingController _textController =
      TextEditingController(); // TextFormField için controller
 

  // Öğün ekleme butonuna basıldığında yapılacak işlem
  void _addMeal() {
    // Burada istediğiniz işlemi gerçekleştirebilirsiniz
    // Şu an için sadece bir mesaj göstereceğiz
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Öğün Eklendi!")),
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
              // Tarih seçme kutucuğu
              TextFormField(
                controller: _dateController,
                readOnly:
                    true, // Kullanıcı tarih kutusuna yazamaz, sadece seçebilir
                decoration: InputDecoration(
                  labelText: 'Tarih Seçin',
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
                      _dateController.text = "${pickedDate.toLocal()}"
                          .split(' ')[0]; // Seçilen tarihi göster
                    });
                  }
                },
              ),
              const SizedBox(height: 20), // Alanlar arasında boşluk

              // TextFormField açıklama
              TextFormField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'İsim - Soyisim - Köy',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20), // Alanlar arasında boşluk

              // Öğün Ekleme Butonu
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OgunEkleme (title: ""),
                    ),
                  );
                },
                child: const Text("Öğün Ekleme"),
              ),
              const SizedBox(
                  height: 20), // Buton ile diğer alanlar arasında boşluk

            ],
          ),
        ),
      ),
    );
  }
}
