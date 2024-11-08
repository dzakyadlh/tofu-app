import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tofu/utils/pin_encryption.dart';

class UserProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final PinEncryption _pinEncryption = PinEncryption();

  Map<String, dynamic> _user = {};
  Map<String, dynamic> get user => _user;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  UserProvider() {
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw Exception("Not authenticated");
    }

    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(user.uid).get();
      if (snapshot.exists) {
        final doc = snapshot.data() as Map<String, dynamic>;

        Map<String, dynamic> walletData =
            doc['wallet'] is Map<String, dynamic> ? doc['wallet'] : {};

        _user = {
          'email': doc['email'] ?? '',
          'name': doc['name'] ?? '',
          'birthDate':
              '${(doc['birthDate'] as Timestamp).toDate().day}-${(doc['birthDate'] as Timestamp).toDate().month}-${(doc['birthDate'] as Timestamp).toDate().year}',
          'occupation': doc['occupation'] ?? '',
          'phoneNumber': doc['phoneNumber'] ?? '',
          // Adding wallet data
          'wallet': {
            'balance': walletData['balance'] ?? 0,
            'pin': walletData['pin'] ?? '',
          },
        };
        _isLoading = false; // Set loading to false after fetching data
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  // Update user data and refresh the data
  Future<void> updateUserData(
    String name,
    DateTime birthDate,
    String occupation,
    String phoneNumber,
  ) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('Not authenticated');
    }

    try {
      await _firestore.collection('users').doc(user.uid).update({
        'name': name,
        'birthDate': birthDate,
        'occupation': occupation,
        'phoneNumber': phoneNumber,
      });
      // Fetch the updated data
      await fetchUserData();
      notifyListeners();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<void> createWallet(String pin) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('Not authenticated');
    }

    String encryptedPin = _pinEncryption.hashPin(pin);
    print(encryptedPin.toString());

    try {
      await _firestore.collection('users').doc(user.uid).set({
        'wallet': {
          'accountNumber': '${user.phoneNumber}',
          'balance': 0,
          'pin': encryptedPin,
        },
      }, SetOptions(merge: true));
      print('added wallet');
      await fetchUserData();
    } catch (e) {
      print("Error creating wallet: ${e.toString()}");
      rethrow;
    }
  }

  Future<void> updateWalletBalance(int amount) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('Not authenticated');
    }

    try {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      int currentBalance = userDoc.data()?['wallet']['balance'] ?? 0;
      int newBalance = currentBalance + amount;

      await _firestore.collection('users').doc(user.uid).update({
        'wallet.balance': newBalance,
      });
      await fetchUserData();
    } catch (e) {
      print("Error updating wallet balance: ${e.toString()}");
      rethrow;
    }
  }

  Future<void> setWalletPin(String newPin) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('Not authenticated');
    }

    String encryptedPin = _pinEncryption.hashPin(newPin);

    try {
      await _firestore.collection('users').doc(user.uid).update({
        'wallet.pin': encryptedPin,
      });
      await fetchUserData();
    } catch (e) {
      print("Error setting wallet PIN: ${e.toString()}");
      rethrow;
    }
  }

  Future<bool> verifyPin(String enteredPin) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('Not authenticated');
    }

    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(user.uid).get();
    if (snapshot.exists) {
      final userData = snapshot.data() as Map<String, dynamic>;
      final walletData = userData['wallet'] as Map<String, dynamic>;

      return _pinEncryption.verifyPin(enteredPin, walletData['pin']);
    }
    return false;
  }
}
