
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
  bool canPlayAnswerAnim;

  QAMessage({required this.id, required this.question, this.answer = "", this.conversationRemoteId = 0, required this.canPlayAnswerAnim});

  void appendAnswer(String answer) {
    this.answer += answer;
  }

  void setAnswerTest() {
    answer = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  }

  static QAMessage createQAMsgTest({required String question,
      String answer = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      required bool canPlayAnswerAnim}) {
    return QAMessage(id: 0,
        question: question,
        answer: answer,
        canPlayAnswerAnim: canPlayAnswerAnim);
  }

}