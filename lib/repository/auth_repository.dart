import 'package:gethdomains/model/account.dart';

class AuthRepository {
  const AuthRepository();

  Future<UserAccount?> login(/* TODO: What auth params? */) async {
    await Future.delayed(const Duration(seconds: 1));
    return const UserAccount(address: '0x000000');
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
