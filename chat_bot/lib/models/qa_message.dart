
class Conversation {

  static const int typeQA = 1;
  static const int typeConversation = 2;

  int id;
  int remoteId;
  String title;
  String desc;
  List<QAMessage> messages = [];
  int type;

  Conversation({required this.id, required this.remoteId, required this.title, required this.desc, required this.type});

  void addMessage(QAMessage message) {
    messages.add(message);
  }

  void removeMessage(QAMessage message) {
    messages.remove(message);
  }

}

class QAMessage {

  int id;
  String question;
  String answer = "";
  int conversationRemoteId = 0;

  QAMessage({required this.id, required this.question, this.answer = "", this.conversationRemoteId = 0});

  void appendAnswer(String answer) {
    this.answer += answer;
  }

}