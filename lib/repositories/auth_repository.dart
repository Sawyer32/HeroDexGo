import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final SharedPreferences _prefs;

  AuthRepository({FirebaseAuth? firebaseAuth, required SharedPreferences prefs})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance, _prefs = prefs;

  Future<void> logIn({required String email, required String password, Map<String, bool> preferences = const {'darkMode': false}}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      setInitialPreferences(preferences);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'An unknown error occurred';
    } catch (_) {
      throw 'An unknown error occurred';
    }
  }

  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'An unknown error occurred';
    }
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> setInitialPreferences(Map<String, bool> preferences) async {
    String encodedMap = json.encode(preferences);
    if (_prefs.getString("settings_preferences") != null) return;
    await _prefs.setString("settings_preferences", encodedMap);
  }
}