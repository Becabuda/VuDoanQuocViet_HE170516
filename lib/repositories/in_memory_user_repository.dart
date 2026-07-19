import '../models/user.dart';
import 'user_repository.dart';

// Không còn được dùng trong app (đã chuyển sang SqliteUserRepository theo
// yêu cầu đề bài "Lưu trữ dữ liệu: Sử dụng SQLite"). Giữ lại file này
// nguyên trạng vì đề yêu cầu không xóa file đã có sẵn trong project.
class InMemoryUserRepository implements UserRepository {
  final List<User> _users = <User>[];

  @override
  Future<List<User>> getUsers() async {
    return List<User>.from(_users);
  }

  @override
  Future<User> addUser(User user) async {
    final newId = _users.isEmpty
        ? 1
        : _users.map((u) => u.id).reduce((a, b) => a > b ? a : b) + 1;
    final saved = user.copyWith(id: newId);
    _users.add(saved);
    return saved;
  }

  @override
  Future<void> updateUser(User user) async {
    final index = _users.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      _users[index] = user;
    }
  }

  @override
  Future<void> deleteUser(int id) async {
    _users.removeWhere((u) => u.id == id);
  }
}
