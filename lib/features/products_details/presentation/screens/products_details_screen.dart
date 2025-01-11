import 'package:e_commerce_app/features/products_details/presentation/controller/products_details_bloc.dart';
import 'package:e_commerce_app/features/products_details/presentation/controller/products_details_event.dart';
import 'package:e_commerce_app/features/products_details/presentation/controller/products_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductDetailsBloc>().add(FetchProductDetailsEvent(widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductDetailsLoaded) {
            final product = state.product;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(product.image, height: 300, fit: BoxFit.cover),
                  const SizedBox(height: 16),
                  Text(product.title, ),
                  const SizedBox(height: 8),
                  Text('\$${product.price}', ),
                  const SizedBox(height: 16),
                  Text(product.description, ),
                ],
              ),
            );
          } else if (state is ProductDetailsError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}