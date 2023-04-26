part of 'omnisense_auth_cubit.dart';

@freezed
class OmnisenseAuthState with _$OmnisenseAuthState {
  const factory OmnisenseAuthState.initial() = _Initial;
  const factory OmnisenseAuthState.loading() = _Loading;
  const factory OmnisenseAuthState.authenticated({
    required OmnisenseUser user,
  }) = _Authenticated;
  const factory OmnisenseAuthState.failure({required String failure}) =
      _Failure;
}
