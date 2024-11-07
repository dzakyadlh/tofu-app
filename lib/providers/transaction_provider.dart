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
          int price = doc['price'];
          String category = doc['category'];
          bool isOutcome = doc['isOutcome'];

          return {
            'title': title,
            'date': date,
            'price': price,
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
    int price,
    String category,
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
        'price': price,
        'category': category,
        'isOutcome': isOutcome,
        'userId': uid,
      });
      notifyListeners();
    } catch (e) {
      print("Error adding transaction: ${e.toString()}");
      rethrow;
    }
  }
}
