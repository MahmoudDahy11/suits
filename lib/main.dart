import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:suits/core/routes/app_routes.dart';
import 'package:suits/core/secret/secret.dart';
import 'package:suits/core/service/get_it.dart';
import 'package:suits/features/auth/data/service/local_storage.dart';
import 'package:suits/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = ApiKeys.publishableKey;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalStorageService.init();
  await getItSetup();

  runApp(const Suits());
}

class Suits extends StatelessWidget {
  const Suits({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRoutes.router,
      debugShowCheckedModeBanner: false,
    );
  }
}


//iphone8009688@gmail.com
//123456789