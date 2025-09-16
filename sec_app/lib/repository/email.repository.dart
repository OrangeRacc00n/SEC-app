import 'package:enough_mail/enough_mail.dart';
import 'package:sec_app/models/credential.dart';
import 'package:sec_app/models/emailInfo.dart';

class EmailRepository {
  Future<Emailinfo> getEmailsFor(Emailinfo inf, Mailbox box) async {
    final ImapClient imapClient = ImapClient(isLogEnabled: true);
    try {
      Credential credential = inf.credential;
      await imapClient.connectToServer(
        credential.imapServer,
        credential.imapPort,
        isSecure: credential.isImapSecure,
      );
      await imapClient.login(credential.username, credential.password);
      Map<String, List<MimeMessage>> savedMessages = {};
      Mailbox boxInfo = await imapClient.selectMailboxByPath(box.path);

      if (boxInfo.messagesExists > 0) {
        final FetchImapResult fetchedEmails = await imapClient
            .fetchRecentMessages(
              messageCount: boxInfo.messagesExists < 10
                  ? boxInfo.messagesExists
                  : 24,
              criteria: 'BODY.PEEK[]',
            );
        savedMessages[box.path] = fetchedEmails.messages;
        inf.messages = savedMessages;
      }
      return inf;
    } on ImapException catch (e) {
      print('IMAP error: $e');
      rethrow;
    } finally {
      if (imapClient.isLoggedIn) {
        await imapClient.logout();
      }
      if (imapClient.isConnected) {
        await imapClient.disconnect();
      }
    }
  }

  Future<Map<String, Emailinfo>> trySyncEmail(
    List<Credential> credentials,
  ) async {
    Map<String, Emailinfo> data = {};

    for (Credential credential in credentials) {
      Emailinfo info = Emailinfo(credential: credential);
      final ImapClient imapClient = ImapClient(isLogEnabled: true);
      try {
        await imapClient.connectToServer(
          credential.imapServer,
          credential.imapPort,
          isSecure: credential.isImapSecure,
        );
        await imapClient.login(credential.username, credential.password);
        final List<Mailbox> mailBoxes = await imapClient.listMailboxes(
          mailboxPatterns: ['*'],
        );

        info.folders = mailBoxes;
      } on ImapException catch (e) {
        print('IMAP error: $e');
        rethrow;
      } finally {
        if (imapClient.isLoggedIn) {
          await imapClient.logout();
        }
        if (imapClient.isConnected) {
          await imapClient.disconnect();
        }
      }

      data[credential.username] = info;
    }

    return data;
  }
}
