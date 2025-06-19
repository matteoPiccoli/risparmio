import '../../data/models/category.dart';

/// Represents the state of categories in the app.
///
/// This includes:
/// - The list of current categories
/// - Whether data is currently being loaded
/// - An optional error message
class CategoryState {
  final List<Category> categories;
  final bool isLoading;
  final String? error;

  CategoryState({
    required this.categories,
    this.isLoading = false,
    this.error,
  });

  /// Creates a copy of this state with updated values.
  CategoryState copyWith({
    List<Category>? categories,
    bool? isLoading,
    String? error,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
