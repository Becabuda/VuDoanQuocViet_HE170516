import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';
import '../repositories/sqlite_user_repository.dart';
import '../repositories/user_repository.dart';

class UserState {
  final List<User> items;
  final bool isLoading;

  const UserState({
    this.items = const <User>[],
    this.isLoading = false,
  });

  UserState copyWith({
    List<User>? items,
    bool? isLoading,
  }) {
    return UserState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class UserViewModel extends StateNotifier<UserState> {
  UserViewModel(this.repository) : super(const UserState(isLoading: true)) {
    loadUsers();
  }

  final UserRepository repository;

  Future<void> loadUsers() async {
    final users = await repository.getUsers();
    state = state.copyWith(items: users, isLoading: false);
  }

  Future<void> addUser({
    required String fullName,
    required String email,
    required String avatar,
  }) async {
    // id là placeholder, SQLite AUTOINCREMENT sinh id thật khi insert.
    final draft = User(id: 0, fullName: fullName, email: email, avatar: avatar);
    final saved = await repository.addUser(draft);
    state = state.copyWith(items: <User>[...state.items, saved]);
  }

  Future<void> updateUser(User user) async {
    await repository.updateUser(user);
    state = state.copyWith(
      items: state.items.map((u) => u.id == user.id ? user : u).toList(),
    );
  }

  Future<void> deleteUser(int id) async {
    await repository.deleteUser(id);
    state = state.copyWith(
      items: state.items.where((u) => u.id != id).toList(),
    );
  }
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return SqliteUserRepository();
});

final userViewModelProvider =
    StateNotifierProvider<UserViewModel, UserState>((ref) {
  return UserViewModel(ref.watch(userRepositoryProvider));
});
