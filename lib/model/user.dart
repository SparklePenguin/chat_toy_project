final class User {
  factory User.fromMap(Map<String, dynamic> map) => User(
        id: map['user_id'],
        username: map['username'],
        email: map['email'],
        createdAt: map['created_at'] != null
            ? DateTime.parse(map['created_at'])
            : null,
        updatedAt: map['updated_at'] != null
            ? DateTime.parse(map['updated_at'])
            : null,
      );

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String username;
  String email;
  DateTime? createdAt;
  DateTime? updatedAt;
}
