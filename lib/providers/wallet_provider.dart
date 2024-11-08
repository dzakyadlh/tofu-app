import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WalletProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  int _balance = 0;
  int get balance => _balance;

  String _pin = '';
  String get pin => _pin;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  WalletProvider() {
    fetchWalletData();
  }

  Future<void> fetchWalletData() async {
    final uid = _firebaseAuth.currentUser?.uid;
    if (uid == null) return;

    try {
      DocumentSnapshot doc =
          await _firebaseFirestore.collection('users').doc(uid).get();
      if (doc.exists) {
        _balance = doc['balance'];
        _pin = doc['pin'];
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print("Error fetching wallet data: ${e.toString()}");
      rethrow;
    }
  }

  Future<void> topUp(int amount) async {
    final uid = _firebaseAuth.currentUser?.uid;
    if (uid == null) return;

    try {
      _balance += amount;
      await _firebaseFirestore.collection('wallet').doc(uid).update({
        'balance': _balance,
      });
      notifyListeners();
    } catch (e) {
      print("Error topping up: ${e.toString()}");
      rethrow;
    }
  }

  Future<void> transfer(int amount, String recipientId) async {
    final uid = _firebaseAuth.currentUser?.uid;
    if (uid == null || amount > _balance) return;

    try {
      _balance -= amount;
      await _firebaseFirestore.collection('wallet').doc(uid).update({
        'balance': _balance,
      });
      await _firebaseFirestore.collection('wallet').doc(recipientId).update({
        'balance': FieldValue.increment(amount),
      });
      notifyListeners();
    } catch (e) {
      print("Error transferring funds: ${e.toString()}");
      rethrow;
    }
  }

  Future<void> updatePin(String newPin) async {
    final uid = _firebaseAuth.currentUser?.uid;
    if (uid == null) return;

    try {
      _pin = newPin;
      await _firebaseFirestore.collection('wallet').doc(uid).update({
        'pin': newPin,
      });
      notifyListeners();
    } catch (e) {
      print("Error updating PIN: ${e.toString()}");
      rethrow;
    }
  }
}
