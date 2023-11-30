import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';

@freezed
class UserAccount with _$UserAccount {
  const factory UserAccount({
    required String address,
  }) = _UserAccount;
}