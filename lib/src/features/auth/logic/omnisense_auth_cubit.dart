import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:omnisense/src/features/auth/auth.dart';

part 'omnisense_auth_state.dart';
part 'omnisense_auth_cubit.freezed.dart';

class OmnisenseAuthCubit extends HydratedCubit<OmnisenseAuthState> {
  OmnisenseAuthCubit() : super(const OmnisenseAuthState.initial());
  final service = OmnisenseAuthServices();
  Future<void> loginWithGoogle() async {
    emit(const OmnisenseAuthState.loading());
    try {
      final user = await service.signInWithGoogle();
      emit(OmnisenseAuthState.authenticated(user: user));
    } catch (err) {
      emit(OmnisenseAuthState.failure(failure: err.toString()));
    }
  }

  Future<void> signUpWithGoogle() async {
    emit(const OmnisenseAuthState.loading());
    try {
      final user = await service.signUpWithGoogle();
      emit(OmnisenseAuthState.authenticated(user: user));
    } catch (err) {
      emit(OmnisenseAuthState.failure(failure: err.toString()));
    }
  }

  Future<void> continueWithTwitter() async {
    emit(const OmnisenseAuthState.loading());
    try {
      final user = await service.continueWithTwitter();
      emit(OmnisenseAuthState.authenticated(user: user));
    } catch (err) {
      emit(OmnisenseAuthState.failure(failure: err.toString()));
    }
  }

  @override
  OmnisenseAuthState? fromJson(Map<String, dynamic> json) {
    return OmnisenseAuthState.authenticated(
      user: OmnisenseUser.fromMap(json['user'] as Map<String, dynamic>),
    );
  }

  Future<void> logout() async {
    emit(const OmnisenseAuthState.loading());
    await service.logout();
    emit(const OmnisenseAuthState.initial());
  }

  @override
  Map<String, dynamic>? toJson(OmnisenseAuthState state) {
    return state.maybeMap(
      authenticated: (state) => {
        'user': state.user.toMap(),
      },
      orElse: () => {
        'user': null,
      },
    );
  }
}
