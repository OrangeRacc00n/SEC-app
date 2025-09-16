import 'package:enough_mail/enough_mail.dart';
import 'package:sec_app/models/credential.dart';

class Emailinfo {
  Credential credential;
  List<Mailbox> folders;
  Map<String, List<MimeMessage>> messages;

  Emailinfo({
    required this.credential,
    this.folders = const [],
    this.messages = const {},
  });
}
