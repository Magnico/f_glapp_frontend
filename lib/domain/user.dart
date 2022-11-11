class User {
  final String name;
  final String email;
  final String identification_number;
  final int role;
  final String id;

  // Todo - add more user fields

  const User({
    required this.name,
    required this.email,
    required this.identification_number,
    required this.role,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: json['name'],
        email: json['email'],
        identification_number: json['identification_number'],
        role: json['role'],
        id: json['_id']);
  }

  Map toJson() {
    return {
      'name': name,
      'email': email,
      'identification_number': identification_number,
      'role': role,
      '_id': id,
    };
  }
}
