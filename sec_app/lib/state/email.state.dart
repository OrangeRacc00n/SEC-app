import 'dart:convert';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sec_app/models/emailInfo.dart';
import 'package:sec_app/repository/email.repository.dart';
import 'package:sec_app/state/auth.state.dart';

class EmailBloc extends Bloc<EmailEvents, EmailState> {
  final EmailRepository emailRepository;
  final Authenticated authenticatedState;

  EmailBloc({required this.emailRepository, required this.authenticatedState})
    : super(EmailStateOk()) {
    on<SyncEmail>((event, emit) async {
      Map<String, Emailinfo> emails = await emailRepository.trySyncEmail(
        authenticatedState.currentCredentials,
      );
      emit(EmailStateOk(emails: emails));
    });
  }
}

// Stato

abstract class EmailState extends Equatable {
  Map<String, Emailinfo> emails;
  bool syncInProgress;

  EmailState({this.emails = const {}, this.syncInProgress = false});

  @override
  List<Object> get props => [
    emails,
    DateTime.now().microsecondsSinceEpoch, // Force the emit of new state
    syncInProgress,
  ];
}

class EmailStateOk extends EmailState {
  EmailStateOk({super.emails});
}

// Eventi

abstract class EmailEvents extends Equatable {
  const EmailEvents();

  @override
  List<Object> get props => [];
}

class SyncEmail extends EmailEvents {}
