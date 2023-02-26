class SignInState {
  SignInState({this.username = '', this.password = '', this.fetching = false});

  final String username, password;
  final bool fetching;

  // factory SignInState.copyWith()=>;
  SignInState copywith({
    String? username,
    String? password,
    bool? fetching,
  }) {
    return SignInState(
        username: username ?? this.username,
        password: password ?? this.password,
        fetching: fetching ?? this.fetching);
  }
}
