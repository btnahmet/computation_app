// import 'dart:io';
// import 'package:drift/drift.dart';
// import 'package:drift/native.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as p;
// import 'database.dart';

// // part 'database_helper.g.dart';

// @DriftDatabase(tables: [Customers, Meals, Payments])
// class AppDatabase extends _$AppDatabase {
//   AppDatabase() : super(_openConnection());

//   @override
//   int get schemaVersion => 1;

//   // 📌 Müşteri CRUD İşlemleri
//   Future<int> insertCustomer(CustomersCompanion customer) =>
//       into(customers).insert(customer);

//   Future<List<Customer>> getAllCustomers() => select(customers).get();

//   Future<int> updateCustomer(CustomersCompanion customer) =>
//       update(customers).replace(customer);

//   Future<int> deleteCustomer(int id) =>
//       (delete(customers)..where((c) => c.id.equals(id))).go();

//   // 📌 Yemek CRUD İşlemleri
//   Future<int> insertMeal(MealsCompanion meal) => into(meals).insert(meal);

//   Future<List<Meal>> getAllMeals() => select(meals).get();

//   Future<int> updateMeal(MealsCompanion meal) =>
//       update(meals).replace(meal);

//   Future<int> deleteMeal(int id) =>
//       (delete(meals)..where((m) => m.id.equals(id))).go();

//   // 📌 Ödeme CRUD İşlemleri
//   Future<int> insertPayment(PaymentsCompanion payment) =>
//       into(payments).insert(payment);

//   Future<List<Payment>> getAllPayments() => select(payments).get();

//   Future<int> updatePayment(PaymentsCompanion payment) =>
//       update(payments).replace(payment);

//   Future<int> deletePayment(int id) =>
//       (delete(payments)..where((p) => p.id.equals(id))).go();
// }

// // 📌 Veritabanı bağlantısını oluşturan fonksiyon
// LazyDatabase _openConnection() {
//   return LazyDatabase(() async {
//     final dbFolder = await getApplicationDocumentsDirectory();
//     final file = File(p.join(dbFolder.path, 'app_database.sqlite'));
//     return NativeDatabase(file);
//   });
// }

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'app_database.db');
    return openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('PRAGMA foreign_keys = ON');
        await db.execute('''
          CREATE TABLE customers(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            date TEXT,
            totalDebt REAL,
            currentDebt REAL
          )
        ''');
        await db.execute('''
          CREATE TABLE meals(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            customerId INTEGER,
            name TEXT,
            cost1 REAL,
            cost2 REAL,
            cost3 REAL,
            FOREIGN KEY(customerId) REFERENCES customers(id) ON DELETE CASCADE
          )
        ''');
        await db.execute('''
          CREATE TABLE payments(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            customerId INTEGER,
            payer TEXT,
            amount REAL,
            date TEXT,
            FOREIGN KEY(customerId) REFERENCES customers(id) ON DELETE CASCADE
          )
        ''');
        await db.execute('CREATE INDEX idx_customerId ON meals(customerId)');
        await db.execute('CREATE INDEX idx_payments_customerId ON payments(customerId)');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        for (int i = oldVersion + 1; i <= newVersion; i++) {
          switch (i) {
            case 2:
              await db.execute('ALTER TABLE customers ADD COLUMN newColumn TEXT');
              break;
            // Yeni versiyonlar eklenirse buraya case eklenmeli
          }
        }
      },
    );
  }

  Future<void> insertCustomerWithMeals(Map<String, dynamic> customer, List<Map<String, dynamic>> meals) async {
    final db = await database;
    await db.transaction((txn) async {
      final modifiableCustomer = Map<String, dynamic>.from(customer); // Mutable hale getir
      final customerId = await txn.insert('customers', modifiableCustomer);

      for (var meal in meals) {
        var modifiableMeal = Map<String, dynamic>.from(meal); // Mutable hale getir
        modifiableMeal['customerId'] = customerId;
        await txn.insert('meals', modifiableMeal);
      }
    });
  }

  Future<int> insertCustomer(Map<String, dynamic> customer) async {
    final db = await database;
    customer.remove('id'); // id varsa sil
    return await db.insert('customers', customer);
  }

  Future<List<Map<String, dynamic>>> getCustomers() async {
    final db = await database;
    return await db.query('customers') ?? [];
  }

  Future<int> updateCustomer(Map<String, dynamic> customer) async {
    final db = await database;
    return await db.update(
      'customers',
      customer,
      where: 'id = ?',
      whereArgs: [customer['id']],
    );
  }

  Future<int> deleteCustomer(int id) async {
    final db = await database;
    return await db.delete(
      'customers',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> insertMeal(Map<String, dynamic> meal) async {
    final db = await database;
    meal.remove('id'); // id varsa sil
    return await db.insert('meals', meal);
  }

  Future<List<Map<String, dynamic>>> getMeals(int customerId) async {
    final db = await database;
    return List<Map<String, dynamic>>.from(await db.query(
          'meals',
          where: 'customerId = ?',
          whereArgs: [customerId],
        )) ?? [];
  }

  Future<int> deleteMeal(int id) async {
    final db = await database;
    return await db.delete(
      'meals',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> insertPayment(Map<String, dynamic> payment) async {
    final db = await database;
    payment.remove('id'); // id varsa sil
    return await db.insert('payments', payment);
  }

  Future<List<Map<String, String>>> getPaymentsAsStringMap(int customerId) async {
    final db = await database;
    final result = await db.query(
      'payments',
      where: 'customerId = ?',
      whereArgs: [customerId],
    );
    return result
        .map((e) => e.map((k, v) => MapEntry(k.toString(), v?.toString() ?? '')) as Map<String, String>)
        .toList();
  }

  Future<int> deletePayment(int id) async {
    final db = await database;
    return await db.delete(
      'payments',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updatePayment(Map<String, dynamic> payment) async {
    final db = await database;
    return await db.update(
      'payments',
      payment,
      where: 'id = ?',
      whereArgs: [payment['id']],
    );
  }

  Future<int> updateCustomerDebt(int id, double currentDebt) async {
    final db = await database;
    return await db.update(
      'customers',
      {'currentDebt': currentDebt},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
