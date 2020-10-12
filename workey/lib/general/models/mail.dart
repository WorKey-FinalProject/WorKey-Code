class Mail {
  final String sentFrom; // ID
  final String sentTo; // ID
  final String title;
  final String content;
  var _isRead = false;

  Mail(this.sentFrom, this.sentTo, this.title, this.content);

  set setReadStatus(bool isRead) {
    this._isRead = isRead;
  }

  get getReadStatus {
    return _isRead;
  }
}
