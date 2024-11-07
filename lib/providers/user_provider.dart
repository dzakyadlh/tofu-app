import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, dynamic> _user = {};
  Map<String, dynamic> get user => _user;

  bool _isLoading =
      true; // Change final to var or just use bool instead of final
  bool get isLoading => _isLoading;

  UserProvider() {
    fetchUserData();
  }

  // Use get() instead of snapshots() to fetch data once
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
        _user = {
          'email': doc['email'],
          'name': doc['name'],
          'birthDate': (doc['birthDate'] as Timestamp).toDate(),
          'occupation': doc['occupation'],
          'phoneNumber': doc['phoneNumber'],
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
  Future<void> updateUserData(String name, DateTime birthDate,
      String occupation, String phoneNumber) async {
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
      fetchUserData();
      notifyListeners();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
