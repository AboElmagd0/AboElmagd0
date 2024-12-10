import 'package:flutter/material.dart';

class PurchasePlanningPage extends StatefulWidget {
  @override
  _PurchasePlanningPageState createState() => _PurchasePlanningPageState();
}

class _PurchasePlanningPageState extends State<PurchasePlanningPage> {
  double _budget = 10.0;
  bool _reminderEnabled = false;
  String _selectedCategory = 'Language Enhancer';

  final List<String> _categories = ['Language Enhancer', 'Translator', 'Modifier', 'All'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase Planning'),
        backgroundColor: Colors.purple, // Adjust based on your theme
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Budget Slider
            ListTile(
              title: Text(
                'Budget: \$${_budget.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.white), // Dark mode text color
              ),
              subtitle: Slider(
                min: 10.0,
                max: 50.0,
                value: _budget,
                divisions: 40, // Divisions to cover every $1 step between 10 and 50
                label: '\$${_budget.toStringAsFixed(0)}',
                activeColor: Colors.purple, // Slider active color
                inactiveColor: Colors.grey, // Slider inactive color
                onChanged: (double value) {
                  setState(() {
                    _budget = value;
                  });
                },
              ),
            ),
            // Category Selector
            ListTile(
              title: Text(
                'Category',
                style: TextStyle(color: Colors.white), // Dark mode text color
              ),
              subtitle: DropdownButton<String>(
                value: _selectedCategory,
                isExpanded: true,
                dropdownColor: Colors.grey[850], // Dropdown background color
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category, style: TextStyle(color: Colors.white)), // Dark mode text color
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
              ),
            ),
            // Reminder Toggle
            SwitchListTile(
              title: Text(
                'Set Purchase Reminder',
                style: TextStyle(color: Colors.white), // Dark mode text color
              ),
              value: _reminderEnabled,
              onChanged: (bool value) {
                setState(() {
                  _reminderEnabled = value;
                });
              },
              activeColor: Colors.purple, // Switch active color
              inactiveTrackColor: Colors.grey, // Switch inactive track color
            ),
            // Save Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Logic to save the planning details
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Purchase plan saved!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, // Adjust based on your theme
                ),
                child: Text('Save Purchase Plan'),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black, // Background color for dark mode
    );
  }
}
