import 'package:exercise_login_page/components/my_signbutton.dart';
import 'package:exercise_login_page/components/my_textfield.dart';
import 'package:exercise_login_page/components/square_title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // test editing Controller
  final emailController = TextEditingController();
  final passwordConroller = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Sign User up Method
  void singInUserUp() async {
    //show loding circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    //try creating user
    try {
      //check if password is confirmed
      if (passwordConroller.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordConroller.text);
      } else {
        //show error message, password doesn't match
        showErrorMessage("Password Doesn't Match!");
      }
      // pop the loading the circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading the circle
      Navigator.pop(context);
      //show error message
      showErrorMessage(e.code);
    }
  }

  //wrong email message popup
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

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
                  height: 25,
                ),
                // logo
                const Icon(
                  Icons.person_2_rounded,
                  size: 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                // Create Account
                Text(
                  "Create Your Account Here?",
                  style: TextStyle(color: Colors.grey[700], fontSize: 20),
                ),
                const SizedBox(
                  height: 30,
                ),
                // email textfield
                MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),

                const SizedBox(
                  height: 10,
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

                // confirm textfield
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                  obscureText: true,
                ),

                const SizedBox(
                  height: 10,
                ),

                const SizedBox(
                  height: 25,
                ),

                // sign button
                MyButton(
                  text: "Sign Up",
                  onTap: singInUserUp,
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
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login Now',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
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
