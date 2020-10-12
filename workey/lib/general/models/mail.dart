class Mail {
  String sentFrom; // ID
  String sentTo; // ID
  String title;
  String content;
  var _isRead = false;

  Mail({
    this.sentFrom,
    this.sentTo,
    this.title,
    this.content,
  });

  set setReadStatus(bool isRead) {
    this._isRead = isRead;
  }

  get getReadStatus {
    return _isRead;
  }

  Map<String, Object> toJson() {
    return {
      'sentFrom': this.sentFrom,
      'sentTo': this.sentTo,
      'title': this.title,
      'content': this.content,
      'isRead': this._isRead,
    };
  }

  void fromJsonToObject(Map snapshot) {
    this.sentFrom = snapshot['sentFrom'] ?? '';
    this.sentTo = snapshot['sentTo'] ?? '';
    this.title = snapshot['title'] ?? '';
    this.content = snapshot['content'] ?? '';
    this._isRead = snapshot['isRead'] ?? '';
  }
}
