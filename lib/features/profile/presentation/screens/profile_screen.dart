// ignore_for_file: avoid_print, use_build_context_synchronously
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/profile/presentation/controller/profile_bloc.dart';
import 'package:e_commerce_app/features/profile/presentation/controller/profile_event.dart';
import 'package:e_commerce_app/features/profile/presentation/controller/profile_state.dart';
import 'package:e_commerce_app/features/profile/presentation/widgets/profile_form.dart';
import 'package:e_commerce_app/features/profile/presentation/widgets/profile_header.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;

  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  bool isEditing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ProfileBloc>(context).add(FetchProfileEvent(widget.uid));
    });
  }

  Future<String> uploadImageToFirebaseStorage(
      File imageFile, String uid) async {
    try {
      final ref =
          FirebaseStorage.instance.ref().child('profile_photos/$uid.jpg');
      await ref.putFile(imageFile);
      final String downloadURL = await ref.getDownloadURL();
      print('Image uploaded successfully. URL: $downloadURL');
      return downloadURL;
    } catch (e) {
      print('Failed to upload image: $e');
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<void> updateUserProfileImage(String uid, String imageUrl) async {
    try {
      final userDoc = FirebaseFirestore.instance.collection('e_users').doc(uid);
      await userDoc.update({'imageUrl': imageUrl});
      print('User document updated with image URL: $imageUrl');
      final box = await Hive.openBox<UserModel>('userBox');
      final user = box.get(uid);
      if (user != null) {
        user.imageUrl = imageUrl;
        box.put(uid, user);
      }
    } catch (e) {
      print('Failed to update profile image: $e');
      throw Exception('Failed to update profile image: $e');
    }
  }

  Future<void> updateUserInfo(String uid, UserModel updatedUser) async {
    try {
      final userDoc = FirebaseFirestore.instance.collection('e_users').doc(uid);
      await userDoc.update(updatedUser.toJson());
      print('User document updated with new info: ${updatedUser.toJson()}');
      final box = await Hive.openBox<UserModel>('userBox');
      box.put(uid, updatedUser);
      print('User data saved in Hive');
    } catch (e) {
      print('Failed to update user info: $e');
      throw Exception('Failed to update user info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            final user = state.user;
            emailController.text = user.email;
            userNameController.text = user.userName;
            phoneNumberController.text = user.phoneNumber;

            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      ProfileHeader(
                        imageUrl: user.imageUrl,
                        onChangePicture: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);

                          if (image != null) {
                            setState(() {
                              isLoading = true; 
                            });

                            try {
                              final File imageFile = File(image.path);
                              final String imageUrl =
                                  await uploadImageToFirebaseStorage(
                                      imageFile, widget.uid);
                              await updateUserProfileImage(
                                  widget.uid, imageUrl);
                              setState(() {});
                              context
                                  .read<ProfileBloc>()
                                  .add(FetchProfileEvent(widget.uid));
                            } catch (e) {
                              print('Error updating profile image: $e');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Failed to update profile image: $e')),
                              );
                            } finally {
                              setState(() {
                                isLoading = false; 
                              });
                            }
                          }
                        },
                      ),
                      ProfileForm(
                        userNameController: userNameController,
                        emailController: emailController,
                        phoneNumberController: phoneNumberController,
                        isEditing: isEditing,
                        onEditSavePressed: () async {
                          if (isEditing) {
                            final updatedUser = UserModel(
                              id: user.id,
                              email: user.email,
                              userName: userNameController.text,
                              phoneNumber: phoneNumberController.text,
                              imageUrl: user.imageUrl,
                              password: user.password,
                            );
                            await updateUserInfo(widget.uid, updatedUser);
                            setState(() {});
                            context
                                .read<ProfileBloc>()
                                .add(FetchProfileEvent(widget.uid));
                          }
                          setState(() {
                            isEditing = !isEditing;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                if (isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            );
          } else {
            return const Center(
              child: Text('Something went wrong. Please try again later.'),
            );
          }
        },
      ),
    );
  }
}
