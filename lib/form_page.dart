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
  double selectedAge = 0;
  File? _image;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String? passwordValidator(String? value) {
    String pattern = r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$';
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (!regex.hasMatch(value)) {
      return 'Password must contain at least 1 capital letter, 1 number, 1 special character, and be at least 8 characters long.';
    }
    return null;
  }

  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

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
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (selectedGender == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select your gender.")),
        );
        return;
      }
      if (selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select your date of birth.")),
        );
        return;
      }
      if (selectedAge == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select your age.")),
        );
        return;
      }
      if (!isChecked) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("You must accept the terms.")),
        );
        return;
      }

      // Collect all data
      String name = nameController.text;
      String email = emailController.text;
      String phone = phoneController.text;
      String gender = selectedGender!;
      String dob = selectedDate.toString().split(' ')[0]; // Extract date part only
      double age = selectedAge;
      File? profileImage = _image;
      String password = passwordController.text;

      // Use the collected data (print, submit, etc.)
      print('Name: $name');
      print('Email: $email');
      print('Phone: $phone');
      print('Gender: $gender');
      print('Date of Birth: $dob');
      print('Age: $age');
      print('Profile Image: ${profileImage?.path ?? 'No image selected'}');
      print('Password: $password');

      // Show success message or submit data
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Form Submitted Successfully")));
    }
  }

  @override
  Widget build(BuildContext context) {
    Color? backGroundColour = Colors.lightBlue[50];

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
                    // Theme switcher
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

                    // Profile Image
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
                            )),
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

                    // Name
                    TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid name';
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

                    // Email
                    TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter valid Email';
                          }
                          String pattern = r'^[^@]+@[^@]+\.[^@]+';
                          RegExp regex = RegExp(pattern);
                          if (!regex.hasMatch(value)) {
                            return 'Please enter a valid email address';
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

                    // Phone Number
                    TextFormField(
                        controller: phoneController,
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

                    const SizedBox(height: 10),

                    // Password
                    TextFormField(
                        controller: passwordController,
                        validator: passwordValidator,
                        obscureText: true,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.password),
                          labelText: 'Password',
                          labelStyle:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                        )),

                    const SizedBox(height: 10),

                    // Confirm Password
                    TextFormField(
                        controller: confirmPasswordController,
                        validator: confirmPasswordValidator,
                        obscureText: true,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.password),
                          labelText: 'Confirm Password',
                          labelStyle:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                        )),

                    const SizedBox(height: 10),

                    // Gender
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

                    // Date of Birth
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
                        'Please select your date of birth.',
                        style: TextStyle(color: Colors.red),
                      ),

                    // Age Slider
                    const AutoSizeText(
                      "Select your age:",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Slider(
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

                    Container(
                      margin: const EdgeInsets.only(right: 18),
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (selectedAge == 0)
                            const Padding(
                              padding: EdgeInsets.only(right: 8),
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

                    // Terms and Conditions Checkbox
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

                    // Submit Button
                    Container(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_forward,
                            size: 40,
                          ),
                          onPressed: _submitForm,
                        )),
                  ],
                ),
              )),
        ));
  }
}
