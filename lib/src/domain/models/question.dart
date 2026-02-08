import '../../data/db/db_value_converters.dart';

class Question {
  const Question({
    required this.id,
    required this.week,
    required this.day,
    required this.questionNo,
    required this.question,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.answer,
  });

  final int id;
  final int week;
  final int day;
  final int questionNo;
  final String question;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final int answer;

  List<String> get options => [option1, option2, option3, option4];

  String get correctAnswer {
    switch (answer) {
      case 1:
        return option1;
      case 2:
        return option2;
      case 3:
        return option3;
      case 4:
        return option4;
      default:
        return option1;
    }
  }

  factory Question.fromRow(Map<String, Object?> row) {
    return Question(
      id: DbValueConverter.toInt(row['ID']),
      week: DbValueConverter.toInt(row['WEEK']),
      day: DbValueConverter.toInt(row['DAY']),
      questionNo: DbValueConverter.toInt(row['QUESTION_NO']),
      question: DbValueConverter.toStringValue(row['QUESTION']),
      option1: DbValueConverter.toStringValue(row['OPTION1']),
      option2: DbValueConverter.toStringValue(row['OPTION2']),
      option3: DbValueConverter.toStringValue(row['OPTION3']),
      option4: DbValueConverter.toStringValue(row['OPTION4']),
      answer: DbValueConverter.toInt(row['ANSWER']),
    );
  }
}
