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

  DocumentSnapshot? _lastDocument;
  final bool _hasMore = true;

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
        print('transactions');
        print(transactions);
        notifyListeners();
      });
    } catch (e) {
      print("Error fetching transactions: ${e.toString()}");
      rethrow;
    }
  }

  // Future<void> fetchTransactions(int year) async {
  //   final uid = _firebaseAuth.currentUser?.uid;
  //   if (uid == null) return;

  //   try {
  //     // Get date range for the selected year
  //     DateTime startOfYear = DateTime(year, 1, 1);
  //     DateTime endOfYear = DateTime(year + 1, 1, 1);

  //     _transactions.clear();
  //     _lastDocument = null;
  //     _hasMore = true;

  //     await _loadTransactions(startOfYear, endOfYear);
  //   } catch (e) {
  //     print("Error fetching transactions: ${e.toString()}");
  //     rethrow;
  //   }
  // }

  // Future<void> _loadMoreTransactions() async {
  //   if (_isLoading || !_hasMore) return;

  //   final uid = _firebaseAuth.currentUser?.uid;
  //   if (uid == null) return;

  //   try {
  //     DateTime startOfYear = DateTime(DateTime.now().year, 1, 1);
  //     DateTime endOfYear = DateTime(DateTime.now().year + 1, 1, 1);

  //     _transactions.clear();
  //     _lastDocument = null;
  //     _hasMore = true;

  //     await _loadTransactions(startOfYear, endOfYear);
  //   } catch (e) {
  //     print("Error loading more transactions: ${e.toString()}");
  //     rethrow;
  //   }
  // }

  // Future<void> _loadTransactions(
  //     DateTime startOfYear, DateTime endOfYear) async {
  //   _isLoading = true;
  //   notifyListeners();

  //   final uid = _firebaseAuth.currentUser!.uid;

  //   Query query = _firestore
  //       .collection('users')
  //       .doc(uid)
  //       .collection('transactions')
  //       .where('date', isGreaterThanOrEqualTo: startOfYear)
  //       .where('date', isLessThan: endOfYear)
  //       .orderBy('date')
  //       .limit(10);

  //   if (_lastDocument != null) {
  //     query = query.startAfterDocument(_lastDocument!);
  //   }

  //   final snapshot = await query.get();

  //   if (snapshot.docs.isNotEmpty) {
  //     _lastDocument = snapshot.docs.last;
  //     _hasMore = snapshot.docs.length == 10;

  //     _transactions.addAll(snapshot.docs.map((doc) {
  //       String title = doc['title'];
  //       DateTime date = (doc['date'] as Timestamp).toDate();
  //       int price = doc['price'];
  //       String category = doc['category'];
  //       bool isOutcome = doc['isOutcome'];

  //       return {
  //         'title': title,
  //         'date': date,
  //         'price': price,
  //         'category': category,
  //         'isOutcome': isOutcome
  //       };
  //     }).toList());
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

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
