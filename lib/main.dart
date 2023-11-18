import 'package:ct484_final/auth/sign_in.dart';
import 'package:ct484_final/services/check_out_provider.dart';
import 'package:ct484_final/services/product_provider.dart';
import 'package:ct484_final/services/review_cart_provider.dart';
import 'package:ct484_final/services/test_provider.dart';
import 'package:ct484_final/services/user_provider.dart';
import 'package:ct484_final/services/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ct484_final/config/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("Hoan tat khoi tao Firebase");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ProductProvider>(
            create: (context) => ProductProvider(),
          ),
          ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider(),
          ),
          ChangeNotifierProvider<ReviewCartProvider>(
            create: (context) => ReviewCartProvider(),
          ),
          ChangeNotifierProvider<WishListProvider>(
            create: (context) => WishListProvider(),
          ),
          ChangeNotifierProvider<TestProvider>(
            create: (context) => TestProvider(),
          ),
          ChangeNotifierProvider<CheckoutProvider>(
            create: (context) => CheckoutProvider(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
              primaryColor: primaryColor,
              scaffoldBackgroundColor: scaffoldBackgroundColor),
          debugShowCheckedModeBanner: false,
          home: const SignIn(),
        )
        // StreamBuilder(
        //   stream: FirebaseAuth.instance.authStateChanges(),
        //   builder: (context, snapShot) {
        //     if (snapShot.hasData) {
        //       return HomeScreen();
        //     }
        //     return const SignIn();
        //   },
        // ),

        );
  }
}
