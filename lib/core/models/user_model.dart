class UserModel {
  final String id;
  final String email;
  final String phoneNumber;
  final String password;

  UserModel({required this.id, required this.email, required this.password,required this.phoneNumber});


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
    };
  }
}
