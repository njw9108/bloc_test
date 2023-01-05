import 'dart:async';

import 'package:bloc_test_2/auth/form_submission_status.dart';
import 'package:bloc_test_2/auth/login/login_bloc.dart';
import 'package:bloc_test_2/auth/login/login_state.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    _streamSubscription = loginBloc.stream.listen(
      (event) {
        final formStatus = event.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loginForm(),
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _userNameField(),
            _passwordField(),
            _loginButton(),
          ],
        ),
      ),
    );
  }

  Widget _userNameField() {
    return StreamBuilder<LoginState>(
        stream: loginBloc.stream,
        initialData: LoginState(),
        builder: (context, AsyncSnapshot<LoginState> snapshot) {
          if (snapshot.hasData) {
            return TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'User Name',
              ),
              validator: (value) => snapshot.data!.isValidUsername
                  ? null
                  : 'Username is too short',
              onChanged: loginBloc.userNameChanged,
            );
          } else {
            return const Center(
              child: Text('유저네임 로딩중입니다~~~~~~~~~~~~~~'),
            );
          }
        });
  }

  Widget _passwordField() {
    return StreamBuilder<LoginState>(
        stream: loginBloc.stream,
        initialData: LoginState(),
        builder: (context, AsyncSnapshot<LoginState> snapshot) {
          if (snapshot.hasData) {
            return TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                icon: Icon(Icons.security),
                hintText: 'Password',
              ),
              validator: (value) => snapshot.data!.isValidPassword
                  ? null
                  : 'Password is too short',
              onChanged: loginBloc.passwordChanged,
            );
          } else {
            return const Center(
              child: Text('패스워드 로딩중입니다~~~~~~~~~~~~~~'),
            );
          }
        });
  }

  Widget _loginButton() {
    return StreamBuilder<LoginState>(
      stream: loginBloc.stream,
      initialData: LoginState(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.formStatus is FormSubmitting?
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      loginBloc.login();
                    }
                  },
                  child: const Text('Login'),
                );
        } else {
          return const Center(
            child: Text('로그인버튼 로딩중입니다~~~~~~~~~~~~~~'),
          );
        }
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
