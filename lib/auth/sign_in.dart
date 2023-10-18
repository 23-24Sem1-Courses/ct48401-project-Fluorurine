// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

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
                        onPressed: () {
                          print('click');
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
