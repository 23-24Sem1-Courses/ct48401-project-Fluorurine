// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_button/sign_button.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  // Handle Google Sign In
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
      scopes: ['email'],
    ).signIn();
    print("sign in with google");

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    print(credential);
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
                    Text("Sign In to continue"),
                    Text(
                      "Vegi",
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
                        onPressed: () async {
                          print("click");
                          try {
                            // final userCredential = await signInWithGoogle();
                            final userData = await signInWithGoogle();
                            final user1 = userData.user;

                            print(user1);
                          } catch (e) {
                            print(e);
                            rethrow;
                          }
                        }),
                    SignInButton(
                        buttonType: ButtonType.facebook,
                        onPressed: () {
                          print('click');
                        }),
                    Text(
                      "By signing in you are agreeing to our ",
                      style: TextStyle(color: Colors.grey[800]),
                    ),
                    Text("Terms and Privacy Policy",
                        style: TextStyle(color: Colors.grey[800]))
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
