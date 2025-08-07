class User {
  final int id;
  final String fullName;
  final String email;
  final String phone;
  final String address;
  final String gender;
  final DateTime dateOfBirth;
  final bool kycVerified;
  final bool active;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.address,
    required this.gender,
    required this.dateOfBirth,
    required this.kycVerified,
    required this.active,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      gender: json['gender'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      kycVerified: json['kycVerified'],
      active: json['active'],
    );
  }
}
