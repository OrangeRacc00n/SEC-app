class Credential {
  final String username;
  final String password;
  final String imapServer;
  final int imapPort;
  final bool isImapSecure;

  Credential({
    required this.username,
    required this.password,
    required this.imapServer,
    required this.imapPort,
    required this.isImapSecure,
  });

  @override
  String toString() {
    // TODO: implement toString
    return "${username}:${password}:${imapServer}:${imapPort}:${isImapSecure}";
  }

  factory Credential.fromString(String str) {
    final parts = str.split(':');
    return Credential(
      username: parts[0],
      password: parts[1],
      imapServer: parts[2],
      imapPort: int.parse(parts[3]),
      isImapSecure: parts[4] == 'true',
    );
  }
}
