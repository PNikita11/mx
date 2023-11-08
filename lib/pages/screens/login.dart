import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_metabolix_app/pages/screens/forgetpage/ForgetPasswordMailScreen.dart';




import 'homepage.dart';


class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() {
    return _MyLoginState();
  }
}

class _MyLoginState extends State<MyLogin> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image Container
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/login.png"), // Replace with your actual image asset path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Login Content Container
          Container(
            color: Colors.transparent, // Make the container transparent to let the background image show through
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.25,
                  horizontal: 35,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            blurRadius: 5,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _emailController,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          hintText: "Email",
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            blurRadius: 5,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _passwordController,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: const Color(0xff4c505b),
                          child: IconButton(
                            color: Colors.white,
                            onPressed: () {
                              _loginUser();
                            },
                            icon: const Icon(Icons.arrow_forward),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                            elevation: MaterialStateProperty.all<double>(0),
                          ),
                          child: const Text(
                            'Sign Up',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                              builder: (context) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black, // Set the background color
                                  ),
                                  padding: EdgeInsets.all(70.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Make Selection!",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold , color: Colors.white)), // Replace with your desired color,
                                      SizedBox(height: 20), // Add some vertical spacing between the texts
                                      Text("Select the Email options is given to reset your password ",style:  TextStyle(fontSize: 21,color: Colors.white)),
                                      const SizedBox(height: 30.0,),
                                      ForgetPasswordBtnWidget(
                                        btnIcon: Icons.mail_outline_rounded,
                                        title: "E-Mail",
                                        subTitle: "Reset Via Email",
                                        onTap: ()
                                        {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ForgetPasswordMailScreen(), // Replace with the ForgetPasswordMailScreen widget
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  // Add your content here
                                );
                              },
                            );
                          },


                          child: const Text(
                            'Forgot Password',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _loginUser() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      // Show an error message if email or password is empty
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Error'),
              content: Text('Please enter both email and password.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
      );
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // If login is successful, you can show a success message or navigate to the next screen
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Success'),
              content: Text('User logged in successfully.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/home');
                  },
                  child: Text('OK'),
                ),
              ],
            ),
      );
    } on FirebaseAuthException catch (e) {
      // Handle login failure and show an error message
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Error'),
              content: Text(e.message!),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
      );
    }
  }

}

class ForgetPasswordBtnWidget extends StatelessWidget {
  final IconData btnIcon;
  final String title;
  final String subTitle;
  final Null Function() onTap;

  const ForgetPasswordBtnWidget({
    required this.btnIcon,
    required this.title,
    required this.subTitle,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.deepPurpleAccent
        ),
        child: Row(
          children: [
            Icon(btnIcon, size: 60.0),
            const SizedBox(width: 10.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold , color: Colors.black)), // Replace with your desired color,
                SizedBox(height: 5), // Add some vertical spacing between the texts
                Text(subTitle,style:  TextStyle(fontSize: 18,color: Colors.black)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
