import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/category.dart';
import '../../data/repositories/category_repository.dart';
import 'category_state.dart';

/// A [StateNotifier] that manages the state of categories.
///
/// It interacts with the [CategoryRepository] to fetch, add, update,
/// and delete categories from the database, and updates the UI state accordingly.
class CategoryNotifier extends StateNotifier<CategoryState> {
  final CategoryRepository _repository;

  /// Creates a [CategoryNotifier] with the given repository
  /// and loads initial categories.
  CategoryNotifier(this._repository)
      : super(CategoryState(categories: [])) {
    loadCategories(); // Load initial data
  }

  /// Loads all categories from the repository and updates the state.
  Future<void> loadCategories() async {
    state = state.copyWith(isLoading: true);
    try {
      final categories = await _repository.getAllCategories();
      state = state.copyWith(categories: categories, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  /// Adds a new category to the database and reloads the category list.
  Future<void> addCategory(Category category) async {
    await _repository.addCategory(category);
    await loadCategories(); // Refresh the state
  }

  /// Deletes a category by ID and refreshes the state.
  Future<void> deleteCategory(String id) async {
    await _repository.deleteCategory(id);
    await loadCategories();
  }

  /// Updates an existing category and reloads the data.
  Future<void> updateCategory(Category category) async {
    await _repository.updateCategory(category);
    await loadCategories();
  }
}
