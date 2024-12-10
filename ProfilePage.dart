import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.purple, // Adjust based on your theme
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.black, // Background color for dark mode
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(color: Colors.white), // Dark mode label color
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey), // Border color
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple), // Focused border color
                ),
              ),
              style: TextStyle(color: Colors.white), // Text color
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white), // Dark mode label color
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey), // Border color
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple), // Focused border color
                ),
              ),
              style: TextStyle(color: Colors.white), // Text color
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white), // Dark mode label color
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey), // Border color
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple), // Focused border color
                ),
              ),
              style: TextStyle(color: Colors.white), // Text color
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic to save updated profile information
                print('Username: ${_usernameController.text}');
                print('Email: ${_emailController.text}');
                print('Password: ${_passwordController.text}');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple, // Adjust based on your theme
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text('Save', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
