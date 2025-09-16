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
      try {
        // 1. Nessun cambiamento qui
        Map<String, Emailinfo> initialEmails = await emailRepository
            .trySyncEmail(authenticatedState.currentCredentials);
        emit(EmailStateOk(emails: initialEmails));

        final Map<String, Emailinfo> fullySyncedEmails = Map.from(
          initialEmails,
        );

        // 2. Usa un ciclo for...of standard, non .entries
        for (final accountKey in fullySyncedEmails.keys) {
          // 3. Prendi lo stato corrente dell'account e salvalo in una variabile locale
          var currentAccountState = fullySyncedEmails[accountKey]!;

          for (final folder in currentAccountState.folders) {
            // 4. Passa lo STATO CORRENTE (aggiornato) al metodo...
            final updatedAccountInfo = await emailRepository.getEmailsFor(
              currentAccountState, // <-- USA LA VARIABILE LOCALE
              folder,
            );

            // 5. ...e aggiorna la variabile locale con il nuovo stato
            currentAccountState = updatedAccountInfo;
          }

          // 6. Solo alla fine del ciclo delle cartelle, aggiorna la mappa principale
          fullySyncedEmails[accountKey] = currentAccountState;

          // (Opzionale ma consigliato) Emetti lo stato dopo ogni account completo
          // per dare un feedback progressivo all'utente senza troppi rebuild.
          emit(EmailStateOk(emails: Map.from(fullySyncedEmails)));
        }

        // 7. L'emissione finale non è più strettamente necessaria se emetti nel ciclo,
        // ma puoi lasciarla per sicurezza.
        emit(EmailStateOk(emails: fullySyncedEmails));
      } catch (e) {
        // Gestione errore
        // emit(EmailStateError(error: e.toString()));
      }
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
