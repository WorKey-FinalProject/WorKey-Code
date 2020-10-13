import 'package:flutter/cupertino.dart';

import '../../general/models/mail.dart';

class MailProvider with ChangeNotifier {
  List<Mail> _allMails = [];

  void addMail(Mail mail) {
    _allMails.add(mail);
  }

  List<Mail> get getAllMails {
    return [..._allMails];
  }

  List<Mail> get unReadEmail {
    return [..._allMails].where((mail) => mail.isRead == false);
  }

  void cleanList() {
    _allMails = [];
  }
}
