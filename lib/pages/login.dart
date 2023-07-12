import 'package:flutter/material.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() {
    return _MyLoginState();
  }
}

class _MyLoginState extends State<MyLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white, // Add white background color
        child: Stack(
          children: [
            Positioned.fill(
              child: Image(
                image: AssetImage("assets/images/login.png"),
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 35),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black, // Set box color to black
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
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18, // Increase font size
                              ), // Set input text color and font size
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ), // Add email icon
                                hintText: "Email",
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18, // Increase font size
                                ), // Set hint text color and font size
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none, // Remove border
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 20,
                                ), // Adjust padding
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black, // Set box color to black
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
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18, // Increase font size
                              ), // Set input text color and font size
                              obscureText: true,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ), // Add lock icon
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18, // Increase font size
                                ), // Set hint text color and font size
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none, // Remove border
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 20,
                                ), // Adjust padding
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
                                  fontSize: 32, // Increase font size
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black, // Set text color to white
                                ),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: const Color(0xff4c505b),
                                child: IconButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/home');
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
                                style: const ButtonStyle(),
                                child: const Text(
                                  'Sign Up',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.black, // Set text color to white
                                    fontSize: 20, // Increase font size
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.black, // Set text color to white
                                    fontSize: 20, // Increase font size
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
