import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TransactionProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> _transactions = [];
  List<Map<String, dynamic>> get transactions => _transactions;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  // Constructor to initialize data
  TransactionProvider() {
    fetchTransactions(DateTime.now().year);
  }

  Future<void> fetchTransactions(int year) async {
    final uid = _firebaseAuth.currentUser?.uid;
    if (uid == null) return;

    try {
      // Clear previous transactions before fetching new ones
      _transactions.clear();

      // Get date range for the selected year
      DateTime startOfYear = DateTime(year, 1, 1);
      DateTime endOfYear = DateTime(year + 1, 1, 1);

      _firestore
          .collection('users')
          .doc(uid)
          .collection('transactions')
          .where('date', isGreaterThanOrEqualTo: startOfYear)
          .where('date', isLessThan: endOfYear)
          .snapshots()
          .listen((snapshot) {
        _transactions = snapshot.docs.map((doc) {
          String title = doc['title'];
          DateTime date = (doc['date'] as Timestamp).toDate();
          int amount = doc['amount'];
          String category = doc['category'];
          bool isOutcome = doc['isOutcome'];

          return {
            'title': title,
            'date': date,
            'amount': amount,
            'category': category,
            'isOutcome': isOutcome
          };
        }).toList();
        _isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      print("Error fetching transactions: ${e.toString()}");
      rethrow;
    }
  }

  Future<void> addTransaction(
    String title,
    DateTime date,
    int amount,
    String category,
    String status,
    String method,
    Map<String, dynamic> receiver,
    bool isOutcome,
  ) async {
    final uid = _firebaseAuth.currentUser?.uid;
    if (uid == null) return;

    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('transactions')
          .add({
        'title': title,
        'date': date,
        'amount': amount,
        'category': category,
        'status': status,
        'method': method,
        'receiver': receiver,
        'isOutcome': isOutcome,
      });
      notifyListeners();
    } catch (e) {
      print("Error adding transaction: ${e.toString()}");
      rethrow;
    }
  }

  Map<String, List<Map<String, double>>> getMonthlySummary(int year) {
    List<Map<String, double>> monthlySummary =
        List.generate(12, (index) => {'income': 0, 'outcome': 0});

    for (var transaction in _transactions) {
      DateTime date = transaction['date'];
      if (date.year == year) {
        int monthIndex =
            date.month - 1; // Convert to 0-based index for the array
        double amount = transaction['amount'].toDouble();
        bool isOutcome = transaction['isOutcome'];

        if (isOutcome) {
          monthlySummary[monthIndex]['outcome'] =
              (monthlySummary[monthIndex]['outcome'] ?? 0) + amount;
        } else {
          monthlySummary[monthIndex]['income'] =
              (monthlySummary[monthIndex]['income'] ?? 0) + amount;
        }
      }
    }

    return {
      'monthlySummary': monthlySummary,
    };
  }
}
