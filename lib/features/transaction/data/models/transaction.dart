import 'package:uuid/uuid.dart';
import '../../../category/data/models/category.dart';

/// Represents a financial transaction, either an income or an expense.
///
/// Each transaction has an amount, description, date, category, and type.
/// The [TransactionType] indicates whether it's money in or out.
/// An auto-generated UUID is used to uniquely identify each transaction.
class Transaction {
  /// Unique ID for this transaction (auto-generated).
  final String id;

  /// Positive amount of money involved in the transaction.
  final double amount;

  /// Optional description of the transaction (e.g., "Lunch at McDonald's").
  final String description;

  /// Date and time the transaction occurred.
  final DateTime date;

  /// The Category object (with its own type, name and ID).
  final Category category;

  /// Whether the transaction is an [TransactionType.income] or [TransactionType.expense].
  final TransactionType type;

  /// Creates a new transaction with a unique ID.
  ///
  /// Use this factory when you want to create a new transaction without
  /// manually specifying the `id`. This is the main way to construct a transaction.
  factory Transaction.create({
    required double amount,
    required String description,
    required DateTime date,
    required Category category,
    required TransactionType type
  }) {
    return Transaction._internal(
      id: _uuid.v4(),
      amount: amount,
      description: description,
      date: date,
      category: category,
      type: type
    );
  }

  /// Internal constructor that takes a specific ID (used by the factory).
  const Transaction._internal({
    required this.id,
    required this.amount,
    required this.description,
    required this.date,
    required this.category,
    required this.type
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'description': description,
      'date': date.toIso8601String(),
      'category_id': category.id,
      'type': type.name, // Store as string for better readability
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map, Category category) {
    return Transaction._internal(
      id: map['id'],
      amount: map['amount'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      category: category,
      type: TransactionType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => TransactionType.expense, // default/fallback type
      )
    );
  }
}

/// Type of a financial transaction.
enum TransactionType {
  /// An income (e.g., salary, refund).
  income,

  /// An expense (e.g., groceries, bills).
  expense,

  /// A saving (e.g, investing, stocks).
  saving
}

// Internal UUID generator for transaction IDs.
final _uuid = Uuid();
