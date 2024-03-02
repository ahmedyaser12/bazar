import 'package:book_shop/core/utils/colors.dart';
import 'package:book_shop/core/utils/common_functions.dart';
import 'package:book_shop/core/utils/styles.dart';
import 'package:book_shop/screens/profile_screen/data/user_model.dart';
import 'package:flutter/material.dart';

class MyAccountScreen extends StatelessWidget {
  final UserModel userModel;

  const MyAccountScreen({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage(userModel.user!.profilePic!),
            ),
            TextButton(
              onPressed: () {
                // Implement change picture functionality
              },
              child: Text('Change Picture',
                  style: TextStyle(color: AppColors.primary)),
            ),
            heightSpace(24),
            _buildTextField(
                label: 'Name', initialValue: '${userModel.user!.name}'),
            _buildTextField(
                label: 'Email', initialValue: '${userModel.user!.email}'),
            _buildTextField(
                label: 'Phone Number', initialValue: '${userModel.user!.phone}'),
            _buildTextField(
                label: 'Password', initialValue: '••••••••', isPassword: true),
            heightSpace(32),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(AppColors.primary)),
              onPressed: () {
                // Implement save changes functionality
              },
              child: Text(
                'Save Changes',
                style: TextStyles.font15White500weight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String label,
      required String initialValue,
      bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: initialValue,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: isPassword
              ? IconButton(
                  icon: const Icon(Icons.visibility_off),
                  onPressed: () {
                    // Implement password visibility toggle functionality
                  },
                )
              : null,
        ),
      ),
    );
  }
}
