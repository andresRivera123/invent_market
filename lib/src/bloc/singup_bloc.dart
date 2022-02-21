import 'package:inventmarket_app/src/bloc/validator_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class SignUpBloc with Validator {
  SignUpBloc();

  final _usernameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get usernameStream =>
      _usernameController.stream.transform(usernameValidator);
  Stream<String> get emailStream =>
      _emailController.stream.transform(emailValidator);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(passwordValidator);

  Stream<bool> get signUpValidStream => Rx.combineLatest3(
      usernameStream, emailStream, passwordStream, (a, b, c) => true);

  Function(String) get changeUsername => _usernameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  String get username => _usernameController.value;
  String get email => _emailController.value;
  String get password => _passwordController.value;

  dispose() {
    _usernameController.close();
    _emailController.close();
    _passwordController.close();
  }
}
