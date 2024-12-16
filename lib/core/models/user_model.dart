import 'package:hive/hive.dart';

part 'user_model.g.dart'; 

@HiveType(typeId: 0) 
class UserModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String email;

  @HiveField(2)
  String userName;

  @HiveField(3)
  String password;

  @HiveField(4)
  String phoneNumber;

  @HiveField(5)
  String imageUrl;

  UserModel({
    required this.id,
    required this.email,
    required this.userName,
    required this.password,
    required this.phoneNumber,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'userName': userName,
        'password': password,
        'phoneNumber': phoneNumber,
        'imageUrl': imageUrl,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      userName: json['userName'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      imageUrl: json['imageUrl'],
    );
  }
}
