import 'package:flutter/material.dart';
import 'package:computation_app/ogun_ekleme.dart';

class KayitEkleme extends StatefulWidget {
  const KayitEkleme({super.key, required this.title});
  final String title;

  @override
  State<KayitEkleme> createState() => _KayitEklemeState();
}

class _KayitEklemeState extends State<KayitEkleme> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _textController = TextEditingController();

  List<Map<String, dynamic>> _meals = []; // Öğünlerin listesi

  void _addMeal(
      String mealName, double mealCost3, double mealCost2, double mealCost1) {
    setState(() {
      _meals.add({
        'name': mealName,
        'cost3': mealCost3,
        'cost2': mealCost2,
        'cost1': mealCost1,
      });
    });
  }

  void _removeMeal(int index) {
    setState(() {
      _meals.removeAt(index);
    });
  }

  void _editMeal(int index, String newMealName, double newMealCost3,
      double newMealCost2, double newMealCost1) {
    setState(() {
      _meals[index] = {
        'name': newMealName,
        'cost3': newMealCost3,
        'cost2': newMealCost2,
        'cost1': newMealCost1,
      };
    });
  }

  void _navigateToMealAddPage(
      {String? currentMealName,
      double? currentMealCost3,
      double? currentMealCost2,
      double? currentMealCost1,
      int? index}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OgunEkleme(
          title: 'Öğün Ekleme',
          onSave: (mealName, mealCost3, mealCost2, mealCost1) {
            if (index != null) {
              _editMeal(index, mealName, mealCost3, mealCost2, mealCost1);
            } else {
              _addMeal(mealName, mealCost3, mealCost2, mealCost1);
            }
          },
          initialMealName: currentMealName,
          initialMealCost3: currentMealCost3,
          initialMealCost2: currentMealCost2,
          initialMealCost1: currentMealCost1,
        ),
      ),
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
              TextFormField(
                controller: _dateController,
                readOnly: true,
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
                      _dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
                    });
                  }
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'İsim - Soyisim - Köy',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _navigateToMealAddPage();
                },
                child: const Text("Öğün Ekleme"),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _meals.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        title: Text('${_meals[index]['name']}'),
                        subtitle:
                            Text('Toplam Maliyet: ${_meals[index]['cost3']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _navigateToMealAddPage(
                                  currentMealName: _meals[index]['name'],
                                  currentMealCost3: _meals[index]['cost3'],
                                  currentMealCost2: _meals[index]['cost2'],
                                  currentMealCost1: _meals[index]['cost1'],
                                  index: index,
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _removeMeal(index);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
