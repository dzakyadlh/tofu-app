import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FinancialPlanProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> _financialPlans = [];
  List<Map<String, dynamic>> get financialPlans => _financialPlans;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  FinancialPlanProvider() {
    fetchFinancialPlans();
  }

  Future<void> fetchFinancialPlans() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('Not authenticated');
    }

    try {
      _firestore
          .collection('users')
          .doc(user.uid)
          .collection('financial_plans')
          .orderBy('deadline', descending: true)
          .snapshots()
          .listen((snapshot) {
        _financialPlans = snapshot.docs.map((doc) {
          // Fetch the required fields from Firestore
          String id = doc.id;
          String title = doc['title'];
          int target = doc['target'];
          DateTime deadline = (doc['deadline'] as Timestamp).toDate();
          DateTime createdAt = (doc['created_at'] as Timestamp).toDate();

          DateTime now = DateTime.now();

          Duration timeRemaining = deadline.difference(now);
          int yearsRemaining = deadline.year - now.year;
          int monthsRemaining = timeRemaining.inDays ~/ 30 % 12;
          int daysRemaining = timeRemaining.inDays % 30;

          return {
            'id': id,
            'title': title,
            'target': target,
            'deadline': deadline,
            'timeRemaining':
                '$yearsRemaining years $monthsRemaining months $daysRemaining days',
            'monthsRemaining': timeRemaining.inDays ~/ 30,
            'createdAt': createdAt
          };
        }).toList();
        _isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> addFinancialPlan(
      String title, int target, DateTime deadline) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('Not authenticated');
    }

    try {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('financial_plans')
          .add({
        'title': title,
        'target': target,
        'deadline': deadline,
        'created_at': FieldValue.serverTimestamp(),
      });
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> removeFinancialPlan(String planId) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('Not authenticated');
    }

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('financial_plans')
        .doc(planId)
        .delete();
  }
}
