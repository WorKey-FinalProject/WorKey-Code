class Mail {
  String sentFrom; // ID
  String sentTo; // ID
  String title;
  String content;
  var isRead = false;

  Mail({
    this.sentFrom,
    this.sentTo,
    this.title,
    this.content,
    this.isRead,
  });

  set setReadStatus(bool isRead) {
    this.isRead = isRead;
  }

  get getReadStatus {
    return isRead;
  }

  Map<String, Object> toJson() {
    return {
      'sentFrom': this.sentFrom,
      'sentTo': this.sentTo,
      'title': this.title,
      'content': this.content,
      'isRead': this.isRead,
    };
  }

  void fromJsonToObject(dynamic snapshot) {
    this.sentFrom = snapshot['sentFrom'] ?? '';
    this.sentTo = snapshot['sentTo'] ?? '';
    this.title = snapshot['title'] ?? '';
    this.content = snapshot['content'] ?? '';
    this.isRead = snapshot['isRead'] ?? '';
  }
}
