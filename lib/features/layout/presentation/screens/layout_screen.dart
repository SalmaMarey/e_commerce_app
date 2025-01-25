// ignore_for_file: avoid_print

import 'package:e_commerce_app/core/error_handler/error_handler.dart';
import 'package:e_commerce_app/core/services/di.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/get_cart_item_usecase.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/update_cart_item_quantity_usecase.dart';
import 'package:e_commerce_app/features/cart/presentation/controller/cart_bloc.dart';
import 'package:e_commerce_app/features/cart/presentation/screens/cart_screen.dart';
import 'package:e_commerce_app/features/fav/presentation/screens/favorite_screen.dart';
import 'package:e_commerce_app/features/home/presentation/screens/home_screen.dart';
import 'package:e_commerce_app/features/profile/presentation/controller/profile_bloc.dart';
import 'package:e_commerce_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int _selectedIndex = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Widget> get _pages {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return [
          const HomeScreen(),
          const Center(child: Text('Please log in to view favorites')),
          const Center(child: Text('Please log in to view cart')),
          const Center(child: Text('Please log in to view profile')),
        ];
      }
      print('User ID: ${user.uid}');
      return [
        const HomeScreen(),
        FavoritesScreen(userId: user.uid),
        BlocProvider(
          create: (context) => CartBloc(
            addToCartUseCase: di<AddToCartUseCase>(),
            getCartItemsUseCase: di<GetCartItemsUseCase>(),
            userId: user.uid,
            removeFromCartUseCase: di<RemoveFromCartUseCase>(),
            updateCartItemQuantityUseCase: di<UpdateCartItemQuantityUseCase>(),
          ),
          child: CartScreen(userId: user.uid),
        ),
        BlocProvider(
          create: (context) => di<ProfileBloc>(),
          child: ProfileScreen(uid: user.uid),
        ),
      ];
    } catch (e) {
      ErrorHandler.handleError(context, 'Failed to load pages: $e');
      return [
        const Center(child: Text('An error occurred. Please try again.')),
      ];
    }
  }

  void _onItemTapped(int index) {
    try {
      setState(() {
        _selectedIndex = index;
      });
    } catch (e) {
      ErrorHandler.handleError(context, 'Failed to navigate: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: const IconThemeData(size: 30),
        unselectedIconTheme: const IconThemeData(size: 25),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: '',
          ),
        ],
      ),
    );
  }
}
