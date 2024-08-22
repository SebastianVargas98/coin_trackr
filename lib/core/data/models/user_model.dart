import 'package:coin_trackr/core/data/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.userName,
    required super.name,
    required super.lastName,
    required super.birthDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      userName: map['userName'] ?? '',
      name: map['name'] ?? '',
      lastName: map['lastName'] ?? '',
      birthDate: DateTime.parse(map['birthDate'] as String),
    );
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? userName,
    String? name,
    String? lastName,
    DateTime? birthDate,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
    );
  }
}
