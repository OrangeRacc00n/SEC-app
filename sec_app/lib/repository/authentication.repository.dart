import 'package:enough_mail/enough_mail.dart';
import 'package:sec_app/models/credential.dart';
import 'package:sec_app/services/credentialService.dart';

class AuthenticationRepository {
  final ImapClient? client;
  final CredentialService? credentialSrvc;

  AuthenticationRepository({this.credentialSrvc, this.client});

  Future<List<Credential>> getCredentials() async {
    CredentialService credentialService = credentialSrvc ?? CredentialService();
    return await credentialService.getCredentials();
  }
}
