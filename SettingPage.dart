import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = true;  // Assuming the default is dark mode
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // Remove the DEBUG banner
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          backgroundColor: _isDarkMode ? Colors.black : Colors.purple,  // Adjust based on mode
          leading: IconButton(
            icon: Icon(Icons.arrow_back),  // Add a back arrow icon
            onPressed: () {
              Navigator.pop(context);  // Navigate to the previous screen
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              // Dark Mode Toggle
              SwitchListTile(
                title: Text('Dark Mode'),
                value: _isDarkMode,
                onChanged: (bool value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                },
              ),
              // Notifications Toggle
              SwitchListTile(
                title: Text('Enable Notifications'),
                value: _notificationsEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
              ),
              // Language Settings
              ListTile(
                title: Text('Language'),
                subtitle: Text('English'),  // Display current language
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Logic to change the language
                },
              ),
              // Privacy Policy
              ListTile(
                title: Text('Privacy Policy'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to privacy policy page or show it in a dialog
                },
              ),
              // Terms and Conditions
              ListTile(
                title: Text('Terms and Conditions'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to terms and conditions page or show it in a dialog
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
