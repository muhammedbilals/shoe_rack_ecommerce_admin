import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce_admin/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce_admin/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce_admin/core/utils/utils.dart';
import 'package:shoe_rack_ecommerce_admin/main.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/screens/admin_home.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/widgets/signupbutton.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/widgets/textfieldsignup.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
   LoginPage({super.key});
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;


    String? passwordValidator(String? password) {
      if (password!.isEmpty) {
        return 'Password empty';
      } else if (password.length < 8) {
        return 'sdafhlkdshf';
      }
      return null;
    }

    // String? emailaddressValidator(String? email) {
    //   if (!EmailValidator.validate(emailController.text.trim())) {
    //     return 'invalid email';
    //   }

    //   return null;
    // }

    Future<void> signIn() async {
      // final isValid = formKey.currentState!.validate();
      // if (!isValid) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdminHome(),
            ));
      } on FirebaseAuthException catch (e) {
        print(e.message);
        // utils.showSnackbar(e.message);
      }
      navigatorKey.currentState!.popUntil((route) => route.isFirst);

      return;
    }

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
              TextFieldSignUp(
                controller: emailController,
                icon: Icons.email, title: 'Email'),
              sbox,
              TextFieldSignUp(
                controller: passwordController,
                icon: Icons.password,
                title: 'Password',
              ),
              sbox,
              sbox,
              InkWell(
                onTap: () {
                  // StreamBuilder(
                  //   stream: FirebaseAuth.instance.authStateChanges(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.done) {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) => MainPage(),
                  //           ));
                  //     } else {
                  //       return SnackBar(
                  //           content: Text('Something went wrong'));
                  //     }
                  //     return LoginOrSignUp();
                  //   },
                  // );

                  signIn();
                },
                child: Container(
                  width: size.width * 0.9,
                  height: size.width * 0.13,
                  decoration: BoxDecoration(
                      border: Border.all(color: colorgreen),
                      borderRadius: BorderRadius.circular(20),
                      color: colorgreen),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Log In',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
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
