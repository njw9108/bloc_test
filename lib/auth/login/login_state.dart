import 'package:bloc_test_2/auth/form_submission_status.dart';

class LoginState {
  final String userName;
  final String password;
  final FormSubmissionStatus formStatus;

  bool get isValidUsername => userName.length > 3;

  bool get isValidPassword => password.length > 6;

  LoginState({
    this.userName = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith(
      {String? userName, String? password, FormSubmissionStatus? formStatus}) {
    return LoginState(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
