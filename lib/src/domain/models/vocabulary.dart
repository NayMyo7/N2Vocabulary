import '../../data/db/db_value_converters.dart';

class Vocabulary {
  const Vocabulary({
    required this.id,
    required this.week,
    required this.day,
    required this.wordNo,
    required this.kanji,
    required this.furigana,
    required this.burmese,
    required this.english,
    required this.favourite,
    required this.japanese,
  });

  final int id;
  final int week;
  final int day;
  final int wordNo;
  final String kanji;
  final String furigana;
  final String burmese;
  final String english;
  final int favourite;
  final String japanese;

  bool get isFavourite => favourite == 1;

  Vocabulary copyWith({int? favourite, String? japanese}) {
    return Vocabulary(
      id: id,
      week: week,
      day: day,
      wordNo: wordNo,
      kanji: kanji,
      furigana: furigana,
      burmese: burmese,
      english: english,
      favourite: favourite ?? this.favourite,
      japanese: japanese ?? this.japanese,
    );
  }

  factory Vocabulary.fromRow(Map<String, Object?> row) {
    return Vocabulary(
      id: DbValueConverter.toInt(row['ID']),
      week: DbValueConverter.toInt(row['WEEK']),
      day: DbValueConverter.toInt(row['DAY']),
      wordNo: DbValueConverter.toInt(row['WORD_NO']),
      kanji: DbValueConverter.toStringValue(row['KANJI']),
      furigana: DbValueConverter.toStringValue(row['FURIGANA']),
      burmese: DbValueConverter.toStringValue(row['BURMESE']),
      english: DbValueConverter.toStringValue(row['ENGLISH']),
      favourite: DbValueConverter.toInt(row['FAVOURITE']),
      japanese: DbValueConverter.toStringValue(row['JAPANESE']),
    );
  }
}
