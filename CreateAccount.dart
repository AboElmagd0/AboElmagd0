import 'package:flutter/material.dart';
import 'package:expressable/LoginPage.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool x = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/background.png'), // Background image
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 60, // Distance from the top
                left: 0,
                right: 240,
                child: Center(
                  child: Image.asset(
                    'lib/assets/logo.png', // Your logo asset
                    height: 60, // Adjust the height as needed
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                top: 165,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lens_rounded, color: Colors.white, size: 15),
                    SizedBox(width: 10),
                    Container(width: 70, height: 1, color: Colors.white),
                    SizedBox(width: 10),
                    Icon(Icons.lens_outlined, color: Colors.white, size: 15),
                    SizedBox(width: 10),
                    Container(width: 70, height: 1, color: Colors.white),
                    SizedBox(width: 10),
                    Icon(Icons.lens_outlined, color: Colors.white, size: 15),
                  ],
                ),
              ),
              Positioned(
                top: 220, // Position to match the layout
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 350,
                left: 40,
                right: 40,
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle, color: Colors.grey),
                        fillColor: Colors.white10,
                        filled: true,
                        hintText: 'Username',
                        hintStyle: TextStyle(color: Colors.white), // Hint text color
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(37),
                        ),
                      ),
                      style: TextStyle(color: Colors.white), // Text color
                    ),
                    SizedBox(height: 25),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle_outlined, color: Colors.grey),
                        fillColor: Colors.white10,
                        filled: true,
                        hintText: 'Name',
                        hintStyle: TextStyle(color: Colors.white), // Hint text color
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(37),
                        ),
                      ),
                      style: TextStyle(color: Colors.white), // Text color
                    ),
                    SizedBox(height: 25),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined, color: Colors.grey),
                        fillColor: Colors.white10,
                        filled: true,
                        hintText: 'E-mail',
                        hintStyle: TextStyle(color: Colors.white), // Hint text color
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(37),
                        ),
                      ),
                      style: TextStyle(color: Colors.white), // Text color
                    ),
                    SizedBox(height: 25),
                    TextField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: x,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline_rounded, color: Colors.grey),
                        suffixIcon: IconButton(
                          icon: x
                              ? Icon(Icons.visibility_off, color: Colors.grey)
                              : Icon(Icons.visibility, color: Colors.grey),
                          onPressed: () {
                            setState(() {
                              x = !x;
                            });
                          },
                        ),
                        fillColor: Colors.white10,
                        filled: true,
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.white), // Hint text color
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(37),
                        ),
                      ),
                      style: TextStyle(color: Colors.white), // Text color
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xCF00021B), // Button background color
                        borderRadius: BorderRadius.circular(37),
                      ),
                      child: TextButton(
                        onPressed: () {// Add your action here
                        },
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            color: Colors.white70, // Text color
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                      child: Text(
                        'Back To LogIn',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
    );
  }
}
