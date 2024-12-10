import 'package:expressable/PurchasePlanningPage.dart';
import 'package:expressable/SettingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'ProfilePage.dart';

class LanguageEnhancer extends StatefulWidget {
  const LanguageEnhancer({Key? key}) : super(key: key);

  @override
  _LanguageEnhancerState createState() => _LanguageEnhancerState();
}

class _LanguageEnhancerState extends State<LanguageEnhancer> {
  bool isDarkMode = true; // Initialize dark mode as true (dark mode by default)
  String selectedModelType = 'Language Enhancer'; // Default value for Model Type dropdown
  String selectedTone = 'Romantic'; // Default value for Tone dropdown
  String selectedLanguage = 'English'; // Default value for Language dropdown
  String inputText = ''; // Stores the input text
  TextEditingController _textController = TextEditingController(); // Initialized TextEditingController

  // Voice Recording
  bool isRecording = false;
  FlutterSoundRecorder? _recorder;
  String? _audioPath;

  // Speech Recognition
  stt.SpeechToText? _speech;

  // Map to associate tone options with icons
  final Map<String, IconData> toneIcons = {
    'Romantic': Icons.favorite,
    'Formal': Icons.work,
    'Casual': Icons.beach_access,
    'Friendly': Icons.emoji_emotions,
    'Angry': Icons.sentiment_dissatisfied_outlined,
  };

  // Map for language icons
  final Map<String, String> languageFlags = {
    'English': 'lib/assets/flags/American.png',
    'Spanish': 'lib/assets/flags/Spanish.png',
    'French': 'lib/assets/flags/France.png',
    'German': 'lib/assets/flags/German.png',
    'Arabic': 'lib/assets/flags/Egypt.png',
  };

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _speech = stt.SpeechToText();
    initRecorder();
  }

  @override
  void dispose() {
    _recorder?.closeRecorder();
    _speech?.stop();
    _textController.dispose(); // Dispose the TextEditingController
    super.dispose();
  }

  // Initialize the recorder
  Future<void> initRecorder() async {
    await Permission.microphone.request();
    await _recorder?.openRecorder();
  }

  // Start recording audio and speech recognition
  Future<void> startRecording() async {
    if (!_speech!.isAvailable) {
      print("Speech recognition not available");
      return;
    }

    // Start listening
    bool available = await _speech!.initialize();
    if (available) {
      Directory tempDir = await getTemporaryDirectory();
      _audioPath = '${tempDir.path}/audio_recording.aac';
      await _recorder?.startRecorder(toFile: _audioPath);
      setState(() {
        isRecording = true;
      });

      _speech!.listen(onResult: (result) {
        setState(() {
          inputText = result.recognizedWords; // Update inputText with recognized words
          _textController.text = inputText; // Update the text field
        });
      });
    }
  }

  // Stop recording audio and speech recognition
  Future<void> stopRecording() async {
    await _recorder?.stopRecorder();
    _speech!.stop();
    setState(() {
      isRecording = false;
    });
    print('Recording saved to: $_audioPath');
  }

  // Build UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              splashColor: Colors.purple, // Set the splash color to purple
              borderRadius: BorderRadius.circular(50), // Make the splash effect circular
              child: Container(
                width: 20, // Width of the circular button
                height: 20, // Height of the circular button
                decoration: BoxDecoration(
                  color: Colors.transparent, // Make background transparent to see the splash
                  shape: BoxShape.circle, // Make the container circular
                ),
                child: Center(
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            );
          },
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
              // Settings logic here
            },
            splashColor: Colors.purple, // Set the splash color to purple
            borderRadius: BorderRadius.circular(24), // Make the splash effect circular
            child: Container(
              width: 48, // Width of the circular button
              height: 48, // Height of the circular button
              decoration: BoxDecoration(
                color: Colors.transparent, // Make background transparent to see the splash
                shape: BoxShape.circle, // Make the container circular
              ),
              child: Center(
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: buildDrawer(), // Drawer implementation
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/background.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.7),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 150),
                  // Input Field with Voice Recording
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _textController, // Use the TextEditingController
                            onChanged: (value) {
                              setState(() {
                                inputText = value;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Tell me What do you want ?', // Label text added here
                              labelStyle: TextStyle(color: Colors.white), // Style for the label text
                              hintText: 'Enter your text here',
                              hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        IconButton(
                          icon: isRecording ? Icon(Icons.mic_off, color: Colors.purple) : Icon(Icons.mic, color: Colors.white),
                          onPressed: isRecording ? stopRecording : startRecording,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  buildDropdown('Model Type', selectedModelType, ['Language Enhancer', 'Translator', 'Modifier'], (String? newValue) {
                    setState(() {
                      selectedModelType = newValue!;
                    });
                  }),
                  SizedBox(height: 20),
                  buildDropdownWithIcon('Tone', selectedTone, ['Romantic', 'Formal', 'Casual', 'Friendly', 'Angry'], (String? newValue) {
                    setState(() {
                      selectedTone = newValue!;
                    });
                  }),
                  SizedBox(height: 20),
                  buildDropdownWithFlag('Language', selectedLanguage, ['English', 'Spanish', 'French', 'German', 'Arabic'], (String? newValue) {
                    setState(() {
                      selectedLanguage = newValue!;
                    });
                  }),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      print("Input Text: $inputText");
                      print("Selected Model Type: $selectedModelType");
                      print("Selected Tone: $selectedTone");
                      print("Selected Language: $selectedLanguage");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                  SizedBox(height: 20),
                  buildTextField('Result', 'Result Field', null),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: Text('Save to Hardware', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Drawer implementation
  Widget buildDrawer() {
    return Drawer(
      child: Container(
        color: isDarkMode ? Colors.black : Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: isDarkMode ? Colors.black : Colors.white),
              child: Image.asset('lib/assets/logo.png', height: 50, fit: BoxFit.contain),
            ),
            Material(
              color: Colors.transparent, // Ensure it's transparent to show container color
              child: InkWell(
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                  // add landing page
                },
                splashColor: Colors.purple, // Purple splash effect when clicked
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.person, color: isDarkMode ? Colors.white : Colors.black),
                      SizedBox(width: 16.0, height: 30),
                      Text('Profile', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
                    ],
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                  // add landing page
                },
                splashColor: Colors.purple, // Purple splash effect when clicked
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.settings, color: isDarkMode ? Colors.white : Colors.black),
                      SizedBox(width: 16.0, height: 30),
                      Text('Settings', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
                    ],
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PurchasePlanningPage()));
                  // add landing page
                },
                splashColor: Colors.purple, // Purple splash effect when clicked
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.monetization_on_sharp, color: isDarkMode ? Colors.white : Colors.black),
                      SizedBox(width: 16.0, height: 30),
                      Text('Purchase & Plan', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
                    ],
                  ),
                ),
              ),
            ),
            SwitchListTile(
              title: Text(
                'Dark Mode',
                style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              ),
              value: isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  isDarkMode = value;
                });
              },
              activeColor: Colors.purple, // Set the active color of the switch to purple
              inactiveThumbColor: Colors.grey, // Optional: set the inactive thumb color
            ),
          ],
        ),
      ),
    );
  }

  // Dropdown builder
  Widget buildDropdown(String label, String selectedValue, List<String> options, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.white, fontSize: 16)),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: selectedValue,
            icon: Icon(Icons.arrow_drop_down, color: Colors.white),
            dropdownColor: Colors.black87,
            isExpanded: true,
            underline: SizedBox(),
            onChanged: onChanged,
            items: options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(color: Colors.white)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // Dropdown builder with icon
  Widget buildDropdownWithIcon(String label, String selectedValue, List<String> options, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.white, fontSize: 16)),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: selectedValue,
            icon: Icon(Icons.arrow_drop_down, color: Colors.white),
            dropdownColor: Colors.black87,
            isExpanded: true,
            underline: SizedBox(),
            onChanged: onChanged,
            items: options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Row(
                  children: [
                    Icon(toneIcons[value] ?? Icons.tune, color: Colors.purple),
                    SizedBox(width: 8),
                    Text(value, style: TextStyle(color: Colors.white)),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
  // Dropdown builder with flag
  Widget buildDropdownWithFlag(String label, String selectedValue, List<String> options, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.white, fontSize: 16)),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: selectedValue,
            icon: Icon(Icons.arrow_drop_down, color: Colors.white),
            dropdownColor: Colors.black87,
            isExpanded: true,
            underline: SizedBox(),
            onChanged: onChanged,
            items: options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Row(
                  children: [
                    Image.asset(languageFlags[value]!, width: 24, height: 24),
                    SizedBox(width: 8),
                    Text(value, style: TextStyle(color: Colors.white)),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
  // Text Field builder for results
  Widget buildTextField(String title, String hintText, TextEditingController? controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}