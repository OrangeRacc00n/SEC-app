import 'package:sec_app/constants/sharedPreferences.constants.dart';
import 'package:sec_app/models/credential.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CredentialService {
  final SharedPreferences? mockDb;

  CredentialService({this.mockDb});

  Future<List<Credential>> getCredentials() async {
    SharedPreferences db = mockDb ?? (await SharedPreferences.getInstance());
    List<String> crds = (await db.getStringList(spCredentials)) ?? [];
    List<Credential> creds = crds.map((e) => Credential.fromString(e)).toList();
    return creds;
  }

  Future<bool> addCredential(Credential credential) async {
    SharedPreferences db = mockDb ?? (await SharedPreferences.getInstance());
    List<Credential> crds = await getCredentials();
    crds.add(credential);
    await db.setStringList(
      spCredentials,
      crds.map((e) => e.toString()).toList(),
    );
    return true;
  }
}
