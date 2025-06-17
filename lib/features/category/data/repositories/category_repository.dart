import 'package:risparmio/features/category/data/dao/category_dao.dart';
import 'package:risparmio/core/db/database_helper.dart';
import '../models/category.dart';

/// Repository that acts as an abstraction layer between the data source (DAO)
/// and the business logic (view models or use cases).
///
/// This layer allows you to decouple the underlying database implementation
/// from the rest of your application. It can also be extended to support
/// remote APIs or caching in the future.
class CategoryRepository {
  late final CategoryDao _dao;

  Future<void> init() async {
    final db = await DatabaseHelper().database;
    _dao = CategoryDao(db);
  }

  /// Retrieves all categories stored in the database.
  ///
  /// Returns a list of [Category] objects.
  Future<List<Category>> getAllCategories() {
    return _dao.getAllCategories();
  }

  /// Adds a new category to the database.
  ///
  /// [category] is the [Category] object to be inserted.
  Future<void> addCategory(Category category) {
    return _dao.insertCategory(category);
  }

  /// Deletes a category from the database by its [id].
  ///
  /// [id] is the unique identifier of the category to delete.
  Future<void> deleteCategory(String id) {
    return _dao.deleteCategory(id);
  }

  /// Updates an existing category in the database.
  ///
  /// [category] is the updated [Category] object.
  Future<void> updateCategory(Category category) {
    return _dao.updateCategory(category);
  }
}
