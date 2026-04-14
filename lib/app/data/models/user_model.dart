import 'dart:convert';

class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
  });

  final String id;
  final String name;
  final String phone;
  final String email;

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: (map['name'] ?? '') as String,
      phone: (map['phone'] ?? map['email'] ?? '') as String,
      email: (map['email'] ?? '') as String,
    );
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'phone': phone,
        'email': email,
      };

  String toJson() => jsonEncode(toMap());
}
