import 'package:equatable/equatable.dart';

class Lesson {
  String name;
  String soundUrl;
  List<Question> question;

  Lesson({required this.name, required this.soundUrl, required this.question});

  Map<String, dynamic> toJson() => <String, dynamic>{
        "name": name,
        "questions": question,
        "sound_url": soundUrl,
      };

  factory Lesson.fromJson(Map<String?, dynamic> json) {
    return Lesson(
      name: json['name'],
      question:
        List<dynamic>.from(json['questions'])
          .map((i) => Question.fromJson(i))
          .toList(),
      soundUrl: json['sound_url'],
    );
  }
}

class Question extends Equatable {
  String url;
  String soundUrl;
  bool answer;

  Question({required this.url, required this.soundUrl, required this.answer});

  Map<String, dynamic> toJson() => <String, dynamic>{
        "url": url,
        "answer": answer,
        "sound_url": soundUrl,
      };

  factory Question.fromJson(Map<String?, dynamic> json) {
    return Question(
      url: json['url'],
      answer: json['answer'].toString().toLowerCase() == "true",
      soundUrl: json['sound_url'],
    );
  }

  @override
  List<Object?> get props => [url, soundUrl, answer];
}
