import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConnectedAccountsProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> _connectedAccounts = [];
  List<Map<String, dynamic>> get connectedAccounts => _connectedAccounts;

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

      _connectedAccounts = snapshot.docs.map((doc) {
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
}
