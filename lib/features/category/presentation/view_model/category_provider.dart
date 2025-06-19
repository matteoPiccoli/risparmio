import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/category_repository.dart';
import '../../data/models/category.dart';
import './category_notifier.dart';
import './category_state.dart';

/// Provides an asynchronously created instance of the [CategoryRepository].
final categoryRepositoryProvider = FutureProvider<CategoryRepository>((ref) async {
  return await CategoryRepository.create();
});

final categoryNotifierProvider = StateNotifierProvider<CategoryNotifier, CategoryState>((ref) {
  throw UnimplementedError('Must be used with categoryNotifierProviderFuture');
});

/// Use this instead to get the fully initialized notifier
final categoryNotifierProviderFuture =
    FutureProvider<CategoryNotifier>((ref) async {
  final repo = await ref.watch(categoryRepositoryProvider.future);
  final notifier = CategoryNotifier(repo);
  return notifier;
});
