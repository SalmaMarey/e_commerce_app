import 'package:hive/hive.dart';

part 'cart_model.g.dart'; // Generated file

@HiveType(typeId: 2)
class Cart {
  @HiveField(0)
  final int productId;

  @HiveField(1)
  final String productName;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final String imageUrl;

  @HiveField(4)
  final int quantity;

  Cart({
    required this.productId,
    required this.productName,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });
}