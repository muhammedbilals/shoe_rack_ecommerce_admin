import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/screens/admin_home.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/screens/login_page.dart';


class SudoPage extends StatelessWidget {
  const SudoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
           return const SnackBar(content: Text('something went wrong'));
          } else if (snapshot.hasData) {
            return  AdminHome();
          } else {
            return  LoginPage();
          }
        },
      ),
    );
  }
}