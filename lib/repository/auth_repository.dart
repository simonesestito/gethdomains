@JS()
library web3;

import 'dart:js_interop';
import 'dart:js_util';

import 'package:flutter/foundation.dart';
import 'package:gethdomains/model/account.dart';
import 'package:gethdomains/service/sepolia_detector.dart';
import 'package:shared_preferences/shared_preferences.dart';

@JS('canLogin')
external JSPromise _canLogin();

@JS('login')
external JSPromise _login();

@JS('getCurrentUser')
external JSPromise _getCurrentUser();

class AuthRepository {
  static const _kWasLoggedIn = 'wasLoggedIn';
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SepoliaNetworkDetector sepoliaNetworkDetector;

  AuthRepository({required this.sepoliaNetworkDetector});

  Future<bool> canLogin() async {
    try {
      return promiseToFuture<bool>(_canLogin());
    } catch (err) {
      debugPrint('Error checking if can login: $err');
      return false;
    }
  }

  Future<bool> wasLoggedIn() async {
    final prefs = await _prefs;
    return prefs.getBool(_kWasLoggedIn) ?? false;
  }

  Future<UserAccount?> login() async {
    try {
      await sepoliaNetworkDetector.useSepoliaNetwork();
      final accountAddress = await promiseToFuture<String>(_login());

      // Store that the user was logged in
      final prefs = await _prefs;
      await prefs.setBool(_kWasLoggedIn, true);

      return UserAccount(address: accountAddress);
    } catch (err) {
      debugPrint('Error logging in: $err');
      return null;
    }
  }

  Future<UserAccount?> getCurrentUser() async {
    try {
      final accountAddress = await promiseToFuture<String>(_getCurrentUser());
      return UserAccount(address: accountAddress);
    } catch (err) {
      debugPrint('Error fetching current user: $err');
      return null;
    }
  }

  Future<void> logout() async {
    // Impossible to log out of MetaMask.
    // Store that the user was logged out
    final prefs = await _prefs;
    await prefs.setBool(_kWasLoggedIn, false);
  }
}
