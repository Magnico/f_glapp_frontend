class User {
  final String name;
  final String email;
  final String identificationNumber;

  // Todo - add more user fields

  const User(
      {required this.name,
      required this.email,
      required this.identificationNumber});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: json['name'],
        email: json['email'],
        identificationNumber: json['identificationNumber']);
  }

  Map toJson() {
    return {
      'name': name,
      'email': email,
      'identificationNumber': identificationNumber
    };
  }
}
