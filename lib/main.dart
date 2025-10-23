import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:suits/core/routes/app_routes.dart';
import 'package:suits/features/auth/data/service/local_storage.dart';
import 'package:suits/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalStorageService.init();
  runApp(const Suits());
}

class Suits extends StatelessWidget {
  const Suits({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      routerConfig: AppRoutes.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
