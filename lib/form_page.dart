import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FormPage extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const FormPage(
      {super.key, required this.isDarkMode, required this.onThemeChanged});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  bool isChecked = false;
  String? selectedGender;
  DateTime? selectedDate;
  double selectedAge =  0;
  File? _image;
  final _formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context, firstDate: DateTime(1900), lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _captureImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery );
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color? backGroundColour = Colors.lightBlue[50];
    // SystemChrome.setSystemUIOverlayStyle(
    //     const SystemUiOverlayStyle(statusBarColor: backGroundColour));
    return Scaffold(
        backgroundColor: !widget.isDarkMode
            ? backGroundColour
            : Theme.of(context).appBarTheme.backgroundColor,
        appBar: AppBar(
            toolbarHeight: 32,
            backgroundColor: !widget.isDarkMode
                ? backGroundColour
                : Theme.of(context).scaffoldBackgroundColor,
            title: const AutoSizeText("Register"),
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Theme.of(context).brightness == Brightness.dark
                  ? backGroundColour
                  : Colors.black,
            )),
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 0),
          child: SingleChildScrollView(
              child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  alignment: Alignment.centerRight,
                  child: Switch(
                      activeTrackColor: Colors.grey,
                      activeColor: Colors.black,
                      value: widget.isDarkMode,
                      onChanged: (value) {
                        widget.onThemeChanged(value);
                      }),
                ),
                Center(
                  child:
                      Stack(alignment: AlignmentDirectional.center, children: [
                    Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                          border:
                              Border.all(color: Colors.blue.shade900, width: 2),
                        ),
                        child: _image != null
                            ? ClipOval(
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                  width: 120,
                                  height: 120,
                                ),
                              )
                            : ClipOval(
                                child: Image.network(
                                    'https://randomuser.me/api/portraits/men/1.jpg'),
                              )
                        //const Icon(Icons.person, size: 50),
                        ),
                    Positioned(
                        bottom: 10,
                        right: 10,
                        child: GestureDetector(
                            onTap: _captureImage,
                            child: const SizedBox(
                              width: 20,
                              height: 20,
                              child: Icon(
                                Icons.image,
                                size: 30,
                              ),
                            )))
                  ]),
                ),
                TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter valid name';
                      }
                      if (value.length < 3) {
                        return 'Name must be at least 3 characters';
                      }
                      String pattern = r'^[a-zA-Z\s\-]+$';
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(value)) {
                        return 'Name can only contain letters, spaces, and hyphens';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.person),
                      labelText: 'Name',
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                    )),
                const SizedBox(height: 10),
                TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter valid Email';
                      }
                      String pattern = r'^[^@]+@[^@]+\.[^@]+';
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(value)) {
                        return 'Please enter a valid email address'; // Check if email is formatted correctly
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.mail),
                      labelText: 'Email',
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                    )),
                const SizedBox(height: 15),
                TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid phone number';
                      }
                      String pattern = r'^\+?[1-9]\d{1,14}$';
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(value)) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.phone),
                      labelText: 'Phone Number',
                      prefixText: '+91 ',
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                    )),
                const SizedBox(
                  height: 10,
                ),
                const AutoSizeText(
                  'Gender',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Radio(
                            value: 'Male',
                            groupValue: selectedGender,
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value;
                              });
                            }),
                        const AutoSizeText('Male'),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                            value: 'Female',
                            groupValue: selectedGender,
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value;
                              });
                            }),
                        const AutoSizeText('Female'),
                      ],
                    ),
                  ],
                ),
                if (selectedGender == null)
                  const Text(
                    'Please select your gender.',
                    style: TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 5),
                const AutoSizeText("Date of Birth",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    )),
                TextButton(
                    onPressed: () => _selectDate(context),
                    child: AutoSizeText(
                        selectedDate == null
                            ? "Choose a date"
                            : '$selectedDate'.split(' ')[0],
                        style: const TextStyle(fontSize: 17))),
                if (selectedDate == null)
                  const Text(
                    'Please select your age.',
                    style: TextStyle(color: Colors.red),
                  ),
                const AutoSizeText(
                  "Select your age:",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  child: Slider(
                    value: selectedAge,
                    min: 0,
                    max: 100,
                    label: selectedAge.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        selectedAge = value;
                      });
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 18),
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end, // Align items to the right
                    children: [
                      if (selectedAge == 0)
                        const Padding(
                          padding: EdgeInsets.only(right: 8), // Add some space between the validation message and age text
                          child: Text(
                            'Please select your age.',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      AutoSizeText(
                        selectedAge.round().toString(),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        }),
                    const AutoSizeText("I accept terms and conditions")
                  ],
                ),
                Container(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward,
                        size: 40,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: AutoSizeText("valid")));
                        }
                      },
                      // child: const AutoSizeText("Submit")),
                    ))
              ],
            ),
          )),
        ));
  }
}
