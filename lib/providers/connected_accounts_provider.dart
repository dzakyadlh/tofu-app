import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConnectedAccountsProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> _connectedAccounts = [];
  List<Map<String, dynamic>> get connectedAccounts => _connectedAccounts;

  int _totalBalance = 0;
  int get totalBalance => _totalBalance;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  ConnectedAccountsProvider() {
    fetchConnectedAccounts();
  }

  Future<void> fetchConnectedAccounts() async {
    final uid = _firebaseAuth.currentUser?.uid;
    if (uid == null) return;

    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('connected_accounts')
          .get();

      _totalBalance = 0;

      _connectedAccounts = snapshot.docs.map((doc) {
        _totalBalance += doc['balance'] as int;
        return {
          'name': doc['name'],
          'accountNumber': doc['accountNumber'],
          'icon': doc['icon'],
          'balance': doc['balance'],
        };
      }).toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print("Error fetching connected accounts: ${e.toString()}");
      rethrow;
    }
  }

  Future<void> addConnectedAccount(Map<String, dynamic> accountData) async {
    final uid = _firebaseAuth.currentUser?.uid;
    if (uid == null) return;

    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('connected_accounts')
          .add(accountData);
      fetchConnectedAccounts();
      notifyListeners();
    } catch (e) {
      print("Error adding connected account: ${e.toString()}");
      rethrow;
    }
  }

  Future<void> updateConnectedAccountBalance(
    String accountNumber,
    int amount,
  ) async {
    final uid = _firebaseAuth.currentUser?.uid;
    if (uid == null) return;

    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('connected_accounts')
          .where('accountNumber', isEqualTo: accountNumber)
          .get();

      if (snapshot.docs.isNotEmpty) {
        DocumentReference docRef = snapshot.docs.first.reference;

        await docRef.update({
          'balance': FieldValue.increment(amount),
        });

        fetchConnectedAccounts();
        notifyListeners();
      }
    } catch (e) {
      print("Error updating connected account balance: ${e.toString()}");
      rethrow;
    }
  }

  Future<int> calculateTotalBalance() async {
    try {
      int totalBalance = 0;
      for (final account in _connectedAccounts) {
        totalBalance += account['balance'] as int;
      }
      return totalBalance;
    } catch (e) {
      print(
          "Error calculating connected accounts total balance: ${e.toString()}");
      rethrow;
    }
  }
}
