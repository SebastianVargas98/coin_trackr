class User {
  final String id;
  final String email;
  String userName;
  String name;
  String lastName;
  DateTime birthDate;

  User({
    required this.id,
    required this.email,
    required this.userName,
    required this.name,
    required this.lastName,
    required this.birthDate,
  });
}
