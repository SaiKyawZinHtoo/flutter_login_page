import 'package:exercise_login_page/components/my_signbutton.dart';
import 'package:exercise_login_page/components/my_textfield.dart';
import 'package:exercise_login_page/components/square_title.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // test editing Controller
  final usernameController = TextEditingController();
  final passwordConroller = TextEditingController();

  // Sign User in Method
  void singInUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                // logo
                const Icon(
                  Icons.person_2_rounded,
                  size: 150,
                ),
                const SizedBox(
                  height: 20,
                ),
                // Welocomeback
                Text(
                  "Welcome Back My Login Page",
                  style: TextStyle(color: Colors.grey[700], fontSize: 20),
                ),
                const SizedBox(
                  height: 30,
                ),
                // username textfield
                MyTextField(
                  controller: usernameController,
                  hintText: "Username",
                  obscureText: false,
                ),

                const SizedBox(
                  height: 20,
                ),
                // password textfield
                MyTextField(
                  controller: passwordConroller,
                  hintText: "Password",
                  obscureText: true,
                ),

                const SizedBox(
                  height: 10,
                ),

                // forget passwrod
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forget Password?",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                // sign button
                MyButton(
                  onTap: singInUserIn,
                ),

                const SizedBox(
                  height: 30,
                ),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Or Continu With",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                // google button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google image
                    SquareTile(imagePath: "assets/google.png"),
                    const SizedBox(
                      width: 25,
                    ),
                    //apple image
                    SquareTile(imagePath: "assets/apple.png"),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                // not a member register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a Member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      'Register Now',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
