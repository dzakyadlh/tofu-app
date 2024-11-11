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
          String title = doc['title'];
          int target = doc['target'];
          DateTime deadline = (doc['deadline'] as Timestamp).toDate();

          DateTime now = DateTime.now();

          Duration timeRemaining = deadline.difference(now);
          int yearsRemaining = deadline.year - now.year;
          int monthsRemaining = timeRemaining.inDays ~/ 30 % 12;
          int daysRemaining = timeRemaining.inDays % 30;

          int monthlyTarget = (timeRemaining.inDays ~/ 30) != 0
              ? target ~/ (timeRemaining.inDays ~/ 30)
              : target;

          return {
            'title': title,
            'target': target,
            'deadline': deadline,
            'timeRemaining':
                '$yearsRemaining years $monthsRemaining months $daysRemaining days',
            'monthlyTarget': monthlyTarget.isNaN ? 0 : monthlyTarget,
            'monthsRemaining': timeRemaining.inDays ~/ 30,
          };
        }).toList();
        _isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      print(e.toString());
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
      print(e.toString());
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
