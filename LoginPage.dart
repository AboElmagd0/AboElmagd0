import 'package:expressable/CreateAccount.dart';
import 'package:flutter/material.dart';
import 'package:expressable/LanguageEnhancer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool x = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Control the position of the logo with these values
  double logoTop = 10; // Distance from the top of the screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/assets/background.png'), // Your background image asset
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: logoTop,
                left: logoTop,
                right: logoTop,
                height: 350,
                child: SizedBox(
                  height: 250,
                  child: Image.asset(
                    'lib/assets/logo.png', // Your logo asset
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                top: logoTop + 500, // Adjust based on logo height and desired spacing
                left: 40, // Same left as logo or adjusted as needed
                right: 40, // Ensuring full width with margin
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined, color: Colors.grey),
                        fillColor: Colors.white10,
                        filled: true,
                        hintText: 'E-mail',
                        hintStyle: TextStyle(color: Colors.white), // Hint text color
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(37)),
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
                              borderRadius: BorderRadius.circular(37))),
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
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => LanguageEnhancer()));
                          // Add your action here
                        },
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            color: Colors.white70, // Text color
                            fontSize: 17,
                            fontWeight: FontWeight.w900,),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>CreateAccount(),));
                            },
                            child: Text(
                              'Create Account',
                              style: TextStyle(fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'Need Help?',
                              style: TextStyle(fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )),
                      ],
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
