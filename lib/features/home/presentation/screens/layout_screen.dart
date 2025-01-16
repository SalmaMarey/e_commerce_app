import 'package:e_commerce_app/core/services/di.dart';
import 'package:e_commerce_app/features/cart/presentation/cart_screen.dart';
import 'package:e_commerce_app/features/favorite/presentation/screens/favorite_screen.dart';
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
    final user = _auth.currentUser;
    if (user == null) {
      return [
        const HomeScreen(),
        const FavoritesScreen(),
        const CartScreen(),
        const Center(child: Text('Please log in to view profile')),
      ];
    }
    return [
      const HomeScreen(),
      const FavoritesScreen(),
      const CartScreen(),
      BlocProvider(
        create: (context) => di<ProfileBloc>(),
        child: ProfileScreen(uid: user.uid),
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
