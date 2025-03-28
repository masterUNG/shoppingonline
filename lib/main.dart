import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppingonline/firebase_options.dart';
import 'package:shoppingonline/state_web/signin_web.dart';
import 'package:shoppingonline/states/intro.dart';
import 'package:shoppingonline/states/main_home.dart';
import 'package:shoppingonline/states/signin_page.dart';
import 'package:shoppingonline/states/signin_signup.dart';
import 'package:shoppingonline/states/signup_page.dart';
import 'package:shoppingonline/utility/app_constant.dart';

List<GetPage<dynamic>> getPages = [
  GetPage(name: '/intro', page: () => Intro()),
  GetPage(name: '/signinsignup', page: () => SignInSignUp()),
  GetPage(name: '/signIn', page: () => SignInPage()),
  GetPage(name: '/signInWeb', page: () => SignInWebPage()),
  GetPage(name: '/signUp', page: () => SignUpPage()),
  GetPage(name: '/mainHome', page: () => MainHome()),
];

String initialRoute = '/intro';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .whenComplete(() {

        if (GetPlatform.isWeb) {
          //for Web
          initialRoute = '/signInWeb';
          runApp(const MyApp());
        } else {
          //for Mobile
          initialRoute = '/intro';
          runApp(const MyApp());
        }



      });

  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: getPages,
      initialRoute: initialRoute,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: AppConstant.mainColor)),
    );
  }
}
