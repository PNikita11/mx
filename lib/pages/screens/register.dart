import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int _currentStep = 0;

  void onStepContinue() {
    if (_currentStep < 5) {
      setState(() {
        _currentStep = _currentStep + 1;
      });
    }
    else if(_currentStep==5){
      _registerUser();
    }
  }

  void onStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep = _currentStep - 1;
      });
    }
  }

  void onStepTapped(int step) {
    setState(() {
      _currentStep = step;
    });
  }

  StepState _getStepState(int stepIndex) {
    if (_currentStep == stepIndex) {
      return StepState.editing;
    } else if (_currentStep > stepIndex) {
      return StepState.complete;
    } else {
      return StepState.indexed;
    }
  }

  Widget controlsBuilder(BuildContext context,
      {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (_currentStep > 0)
          ElevatedButton(
            onPressed: onStepCancel,
            child: Text('PREVIOUS'),
          ),
        SizedBox(width: 20),
        if (_currentStep < 5)
          ElevatedButton(
            onPressed: onStepContinue,
            child: Text('NEXT'),
          ),
        if (_currentStep == 5) SizedBox(width: 20),
        ElevatedButton(
          onPressed: _currentStep == 5 ? _registerUser : null,
          child: Text(_currentStep == 5 ? 'REGISTER' : 'FINISH'),
        ),
      ],
    );
  }

  String _firstName = '';
  String _lastName = '';
  String _gender = '';
  DateTime? _birthdate;
  String _medicalCondition = '';
  bool _hasInjuries = false;
  double _height = 0.0;
  double _weight = 0.0;
  double _waist = 0.0;
  double _hip = 0.0;
  double _upperArm = 0.0;
  double _upperThigh = 0.0;
  String _activityLevel = '';
  String _foodPreference = '';
  bool _hasAllergies = false;
  String _username = '';
  String _password = '';
  String _email = '';
  String _mobileNumber = '';
  bool _isHomeFit = false;
  bool _isFullFit = false;
  bool _isEatFit = false;
  bool _isFreeUser = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Color customStepperColor = Colors.black;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25.0),
          ),
        ),
        titleSpacing: 0,
        toolbarHeight: 70,
        title: Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 35.0),
                child: Image.asset(
                  'assets/images/meta logo (1).png',
                  height: 50,
                  width: 200,
                  alignment: AlignmentDirectional.centerStart,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                child: Theme(
                  data: ThemeData(
                    colorScheme: ColorScheme.light(
                      primary: customStepperColor,
                      onPrimary: Colors.white,
                    ),
                    textTheme: TextTheme(
                      headline6: TextStyle(
                        color: customStepperColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Stepper(
                      physics: ClampingScrollPhysics(),
                      type: StepperType.horizontal,
                      currentStep: _currentStep,
                      onStepContinue: onStepContinue,
                      onStepCancel: onStepCancel,
                      onStepTapped: onStepTapped,
                      steps: [
                        Step(
                          title: Text(''),
                          isActive: _currentStep == 0,
                          state: _getStepState(0),
                          content: Column(
                            children: [
                              Container(
                                decoration: _boxDecoration,
                                padding: EdgeInsets.all(16),
                                child: _buildStepContent(0),
                              ),
                            ],
                          ),
                        ),
                        Step(
                          title: Text(''),
                          isActive: _currentStep == 1,
                          state: _getStepState(1),
                          content: Column(
                            children: [
                              Container(
                                decoration: _boxDecoration,
                                padding: EdgeInsets.all(16),
                                child: _buildStepContent(1),
                              ),
                            ],
                          ),
                        ),
                        Step(
                          title: Text(''),
                          isActive: _currentStep == 2,
                          state: _getStepState(2),
                          content: Column(
                            children: [
                              Container(
                                decoration: _boxDecoration,
                                padding: EdgeInsets.all(16),
                                child: _buildStepContent(2),
                              ),
                            ],
                          ),
                        ),
                        Step(
                          title: Text(''),
                          isActive: _currentStep == 3,
                          state: _getStepState(3),
                          content: Column(
                            children: [
                              Container(
                                decoration: _boxDecoration,
                                padding: EdgeInsets.all(16),
                                child: _buildStepContent(3),
                              ),
                            ],
                          ),
                        ),
                        Step(
                          title: Text(''),
                          isActive: _currentStep == 4,
                          state: _getStepState(4),
                          content: Column(
                            children: [
                              Container(
                                decoration: _boxDecoration,
                                padding: EdgeInsets.all(16),
                                child: _buildStepContent(4),
                              ),
                            ],
                          ),
                        ),
                        Step(
                          title: Text(''),
                          isActive: _currentStep == 5,
                          state: _getStepState(5),
                          content: Column(
                            children: [
                              Container(
                                decoration: _boxDecoration,
                                padding: EdgeInsets.all(16),
                                child: _buildStepContent(5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Step buildStepWithTitle(String title, Widget content) {
    return Step(
      title: Text(title),
      isActive: _currentStep == int.parse(title.substring(5)) - 1,
      state: _getStepState(int.parse(title.substring(5)) - 1),
      content: Column(
        children: [
          Container(
            decoration: _boxDecoration,
            padding: EdgeInsets.all(16),
            child: content,
          ),
        ],
      ),
    );
  }

  BoxDecoration get _boxDecoration {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _birthdate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _birthdate) {
      setState(() {
        _birthdate = picked;
      });
    }
  }

  Widget _buildStepContent(int stepIndex) {
    switch (stepIndex) {
      case 0:
        return Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your First Name';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _firstName = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'First Name',
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Last Name';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _lastName = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Last Name',
              ),
            ),
            SizedBox(
              height: 20,
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gender',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Male',
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = value ?? '';
                        });
                      },
                    ),
                    Text('Male'),
                    SizedBox(width: 20.0),
                    Radio<String>(
                      value: 'Female',
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = value ?? '';
                        });
                      },
                    ),
                    Text('Female'),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add Birthday',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showDatePicker(context);
                  },
                  child: Text('Select Birthdate'),
                ),
              ],
            ),

            if (_birthdate != null)
              Text('Selected Birthdate: ${_birthdate!.toLocal()}'),
          ],
        );
      case 1:
        return Column(
          children: [
            RadioListTile<String>(
              title: Text('PCOD'),
              value: 'PCOD',
              groupValue: _medicalCondition,
              onChanged: (value) {
                setState(() {
                  _medicalCondition = value ?? '';
                });
              },
            ),
            RadioListTile<String>(
              title: Text('Diabetes'),
              value: 'Diabetes',
              groupValue: _medicalCondition,
              onChanged: (value) {
                setState(() {
                  _medicalCondition = value ?? '';
                });
              },
            ),
            RadioListTile<String>(
              title: Text('None'),
              value: 'None',
              groupValue: _medicalCondition,
              onChanged: (value) {
                setState(() {
                  _medicalCondition = value ?? '';
                });
              },
            ),
            RadioListTile<String>(
              title: Text('Any other:'),
              value: 'Other',
              groupValue: _medicalCondition,
              onChanged: (value) {
                setState(() {
                  _medicalCondition = value ?? '';
                });
              },
            ),
            if (_medicalCondition == 'Other')
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    // Use this value if needed
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Specify Other Medical Condition',
                ),
              ),
            CheckboxListTile(
              title: Text('Has Injuries?'),
              value: _hasInjuries,
              onChanged: (value) {
                setState(() {
                  _hasInjuries = value ?? false;
                });
              },
            ),
          ],
        );
      case 2:
        return Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              validator: (value) {
                // Add validation as per your requirements
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _height = double.tryParse(value) ?? 0.0;
                });
              },
              decoration: InputDecoration(
                labelText: 'Height',
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              validator: (value) {
                // Add validation as per your requirements
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _weight = double.tryParse(value) ?? 0.0;
                });
              },
              decoration: InputDecoration(
                labelText: 'Weight',
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              validator: (value) {
                // Add validation as per your requirements
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _waist = double.tryParse(value) ?? 0.0;
                });
              },
              decoration: InputDecoration(
                labelText: 'Waist (in/cm)',
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              validator: (value) {
                // Add validation as per your requirements
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _hip = double.tryParse(value) ?? 0.0;
                });
              },
              decoration: InputDecoration(
                labelText: 'Hip (in/cm)',
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              validator: (value) {
                // Add validation as per your requirements
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _upperArm = double.tryParse(value) ?? 0.0;
                });
              },
              decoration: InputDecoration(
                labelText: 'Upper Arm',
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              validator: (value) {
                // Add validation as per your requirements
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _upperThigh = double.tryParse(value) ?? 0.0;
                });
              },
              decoration: InputDecoration(
                labelText: 'Upper Thigh',
              ),
            ),
          ],
        );
      case 3:
        return Column(
          children: [
            RadioListTile<String>(
              title: Text('Sedentary'),
              value: 'Sedentary',
              groupValue: _activityLevel,
              onChanged: (value) {
                setState(() {
                  _activityLevel = value ?? '';
                });
              },
            ),
            // Add other activity levels as RadioListTile
            // ...
            CheckboxListTile(
              title: Text('Veg, Non Veg, Pescetarian?'),
              value: _foodPreference.isNotEmpty,
              onChanged: (value) {
                setState(() {
                  _foodPreference = value ?? false ? 'Veg' : '';
                });
              },
            ),
            CheckboxListTile(
              title: Text('Has Allergies?'),
              value: _hasAllergies,
              onChanged: (value) {
                setState(() {
                  _hasAllergies = value ?? false;
                });
              },
            ),
          ],
        );
      case 4:
        return Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Username';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _username = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextFormField(
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Password';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Email ID';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Email ID',
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Mobile Number';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _mobileNumber = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Mobile Number',
              ),
            ),
          ],
        );
      case 5:
        return Column(
          children: [
            CheckboxListTile(
              title: Text('HomeFit'),
              value: _isHomeFit,
              onChanged: (value) {
                setState(() {
                  _isHomeFit = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('FullFit'),
              value: _isFullFit,
              onChanged: (value) {
                setState(() {
                  _isFullFit = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Eatfit'),
              value: _isEatFit,
              onChanged: (value) {
                setState(() {
                  _isEatFit = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Free User'),
              value: _isFreeUser,
              onChanged: (value) {
                setState(() {
                  _isFreeUser = value ?? false;
                });
              },
            ),
          ],
        );
      default:
        return Container();
    }
  }

  void _registerUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Creating User
        UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.trim(),
          password: _password.trim(),
        );
        if (userCredential.user != null) {
          print("User registration successful for user: ${userCredential.user!.email}");
          // Here you can call the function to store user data using the UID
          await storeUserData(userCredential.user!.uid);
          // Show a success dialog or navigate to the next screen
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Success'),
              content: Text('User registered successfully.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigate to the next screen or perform other actions
                    Navigator.pushReplacementNamed(context, '/login'); // Navigate to the login screen
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: Text('Error'),
                content: Text(e.message!),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
        );
      }
    }
  }

  // Data Storing of Registration Form
  Future<void> storeUserData(String uid) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        //Setting user Display Name
        try {
          await user.updateDisplayName(_username);
        } catch (error) {
          showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: Text('Error'),
                  content: Text(error.toString()),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('OK'),
                    ),
                  ],
                ),
          );
        } // End DisplayName Code


        CollectionReference usersRef = FirebaseFirestore.instance.collection('RegisteredUsers');

        String formattedBirthdate = _birthdate != null ? DateFormat('dd-MM-yyyy').format(_birthdate!)  : 'birthday';

        await usersRef.doc(uid).set({
          'user_detail': {
            'name': "${_lastName.trim()} ${_firstName.trim()}",
            'gender': _gender,
            'username': _username.trim(),
            'email': _email.trim(),
            'phone': _mobileNumber.trim(),
            'birthday': formattedBirthdate,
          },
          'user_health_info': {
            'medical_condition': _medicalCondition,
            'has_injuries': _hasInjuries,
          },
          'user_physical_stats': {
            'height': _height,
            'weight': _weight,
            'waist': _waist,
            'hip': _hip,
            'upper_arm': _upperArm,
            'upper_thigh': _upperThigh,
          },
          'user_preferences': {
            'activity_level': _activityLevel,
            'food_preference': _foodPreference,
            'has_allergies': _hasAllergies,
          },
          'fitness_plan': {
            'is_home_fit': _isHomeFit,
            'is_full_fit': _isFullFit,
            'is_eat_fit': _isEatFit,
            'is_free_user': _isFreeUser,
          },
        });
        print("User data stored successfully");
      } else {
        print("User is null");
      }
    } catch (error) {
      print("Error storing user data: $error");
    }
  }
}

