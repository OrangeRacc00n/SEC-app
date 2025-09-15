import 'package:enough_mail/enough_mail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sec_app/models/credential.dart';
import 'package:sec_app/repository/authentication.repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationRepository authenticationrepository;

  AuthenticationBloc({required this.authenticationrepository})
    : super(AuthenticationInitial()) {
    on<AddAccountEvent>((event, emit) async {
      if (state is Unauthenticated) {
        emit(AuthLoading());
      }
    });

    on<CheckAccountEvent>((event, emit) async {
      emit(AuthLoading());
      List<Credential> credentials = await authenticationrepository
          .getCredentials();
      if (credentials.isEmpty) {
        emit(Unauthenticated());
      } else {
        emit(Authenticated(currentCredentials: credentials));
      }
    });
  }
}

// State
abstract class AuthenticationState extends Equatable {
  final List<Credential> currentCredentials;
  AuthenticationState({this.currentCredentials = const []});

  @override
  List<Object> get props => [currentCredentials];
}

// Status of auth is undefined
class AuthenticationInitial extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  Authenticated({required super.currentCredentials});
}

class Unauthenticated extends AuthenticationState {}

class AuthLoading extends AuthenticationState {}

// Events
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AddAccountEvent extends AuthenticationEvent {
  final String username;
  final String password;
  final String imapServer;
  final int imapPort;
  final bool isImapSecure;

  const AddAccountEvent(
    this.username,
    this.password,
    this.imapServer,
    this.imapPort,
    this.isImapSecure,
  );

  @override
  List<Object> get props => [username, password];
}

class CheckAccountEvent extends AuthenticationEvent {}
