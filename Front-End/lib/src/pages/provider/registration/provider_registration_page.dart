import 'package:flutter/material.dart';
import 'package:seyoni/src/constants/constants_color.dart';
import 'package:seyoni/src/widgets/custom_button.dart';
import 'package:seyoni/src/widgets/background_widget.dart';
import 'package:seyoni/src/config/route.dart';
import '../../../constants/constants_font.dart';
import '../../seeker/category/components/categories.dart';
import '../../seeker/category/components/subcategories.dart';
import '../../seeker/sign-pages/components/constants.dart';
import '../components/custom_text_field.dart';
import '../components/short_custom_text.dart';

class ProviderRegistrationPage extends StatefulWidget {
  const ProviderRegistrationPage({super.key});

  @override
  ProviderRegistrationPageState createState() =>
      ProviderRegistrationPageState();
}

class ProviderRegistrationPageState extends State<ProviderRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  int _currentStep = 0;
  String? _selectedCategory;
  List<String> _selectedSubCategories = [];
  String? _selectedSubCategoryValue;

  void _nextStep() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _sendOtp() {
    // Handle sending OTP logic
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      // Handle registration logic
      Navigator.pushNamed(context, AppRoutes.providerHomePage);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kTransparentColor,
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: height * 0.1), // Adjust top spacing
              Image.asset(
                'assets/images/logo-icon.png',
                height: height * 0.15,
                fit: BoxFit.contain,
              ),
              Image.asset(
                'assets/images/logo-name.png',
                height: height * 0.12,
                fit: BoxFit.contain,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      if (_currentStep == 0) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ShortCustomTextField(
                              controller: _firstNameController,
                              labelText: 'First Name',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your first name';
                                }
                                return null;
                              },
                            ),
                            ShortCustomTextField(
                              controller: _lastNameController,
                              labelText: 'Last Name',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your last name';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _emailController,
                          labelText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _phoneController,
                          labelText: 'Phone Number',
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          dropdownColor: Colors.black.withOpacity(0.9),
                          decoration: InputDecoration(
                            labelStyle: kBodyTextStyle,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(
                                  color: kPrimaryColor, width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(
                                  color: kPrimaryColor, width: 1),
                            ),
                            labelText: 'Select Category',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(
                                  color: kPrimaryColor, width: 1),
                            ),
                          ),
                          style: kTextFieldStyle,
                          items: categories.map((category) {
                            return DropdownMenuItem<String>(
                              value: category['name'],
                              child: Text(category['name']!),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value;
                              _selectedSubCategories = [];
                              _selectedSubCategoryValue = null;
                              _formKey.currentState!.validate();
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a category';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          dropdownColor: Colors.black.withOpacity(0.9),
                          decoration: InputDecoration(
                            labelStyle: kBodyTextStyle,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(
                                  color: kPrimaryColor, width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(
                                  color: kPrimaryColor, width: 1),
                            ),
                            labelText: 'Select Sub Categories',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(
                                  color: kPrimaryColor, width: 1),
                            ),
                          ),
                          style: kTextFieldStyle,
                          value:
                              _selectedSubCategoryValue, // Reset the value to null
                          items: _selectedCategory == null
                              ? []
                              : subCategories[_selectedCategory]!
                                  .map((subCategory) {
                                  return DropdownMenuItem<String>(
                                    value: subCategory,
                                    child: Text(subCategory),
                                  );
                                }).toList(),
                          onChanged: (value) {
                            setState(() {
                              if (value != null &&
                                  !_selectedSubCategories.contains(value)) {
                                _selectedSubCategories
                                    .add(value); // Add subcategory
                                _selectedSubCategoryValue = value;
                              }
                            });
                          },
                          validator: (value) {
                            if (_selectedSubCategories.isEmpty) {
                              return 'Please select at least one sub category';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8.0,
                          children: _selectedSubCategories.map((subCategory) {
                            return Chip(
                              backgroundColor: kPrimaryColor,
                              labelStyle: const TextStyle(color: Colors.black),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: const BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              label: Text(subCategory),
                              onDeleted: () {
                                setState(() {
                                  _selectedSubCategories.remove(subCategory);
                                  if (_selectedSubCategories.isEmpty) {
                                    _selectedSubCategoryValue = null;
                                  }
                                });
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PrimaryOutlinedButton(
                              text: "Back",
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            const SizedBox(width: 10),
                            PrimaryFilledButton(
                              text: 'Next',
                              onPressed: _nextStep,
                            ),
                          ],
                        ),
                      ] else if (_currentStep == 1) ...[
                        CustomTextField(
                          controller: _otpController,
                          labelText: 'Enter OTP',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the OTP';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PrimaryOutlinedButton(
                                text: "Back",
                                onPressed: () {
                                  setState(() {
                                    _currentStep--;
                                  });
                                }),
                            const SizedBox(width: 10),
                            PrimaryFilledButton(
                              text: 'Verify OTP',
                              onPressed: _nextStep,
                            ),
                          ],
                        ),
                      ] else if (_currentStep == 2) ...[
                        // Selfie Capture Step
                        const Text(
                          'Capture a Real-time Selfie',
                          style: kSubtitleTextStyle,
                        ),
                        const SizedBox(height: 10),
                        IconButton(
                          icon: const Icon(Icons.camera_alt,
                              size: 50, color: kPrimaryColor),
                          onPressed: () {
                            // Handle selfie capture logic
                            _nextStep();
                          },
                        ),
                        const SizedBox(height: 10),
                        PrimaryOutlinedButton(
                            text: "Back",
                            onPressed: () {
                              setState(() {
                                _currentStep--;
                              });
                            }),
                      ] else if (_currentStep == 3) ...[
                        // NIC/Driving License Capture Step
                        const Text(
                          'Capture NIC/Driving License Front',
                          style: kSubtitleTextStyle,
                        ),
                        const SizedBox(height: 10),
                        IconButton(
                          icon: const Icon(Icons.camera_alt,
                              size: 50, color: kPrimaryColor),
                          onPressed: () {
                            // Handle front image capture logic
                            _nextStep();
                          },
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Capture NIC/Driving License Back',
                          style: kSubtitleTextStyle,
                        ),
                        const SizedBox(height: 10),
                        IconButton(
                          icon: const Icon(Icons.camera_alt,
                              size: 50, color: kPrimaryColor),
                          onPressed: () {
                            // Handle back image capture logic
                            _nextStep();
                          },
                        ),
                        const SizedBox(height: 10),
                        PrimaryOutlinedButton(
                            text: "Back",
                            onPressed: () {
                              setState(() {
                                _currentStep--;
                              });
                            }),
                      ] else if (_currentStep == 4) ...[
                        CustomTextField(
                          controller: _passwordController,
                          labelText: 'New Password',
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _confirmPasswordController,
                          labelText: 'Confirm Password',
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PrimaryOutlinedButton(
                                text: "Back",
                                onPressed: () {
                                  setState(() {
                                    _currentStep--;
                                  });
                                }),
                            const SizedBox(width: 10),
                            PrimaryFilledButton(
                              text: 'Register',
                              onPressed: _register,
                            ),
                          ],
                        ),
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
                            style: TextStyle(
                              color: kParagraphTextColor,
                              fontSize: 14,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.providerSignIn);
                            },
                            child: const Text('Sign In',
                                style: TextStyle(color: kPrimaryColor)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Register as a service seeker',
                            style: TextStyle(
                              color: kParagraphTextColor,
                              fontSize: 14,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.signUp);
                            },
                            child: const Text('Register Now',
                                style: TextStyle(color: kPrimaryColor)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}