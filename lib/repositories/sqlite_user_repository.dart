import '../models/user.dart';
import '../services/database_helper.dart';
import 'user_repository.dart';

class SqliteUserRepository implements UserRepository {
  SqliteUserRepository({DatabaseHelper? databaseHelper})
      : _databaseHelper = databaseHelper ?? DatabaseHelper.instance;

  final DatabaseHelper _databaseHelper;

  static const _table = 'users';

  @override
  Future<List<User>> getUsers() async {
    final db = await _databaseHelper.database;
    final rows = await db.query(_table, orderBy: 'id ASC');
    return rows.map(_fromRow).toList();
  }

  @override
  Future<User> addUser(User user) async {
    final db = await _databaseHelper.database;
    final id = await db.insert(_table, _toRow(user, includeId: false));
    return user.copyWith(id: id);
  }

  @override
  Future<void> updateUser(User user) async {
    final db = await _databaseHelper.database;
    await db.update(
      _table,
      _toRow(user, includeId: false),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  @override
  Future<void> deleteUser(int id) async {
    final db = await _databaseHelper.database;
    await db.delete(_table, where: 'id = ?', whereArgs: [id]);
  }

  Map<String, Object?> _toRow(User user, {required bool includeId}) {
    return {
      if (includeId) 'id': user.id,
      'fullName': user.fullName,
      'email': user.email,
      'avatar': user.avatar,
    };
  }

  User _fromRow(Map<String, Object?> row) {
    return User(
      id: row['id']! as int,
      fullName: row['fullName']! as String,
      email: row['email']! as String,
      avatar: row['avatar']! as String,
    );
  }
}
