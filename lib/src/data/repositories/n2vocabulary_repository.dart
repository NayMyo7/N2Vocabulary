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

    // Use a single query with window functions to get both count and data
    final rows = await _db.rawQuery('''
      SELECT *, COUNT(*) OVER() as total_count 
      FROM Vocabulary $whereClause 
      ORDER BY ID 
      LIMIT ? OFFSET ?
    ''', [...whereArgs, pagination.limit, pagination.offset]);

    if (rows.isEmpty) {
      return PaginatedResult(
        items: [],
        totalCount: 0,
        page: pagination.page,
        pageSize: pagination.pageSize,
      );
    }

    final totalCount = rows.first['total_count'] as int;
    final items = rows.map((row) {
      // Remove total_count from the row before mapping to Vocabulary
      final modifiedRow = Map<String, dynamic>.from(row);
      modifiedRow.remove('total_count');
      return Vocabulary.fromRow(modifiedRow);
    }).toList(growable: false);

    return PaginatedResult(
      items: items,
      totalCount: totalCount,
      page: pagination.page,
      pageSize: pagination.pageSize,
    );
  }

  /// Retrieve favourite vocabulary items with pagination
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
}
