import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/models/product_model.dart';

class ProductsListWidget extends StatelessWidget {
  final List<Product> products;

  const ProductsListWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final product = products[index];
          return ListTile(
            leading: Image.network(product.image, width: 50, height: 50),
            title: Text(product.title),
            subtitle: Text('\$${product.price}'),
          );
        },
        childCount: products.length,
      ),
    );
  }
}
