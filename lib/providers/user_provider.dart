import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> fetchUserData() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw Exception("Not authenticated");
    }

    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(user.uid).get();
    return userDoc.data() as Map<String, dynamic>;
  }

  Future<void> updateUserData(String name, DateTime birthDate,
      String occupation, String phoneNumber) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('Not authenticated');
    }

    try {
      await _firestore.collection('users').doc(user.uid).set({
        'name': name,
        'birthDate': birthDate,
        'occupation': occupation,
        'phoneNumber': phoneNumber,
      });
      fetchUserData();
      notifyListeners();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
