class User {
  final String name;
  final String email;
  final String identificationNumber;
  final int role;

  // Todo - add more user fields

  const User(
      {required this.name,
      required this.email,
      required this.identificationNumber,
      required this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: json['name'],
        email: json['email'],
        identificationNumber: json['identification_number'],
        role: json['role'] | 1);
  }

  Map toJson() {
    return {
      'name': name,
      'email': email,
      'identificationNumber': identificationNumber,
      'role': role
    };
  }
}
