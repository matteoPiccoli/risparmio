import 'package:sqflite/sqflite.dart';
import 'package:risparmio/features/transaction/data/models/transaction.dart';
import 'package:risparmio/features/category/data/models/category.dart';
import 'package:risparmio/features/category/data/models/default_categories.dart';

/// Data Access Object (DAO) for managing categories in the local database.
/// 
/// Provides methods to insert, retrieve, update, and delete transaction categories.
class CategoryDao {
  /// The SQLite database instance passed during initialization.
  final Database db;

  /// Creates a [CategoryDao] with a given [Database] instance.
  CategoryDao(this.db);

  /// Inserts a new category into the database.
  /// 
  /// If a category with the same ID already exists, it will be replaced.
  /// 
  /// Returns the row ID of the inserted category.
  Future<void> insertCategory(Category category) async {
    await db.insert(
      'categories',
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Inserts all the default categories in the database.
  /// 
  /// If a category with the same ID already exists, it will be replaced.
  Future<void> insertDefaultCategories() async {
    for (var category in defaultCategories) {
      await insertCategory(category);
    }
  }

  /// Retrieves all categorties from the database.
  /// 
  /// Returns a list of [Category] objects.
  Future<List<Category>> getAllCategories() async {
    final List<Map<String, dynamic>> maps = await db.query('categories');

    return maps.map((map) => Category.fromMap(map)).toList();
  }

  /// Retrieves categories filtered by type (e.g., income or expense).
  /// 
  /// [type] is the type of transaction to filter by.
  /// 
  /// Returns a list of [Category] objects matching the given type.
  Future<List<Category>> getCategoriesByType(TransactionType type) async {
    final List<Map<String, dynamic>> maps = await db.query(
      'categories',
      where: 'type = ?',
      whereArgs: [type.name],
    );
    return maps.map((map) => Category.fromMap(map)).toList();
  }

  /// Deletes a category by its [id].
  /// 
  /// Returns the number of rows affected (should be 1 if successful).
  Future<void> deleteCategory(String id) async {
    await db.delete(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Updates an existing category.
  /// 
  /// The category is matched by its [id].
  /// 
  /// Returns the number of rows affected.
  Future<void> updateCategory(Category category) async {
    await db.update(
      'categories',
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }
}
