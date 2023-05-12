import 'package:chat_bot/models/qa_message.dart';
import 'package:chat_bot/utils/sqlite.dart';
import 'package:flutter/material.dart';

class HomeViewModel with ChangeNotifier {

  final List<Conversation> conversations = [];
  List<String> tabsTitle = [
    'Education', 'Fun', 'Daily Lifestyle', 'Health & Nutrition', 'Astrology',
    'Art', 'Travel', 'Business & Marketing', 'Social', 'Career', 'E-mail'
  ];
  List<Map<String, String>> tabsContent = [
    {
      'Science Chat' : '',
      'English Teacher' : '',
      'Translator' : '',
      'Math Teacher' : '',
      'Create a Short Essay on any Topic' : '',
      'Citation Generator for any style' : '',
      'Course Generator on any Topic' : '',
    },
    {
      'Talk to Neo in the Matrix': '',
      'Dream Interpreter': '',
      'Turn any text into emoji': '',
      'Cat-Friend': '',
      'Tell me a joke': '',
      'Give advice like Elon Musk about Car': '',
      'Kyle in South Park': '',
      'Play Chess': '',
      'Play Trivia Quest': '',
      'Minecraft Steve': '',
      'Eminem-style Jokes about Max Payne': '',
      'Son Goku in Dragon Ball': '',
    },
    {
      'Daily Horoscope/Love, Money, Mood, Health': '',
      'Outfit Idea (Harmonious with Event Concept)': '',
      'How many liters of water should I drink in a day?': '',
      'Make-Up Idea compatible with Concept and Outfit': '',
      'Meal Order Idea for Breakfast, Lunch, Dinner, and Night Snacks': '',
      'Jovial Mentor Wisdom for Lifes Queries': ''
    },
    {
      'Life Coach': '',
      'Dietitian': '',
      '6 yoga Poses': '',
      '3 Tips to Get Sleep More Efficient': '',
      'Recipe for My Ingredients, Meal and Diet type': '',
      'How many calories should I eat in a day?': '',
      'Youtube Channels about Health, Nutrition and Sports': '',
      'Training Plan Generator': ''
    },
    {
      'Daily Horoscope/Love, Money, Mood, Health': '',
      'What are 10 characteristic features of my zodiac sign?': '',
      'Interpretation your Horoscope Map': '',
      'Tarot Analysis': '',
      'Weekly Horoscope': '',
      'Music & Movies match with your Zodiac Sign': '',
      'Is an Aries Woman and Gemini Man a Good Match?': ''
    },
    {
      'Write J.K.Rowling-style Short Story': '',
      'Write Travis Scott-style Song Lyrics': '',
      'Create a Playlist Similar to your Favourite Song': '',
      'Storyteller': '',
      'Book Recommendations': '',
      'Poem Generator': '',
      'Movie and Series Critic': '',
      'Song Recommendation match for your Mood and Genre': '',
      'Write a South Park Episode': ''
    },
    {
      'Vacation Planner': '',
      'Local Foods': '',
      'Best time to Visit': '',
      'Activities': '',
      'Budgeting Tips': '',
      'Prepare Itinerary': '',
      'Cultural Legal Advisor For Safe Travels': '',
      'Time-Travel Machine': ''
    },
    {
      'Sell me this pen!': '',
      'Social Media Manager': '',
      'Business Idea': '',
      'Digital Marketing Strategy': '',
      'SEO Generator': '',
      'Slide Presentation': '',
      'Prepare a Professional Business Plan': '',
      'All-in-one Marketing': '',
      'Social Media Caption Generator': ''
    },
    {
      'Gift Ideas': '',
      'Suggest 3 Event Ideas': '',
      "Win someone's heart on a dating app": '',
      'Ice Breaker Game without any materials': '',
      'Outfit Idea (Harmonious with Event Concept)': '',
      'New Topic to Open a Conversation': '',
      'Birthday Message': ''
    },
    {
      'Generate Secure Passwords': '',
      'Interview Question': '',
      'Career Counselor': '',
      'Self-Help Book': '',
      'Statistician': '',
      'Financial Planning': '',
      'To-Do List Creator for Specific Task': ''
    },
    {
      'Write Am Email To Promote The Sale': '',
      'Newsletter Template': '',
      'Mail Response For Angry Client': '',
      'Email Subject Lines For High Open Rates': '',
      'Mass Marketing Email': '',
      'Text Formalizer Prettifier And Fixer' : '',
      'Email Responder (Friendly/Professional)': ''
    }
  ];

  void getAllConversation() {
    SQLite.instance.getAllConversation().then((value) {
      conversations.clear();
      // conversations.add(Conversation(id: 1000000, title: "Hello world c++ Hello world c++ Hello world c++", desc: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", type: 0));
      // conversations.add(Conversation(id: 10000000, title: "Hello world c++", desc: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", type: 0));
      conversations.addAll(value);
      notifyListeners();
    });
  }

  void updateConversation(Conversation conv, String newTitle) {
    conv.title = newTitle;
    SQLite.instance.updateConversation(conv);
    notifyListeners();
  }

  void deleteConversation(Conversation conv) {
    SQLite.instance.deleteConversation(conv);
    conversations.remove(conv);
    notifyListeners();
  }

}