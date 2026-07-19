class User {
  final int id;
  final String fullName;
  final String email;
  final String avatar;

  const User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.avatar,
  });

  User copyWith({
    int? id,
    String? fullName,
    String? email,
    String? avatar,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
    );
  }
}
