import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:run_to_claim/auth/auth.dart';

part 'generated/auth_state.freezed.dart';
part 'generated/auth_state.g.dart';

enum AuthStatus { initial, loading, unauthenticated, authenticated }

extension AuthStatusX on AuthStatus {
  bool get isInitial => this == AuthStatus.initial;
  bool get isLoading => this == AuthStatus.loading;
  bool get isUnauthenticated => this == AuthStatus.unauthenticated;
  bool get isAuthenticated => this == AuthStatus.authenticated;
}

@freezed
abstract class AuthState with _$AuthState {
  factory AuthState({
    @Default(AuthStatus.initial) AuthStatus status,
    User? user,
  }) = _AuthState;

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);
}
