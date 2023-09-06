import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication
import 'form_header_widget.dart'; // Adjust the path as needed

class ForgetPasswordMailScreen extends StatelessWidget {
  const ForgetPasswordMailScreen({Key? key}) : super(key: key);

  Future<void> _resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Password reset email sent successfully
      // You can navigate to a confirmation screen or show a success message here
    } catch (e) {
      // Handle errors (e.g., email not found, network issues)
      // You can show an error message to the user
      print('Error sending password reset email: $e');
    }  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurpleAccent, // Set the background color
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                const SizedBox(height: 10 * 2),
                FormHeaderWidget(
                  image: AssetImage("assets/images/logo.png"),
                  title: "Forget Password".toUpperCase(),
                  crossAxisAlignment: CrossAxisAlignment.center, // Adjust the value to reduce the space
                  textAlign: TextAlign.center,
                ),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "Enter your email",
                          prefixIcon: Icon(Icons.mail_outline_rounded),
                          labelStyle: TextStyle(color: Colors.white), // Set the label text color
                          hintStyle: TextStyle(color: Colors.white), // Set the hint text color
                          prefixIconColor: Colors.white, // Set the prefix icon color
                        ),
                        style: TextStyle(color: Colors.white), // Set the input text color
                      ),

                      const SizedBox(height:30.0),

                      SizedBox(
                        width: 230,
                        child: ElevatedButton(
                          onPressed: () {
                            final email = _emailController.text;
                            _resetPassword(email);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black, // Set the background color
                            onPrimary: Colors.white, // Set the text color
                            elevation: 4, // Set the elevation
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30), // Set the button's border radius
                            ),
                          ),

                          child: Text(
                            "Reset Password",
                            style: TextStyle(fontSize: 21), // Set the text style
                          ),
                        ),
                      ),

                      const SizedBox(height:4.0),

                      SizedBox(
                        width: 230,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Navigate to the next screen or perform other actions
                            Navigator.pushReplacementNamed(context, '/login'); // Navigate to the login screen
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black, // Set the background color
                            onPrimary: Colors.white, // Set the text color
                            elevation: 4, // Set the elevation
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30), // Set the button's border radius
                            ),
                          ),

                          child: Text(
                            "Back",
                            style: TextStyle(fontSize: 21), // Set the text style
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
