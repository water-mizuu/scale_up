class User {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String password;

  const User(this.id, this.firstName, this.lastName, this.username, this.password);

  User copyWith(
    int? id,
    String? firstName,
    String? lastName,
    String? username,
    String? password,
  ) {
    return User(
      id ?? this.id,
      firstName ?? this.firstName,
      lastName ?? this.lastName,
      username ?? this.username,
      password ?? this.password,
    );
  }

  static const empty = User(0, '', '', '', '');
}
