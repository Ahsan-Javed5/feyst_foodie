import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:chef/base/base.dart';

part 'sign_up_screen_m.freezed.dart';

@freezed
class SignUpScreenState extends BaseState with _$SignUpScreenState {
  const factory SignUpScreenState.initialized({
    required String appVersion,
    required String email,
    required String password,
    required String baseURL,
    required int baseUrlIndex,
    required bool isBusy,
    @Default(false) bool rememberMe,
    @Default('') String errorMessage,
  }) = Initialized;
}
