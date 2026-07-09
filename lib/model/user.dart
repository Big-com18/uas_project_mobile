class UserModel {
  final String name;
  final String email;
  final String password;
  final String phone;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? phone,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
    );
  }
}
