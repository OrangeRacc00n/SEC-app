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

  Future<Credential?> tryLogin(
    String imapServerHost,
    int imapServerPort,
    bool imapServerSecure,
    String email,
    String password,
  ) async {
    final client = ImapClient(isLogEnabled: true);
    try {
      await client.connectToServer(
        imapServerHost,
        imapServerPort,
        isSecure: imapServerSecure,
      );
      await client.login(email, password);
      CredentialService credentialService =
          credentialSrvc ?? CredentialService();
      Credential credential = credentialService.buildCredential(
        imapServerHost,
        imapServerPort,
        imapServerSecure,
        email,
        password,
      );
      await client.logout();
      return (await credentialService.addCredential(credential))
          ? credential
          : null;
    } on ImapException catch (e) {
      print(e.message);
    } catch (e) {
      print("Errore generico");
    }
    return null;
  }
}
