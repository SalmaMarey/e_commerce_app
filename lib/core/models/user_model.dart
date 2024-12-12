class UserModel {
  final String id;
  final String email;
  final String phoneNumber;
  final String password;
  final String? imageUrl;

  UserModel({
    required this.id,
    required this.email,
    required this.password,
    required this.phoneNumber,
    this.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl, 
    };
  }
}
