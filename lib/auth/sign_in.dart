// ignore_for_file: prefer_const_constructors

import 'package:ct484_final/screens/home/home_screen.dart';
import 'package:ct484_final/services/test_provider.dart';
import 'package:ct484_final/services/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sign_button/sign_button.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  // Handle Google Sign In
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
      scopes: ['email'],
    ).signIn();
    print("Sign in with google");

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/background.png'),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(),
              height: 400,
              width: double.infinity,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Đăng nhập để tiếp tục",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Trường Shop",
                      style: TextStyle(
                          fontSize: 50,
                          color: Colors.white,
                          shadows: [
                            BoxShadow(
                              blurRadius: 5,
                              color: Colors.green.shade900,
                              offset: Offset(3, 3),
                            ),
                          ]),
                    ),
                    SignInButton(
                        buttonType: ButtonType.google,
                        btnText: "Đăng nhập với Google",
                        onPressed: () async {
                          print("click");
                          try {
                            // TestProvider testprovider =
                            //     Provider.of<TestProvider>(context,
                            //         listen: false);
                            // testprovider.test();
                            UserProvider userProvider =
                                Provider.of<UserProvider>(context,
                                    listen: false);

                            final userData = await signInWithGoogle();
                            final user = userData.user;
                            print(user);
                            if (user == null) {
                              return;
                            }
                            userProvider.addUserData(
                              currentUser: user,
                              userEmail: user.email,
                              userImage: user.photoURL,
                              userName: user.displayName,
                            );

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          } catch (e) {
                            print(e);
                            rethrow;
                          }
                        }),
                    // TODO: If user not null navigate to home page
                    SignInButton(
                        buttonType: ButtonType.facebook,
                        btnText: "Đăng nhập Facebook",
                        onPressed: () {
                          print('click');
                        }),
                    Text(
                      "Bằng cách đăng nhập bạn đồng ý với",
                      style: TextStyle(
                          color: Colors.grey[800], fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Điều khoản và dịch vụ",
                      // make this text underline in flutter
                      style: TextStyle(
                          color: Colors.grey[800],
                          decoration: TextDecoration.underline),
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
