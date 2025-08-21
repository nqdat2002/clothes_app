import 'package:clothes_app/screens/auth/bloc/form/form_submission_status.dart';
import 'package:equatable/equatable.dart';

class SignupState extends Equatable{
  final String email;
  final String password;
  final FormSubmissionStatus formStatus;

  const SignupState({ this.email = '', this.password = '', this.formStatus = const InitialFormStatus()});

  SignupState copyWith({String? email, String? password, FormSubmissionStatus? formStatus}){
    return SignupState(
        email: email ?? this.email,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus
  );
  }

  @override
  List<Object?> get props => [email, password, formStatus];
}