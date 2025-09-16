import 'package:enough_mail/enough_mail.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sec_app/models/emailInfo.dart';

class EmailFolder extends StatelessWidget {
  final Mailbox mailBox;
  final List<MimeMessage> messages;
  const EmailFolder({super.key, required this.mailBox, required this.messages});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 22),
      child: Material(
        child: InkWell(
          onTap: () => print("object"),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(setIconForFolder(mailBox)),
                const SizedBox(width: 12),
                /* 
                Expanded(
                  child: Text(mailBox.encodedName, textAlign: TextAlign.left),
                ),
                */
                Expanded(
                  child: Text(mailBox.encodedPath, textAlign: TextAlign.left),
                ),
                Text("(${messages.length})"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

IconData setIconForFolder(Mailbox box) {
  if (box.isInbox || box.encodedPath == "INBOX") return Symbols.inbox;
  if (box.isTrash || box.encodedPath == "INBOX.Trash") return Symbols.delete;
  if (box.isSent || box.encodedPath == "INBOX.Sent") return Symbols.send;
  if (box.isDrafts || box.encodedPath == "INBOX.Drafts") return Symbols.draft;
  if (box.encodedPath == "INBOX.SPAM") return Symbols.dangerous;
  return Symbols.email;
}
