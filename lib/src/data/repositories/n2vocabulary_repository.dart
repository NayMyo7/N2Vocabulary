import 'package:flutter/foundation.dart';
import '../../domain/models/paginated_result.dart';
import '../../domain/models/question.dart';
import '../../domain/models/vocabulary.dart';
import '../db/n2vocabulary_database.dart';

class N2VocabularyRepository {
  N2VocabularyRepository(this._db);

  final N2VocabularyDatabase _db;

  /// Retrieve paginated vocabulary with optional search filters
  Future<PaginatedResult<Vocabulary>> retrieveVocabularyPaginated({
    required PaginationParams pagination,
    VocabularySearchFilters filters = const VocabularySearchFilters(),
  }) async {
    final whereConditions = <String>[];
    final whereArgs = <Object?>[];

    // Debug: Check if we have any data at all
    if (filters.week != null && filters.day != null) {
      final testResult = await _db.rawQuery(
          'SELECT COUNT(*) as count FROM Vocabulary WHERE WEEK = ? AND DAY = ?',
          [filters.week!, filters.day!]);
      debugPrint(
          'Database count for week ${filters.week}, day ${filters.day}: ${testResult.first['count']}');
    }

    // Build WHERE clause based on filters
    if (filters.favouritesOnly) {
      whereConditions.add('FAVOURITE = ?');
      whereArgs.add(1);
    }

    if (filters.week != null && filters.day != null) {
      // Both week and day selected: filter by both WEEK and DAY columns
      whereConditions.add('WEEK = ? AND DAY = ?');
      whereArgs.addAll([filters.week!, filters.day!]);
    } else if (filters.week != null) {
      // Only week selected: filter by WEEK column
      whereConditions.add('WEEK = ?');
      whereArgs.add(filters.week!);
    } else if (filters.day != null) {
      // Only day selected: show only first occurrence from Week 1
      whereConditions.add('WEEK = 1 AND DAY = ?');
      whereArgs.add(filters.day!);
    }

    if (filters.query != null && filters.query!.isNotEmpty) {
      final searchQuery = '%${filters.query!.toLowerCase()}%';
      whereConditions.add(
        '(LOWER(KANJI) LIKE ? OR LOWER(FURIGANA) LIKE ? OR LOWER(BURMESE) LIKE ? OR LOWER(ENGLISH) LIKE ? OR LOWER(JAPANESE) LIKE ?)',
      );
      whereArgs.addAll(
          [searchQuery, searchQuery, searchQuery, searchQuery, searchQuery]);
    }

    final whereClause =
        whereConditions.isEmpty ? '' : 'WHERE ${whereConditions.join(' AND ')}';

    // Get total count
    final countResult = await _db.rawQuery(
      'SELECT COUNT(*) as count FROM Vocabulary $whereClause',
      whereArgs,
    );
    final totalCount = countResult.first['count'] as int;

    // Get paginated results
    final rows = await _db.rawQuery(
      'SELECT * FROM Vocabulary $whereClause ORDER BY ID LIMIT ? OFFSET ?',
      [...whereArgs, pagination.limit, pagination.offset],
    );

    final items = rows.map(Vocabulary.fromRow).toList(growable: false);

    return PaginatedResult(
      items: items,
      totalCount: totalCount,
      page: pagination.page,
      pageSize: pagination.pageSize,
    );
  }

  /// Retrieve favourite vocabulary items
  Future<List<Vocabulary>> retrieveFavouriteVocabulary() async {
    final rows =
        await _db.rawQuery('SELECT * FROM Vocabulary WHERE FAVOURITE=?', [1]);
    return rows.map(Vocabulary.fromRow).toList(growable: false);
  }

  Future<PaginatedResult<Vocabulary>> retrieveFavouriteVocabularyPaginated({
    required PaginationParams pagination,
  }) async {
    return retrieveVocabularyPaginated(
      pagination: pagination,
      filters: const VocabularySearchFilters(favouritesOnly: true),
    );
  }

  /// Get total vocabulary count (useful for UI)
  Future<int> getTotalVocabularyCount() async {
    final result =
        await _db.rawQuery('SELECT COUNT(*) as count FROM Vocabulary');
    return result.first['count'] as int;
  }

  /// Get favourite vocabulary count
  Future<int> getFavouriteVocabularyCount() async {
    final result = await _db.rawQuery(
      'SELECT COUNT(*) as count FROM Vocabulary WHERE FAVOURITE=?',
      [1],
    );
    return result.first['count'] as int;
  }

  /// Retrieve vocabulary by ID
  Future<Vocabulary?> retrieveVocabularyById(int id) async {
    final rows = await _db.rawQuery(
      'SELECT * FROM Vocabulary WHERE ID = ?',
      [id],
    );
    if (rows.isEmpty) return null;
    return Vocabulary.fromRow(rows.first);
  }

  Future<void> markFavourite(int id) async {
    await _db.update(
      'Vocabulary',
      {'FAVOURITE': 1},
      where: 'ID=?',
      whereArgs: [id],
    );
  }

  Future<void> removeFavourite(int id) async {
    await _db.update(
      'Vocabulary',
      {'FAVOURITE': 0},
      where: 'ID=?',
      whereArgs: [id],
    );
  }

  /// Retrieve all questions
  Future<List<Question>> retrieveAllQuestions() async {
    final rows = await _db.rawQuery('SELECT * FROM Question ORDER BY ID');
    return rows.map(Question.fromRow).toList(growable: false);
  }

  /// Retrieve questions by week
  Future<List<Question>> retrieveQuestionsByWeek(int week) async {
    final rows = await _db.rawQuery(
      'SELECT * FROM Question WHERE WEEK = ? ORDER BY QUESTION_NO',
      [week],
    );
    return rows.map(Question.fromRow).toList(growable: false);
  }

  /// Retrieve questions by week and day
  Future<List<Question>> retrieveQuestionsByWeekAndDay(
    int week,
    int day,
  ) async {
    final rows = await _db.rawQuery(
      'SELECT * FROM Question WHERE WEEK = ? AND DAY = ? ORDER BY QUESTION_NO',
      [week, day],
    );
    return rows.map(Question.fromRow).toList(growable: false);
  }

  /// Get total question count
  Future<int> getTotalQuestionCount() async {
    final result = await _db.rawQuery('SELECT COUNT(*) as count FROM Question');
    return result.first['count'] as int;
  }
}
