class UserModel {
  String id;
  final String email;
  final String phoneNumber;
  final String? password;
  final String? imageUrl;

  UserModel({
    required this.id,
    required this.email,
    this.password,
    required this.phoneNumber,
    this.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      password: null, // Never retrieve the password
      phoneNumber: json['phoneNumber'],
      imageUrl: json['imageUrl'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
    };
  }
}
