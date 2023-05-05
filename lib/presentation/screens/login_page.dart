import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce_admin/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce_admin/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/widgets/signupbutton.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/widgets/textfieldsignup.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              const Center(
                child: Text(
                  'Login to Account',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              sbox,
              sbox,
              SizedBox(
                height: 100,
              ),
              TextFieldSignUp(icon: Icons.email, title: 'Email'),
              sbox,
              TextFieldSignUp(
                icon: Icons.password,
                title: 'Password',
              ),
              sbox,
              sbox,
              SignUpButton(
                size: size,
                color: colorgreen,
                text: 'Log In',
                // widget: MainPage(),
              ),
              sbox,
              sbox,
            ],
          ),
        ),
      ),
    );
  }
}
