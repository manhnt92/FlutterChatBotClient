
class Conversation {

  List<QAMessage> messages = [];

  Conversation();

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
  bool canPlayAnswerAnim;

  QAMessage({required this.id, required this.question, this.answer = "", required this.canPlayAnswerAnim});

  void setAnswer(String answer) {
    this.answer = answer;
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