import 'package:enough_mail/enough_mail.dart';
import 'package:sec_app/models/credential.dart';
import 'package:sec_app/models/emailInfo.dart';

class EmailRepository {
  Future<Map<String, Emailinfo>> trySyncEmail(
    List<Credential> credentials,
  ) async {
    Map<String, Emailinfo> data = {};

    for (Credential credential in credentials) {
      Emailinfo info = Emailinfo();
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
