import 'package:sqflite/sqflite.dart';
import 'package:risparmio/core/db/database_helper.dart';
import 'package:risparmio/features/transaction/data/models/transaction.dart' as txn;
import '../../../category/data/models/category.dart';

/// Data Access Object (DAO) for managing transactions in the local database.
/// 
/// Provides methods to insert, retrieve, update, and delete financial transactions.
class TransactionDao {
  final dbHelper = DatabaseHelper();

  /// Inserts a new transaction into the database.
  /// 
  /// If a transaction with the same ID already exists, it will be replaced.
  /// 
  /// Returns the row ID of the inserted transaction.
  Future<int> insertTransaction(txn.Transaction transaction) async {
    final db = await dbHelper.database;

    return await db.insert(
      'transactions',
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Retrieves all transactions from the database.
  /// 
  /// Returns a list of [Transaction] objects.
  Future<List<txn.Transaction>> getAllTransactions() async {
    final db = await dbHelper.database;

    final List<Map<String, dynamic>> results = await db.rawQuery('''
      SELECT t.id, t.amount, t.description, t.date, t.category_id,
            c.name AS category_name, c.type AS category_type
      FROM transactions t
      JOIN categories c ON t.category_id = c.id
    ''');

    return results.map((map) {
      final categoryMap = {
        'id': map['category_id'],
        'name': map['category_name'],
        'type': map['category_type'],
      };

      final category = Category.fromMap(categoryMap);
      return txn.Transaction.fromMap(map, category);
    }).toList();
  }

  /// Retrieves transactions filtered by type (e.g., income or expense).
  /// 
  /// [type] is the type of transaction to filter by.
  /// 
  /// Returns a list of [Transaction] objects matching the given type.
  Future<List<txn.Transaction>> getTransactionsByType(txn.TransactionType type) async {
    final db = await dbHelper.database;

    final List<Map<String, dynamic>> results = await db.rawQuery('''
      SELECT t.*, c.name AS category_name, c.type AS category_type
      FROM transactions t
      JOIN categories c ON t.category_id = c.id
      WHERE t.type = ?
    ''', [type.name]); // Match type as string

    return results.map((map) {
      final categoryMap = {
        'id': map['category_id'],
        'name': map['category_name'],
        'type': map['category_type'],
      };

      final category = Category.fromMap(categoryMap);
      return txn.Transaction.fromMap(map, category);
    }).toList();
  }

  /// Deletes a transaction by its [id].
  /// 
  /// Returns the number of rows affected (should be 1 if successful).
  Future<int> deleteTransaction(String id) async {
    final db = await dbHelper.database;

    return await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Updates an existing transaction.
  /// 
  /// The transaction is matched by its [id].
  /// 
  /// Returns the number of rows affected.
  Future<int> updateTransaction(txn.Transaction transaction) async {
    final db = await dbHelper.database;

    return await db.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }
}
