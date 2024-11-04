import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FinancialPlanProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> _financialPlans = [];
  List<Map<String, dynamic>> get financialPlans => _financialPlans;

  Future<void> fetchFinancialPlans(String uid) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('Not authenticated');
    }

    try {
      QuerySnapshot snapshot = await _firestore
          .collection('financial_plans')
          .where('userId', isEqualTo: uid)
          .get();
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

        int monthlyTarget = target ~/ (timeRemaining.inDays ~/ 30);

        return {
          'title': title,
          'target': target,
          'deadline': deadline,
          'timeRemaining':
              '$yearsRemaining years $monthsRemaining months $daysRemaining days',
          'monthlyTarget': monthlyTarget.isNaN ? 0 : monthlyTarget
        };
      }).toList();
      notifyListeners();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<void> addFinancialPlan(
      String uid, String title, int target, DateTime deadline) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('Not authenticated');
    }

    try {
      await _firestore.collection('financial_plans').doc().set({
        'title': title,
        'target': target,
        'deadline': deadline,
        'userId': user.uid,
      });
      fetchFinancialPlans(uid);
      notifyListeners();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<void> removeFinancialPlan(
      String uid, String title, int target, DateTime deadline) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('Not authenticated');
    }

    try {
      await _firestore.collection('financial_plans').doc(user.uid).delete();
      notifyListeners();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
