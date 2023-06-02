import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/screens/login_page.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/screens/sudopage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'ShoeRack Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SudoPage(),
    );
  }
}
