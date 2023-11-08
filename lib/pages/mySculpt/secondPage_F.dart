import 'package:flutter/material.dart';
import 'package:the_metabolix_app/pages/screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Import this for File class
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/home": (context) => Home(), // Adding the route named "/home"
      },
      home: TrackForm(),
    );
  }
}

class TrackForm extends StatefulWidget {
  @override
  _TrackFormState createState() => _TrackFormState();
}

class _TrackFormState extends State<TrackForm> with SingleTickerProviderStateMixin {

  List<Map<String, dynamic>> selectedImages = [
  ]; // Image List with Name to Uplaod in Firebase Storage
  List<String> uploadedImageUrls = [];

  final List<TextEditingController> controllers = List.generate(
    15,
        (index) => TextEditingController(),
  );

  final List<int> numberValues = List.generate(15, (index) => 0);

  bool _isScrolled = false;
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _fadeIn = Tween<double>(begin: 0.0, end: 1.5).animate(_controller);

    // Start the fade-in animation when the page loads
    _controller.forward();

    // Show the pop-up box after 10 seconds
    Future.delayed(Duration(seconds: 1), () {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              backgroundColor: Colors.red,
              title: Text(
                "Your metrics will help shape your fitness journey.",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
              content: Text(
                "Make sure you submit accurate measurements. Cross-check all data you input before hitting the tick button.",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
              actions: [
                Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    for (final controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _storeFormDataInFirebase() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      String userId = user.uid;

      //Storing all the selected images and getting url
      for (Map<String, dynamic> imageInfo in selectedImages) {
        String imageUrl = await _uploadToFirebase(
            imageInfo['imagePath'], imageInfo['imageName'], userId);
        setState(() {
          uploadedImageUrls.add(imageUrl);
        });
      }


      // Get the current date
      final DateTime currentDate = DateTime.now();
      final String formattedDate =
          "${currentDate.year}-${currentDate.month.toString().padLeft(
          2, '0')}-${currentDate.day.toString().padLeft(2, '0')}";

      // Reference to the "user_metrics" collection
      CollectionReference metricsCollection =
      FirebaseFirestore.instance.collection('user_metrics');

      // Check if the document with the current date already exists
      DocumentReference documentRef = metricsCollection.doc(userId);
      DocumentSnapshot documentSnapshot = await documentRef.get();

      if (documentSnapshot.exists) {
        // The document with the current date already exists
        Map<String, dynamic> data =
        documentSnapshot.data() as Map<String, dynamic>;

        if (data.containsKey(formattedDate)) {
          // Client is attempting to update data for the current day
          showerror(context, "You have already submitted data for today.");
        } else {
          // Update data for the current day
          data[formattedDate] = {
            'body_weight': controllers[0].text,
            'waist_at_belly_button': controllers[1].text,
            'hips_at_largest_circumference': controllers[2].text,
            'thigh_at_largest_circumference': controllers[3].text,
            'chest_at_largest_circumference': controllers[4].text,
            'upper_arm_at_largest_circumference': controllers[5].text,
            'face': controllers[6].text,
            'calf': controllers[7].text,
            'neck': controllers[8].text,
            'waist_5_fingers_above_belly_button': controllers[9].text,
            'last_periods_date': controllers[10].text,
            "Submit Front Picture:": uploadedImageUrls.length > 0
                ? uploadedImageUrls[0]
                : 'none',
            "Submit Back Picture:": uploadedImageUrls.length > 1
                ? uploadedImageUrls[1]
                : 'none',
            "Submit Side Picture:": uploadedImageUrls.length > 2
                ? uploadedImageUrls[2]
                : 'none',
            "Submit Full Picture: (casual wear)": uploadedImageUrls.length > 3
                ? uploadedImageUrls[3]
                : 'none',
            // Add other fields here
          };

          try {
            // Update the document with the modified data
            await documentRef.set(data);
            Navigator.pushNamed(context, "/mySculptLR");
          } catch (e) {
            showerror(context, e.toString());
          }
        }
      } else {
        // The document with the current date doesn't exist, create it
        Map<String, dynamic> formData = {
          formattedDate: {
            'body_weight': controllers[0].text,
            'waist_at_belly_button': controllers[1].text,
            'hips_at_largest_circumference': controllers[2].text,
            'thigh_at_largest_circumference': controllers[3].text,
            'chest_at_largest_circumference': controllers[4].text,
            'upper_arm_at_largest_circumference': controllers[5].text,
            'face': controllers[6].text,
            'calf': controllers[7].text,
            'neck': controllers[8].text,
            'waist_5_fingers_above_belly_button': controllers[9].text,
            'last_periods_date': controllers[10].text,
            "Submit Front Picture:": uploadedImageUrls.length > 0
                ? uploadedImageUrls[0]
                : 'none',
            "Submit Back Picture:": uploadedImageUrls.length > 1
                ? uploadedImageUrls[1]
                : 'none',
            "Submit Side Picture:": uploadedImageUrls.length > 2
                ? uploadedImageUrls[2]
                : 'none',
            "Submit Full Picture: (casual wear)": uploadedImageUrls.length > 3
                ? uploadedImageUrls[3]
                : 'none',
            // Add other fields here
          }
        };

        try {
          await metricsCollection.doc(userId).set(formData);
          Navigator.pushNamed(context, "/mySculptLR");
        } catch (e) {
          showerror(context, e.toString());
        }
      }
    }
  }

  // Image upload to Firebase Storage
  Future<String> _uploadToFirebase(String imagePath, String imageName, String uid) async {
    DateTime currentDate = DateTime.now();
    String date =
        "${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}";
    try {
      final firebaseStorageRef =
      firebase_storage.FirebaseStorage.instance.ref(uid).child(date).child(imageName + '.jpg');
      final uploadTask = firebaseStorageRef.putFile(File(imagePath));
      await uploadTask;
      // Get download URL
      String imageUrl = await firebaseStorageRef.getDownloadURL();
      return imageUrl;
    } catch(e){
      showerror(context, e.toString());
      return "NULL" ;
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        appBar: AppBar(
          title: Text('3D ListWheelScrollView'),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/mysculpttracker.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4),
                  BlendMode.srcOver,
                ),
              ),
            ),
          ),
          Positioned(
            top: 5.0,
            left: 20.0,
            right: 20.0,
            child: FadeTransition(
              opacity: _fadeIn,
              child: Container(
                height: 105.0,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.5),
                      blurRadius: 8.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Text(
                    "Kindly input metrics in fields below. Please make sure you take measurements in the way depicted only. Scroll upwards for each field.",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 220.0, // Adjust the value here to position the SizedBox
            left: 0,
            right: 0,
            child: SizedBox(
              height: 80.0, // Added SizedBox with height 10.0
            ),
          ),
          ListWheelScrollView(
            itemExtent: 250.0,
            diameterRatio: 1.0,
            offAxisFraction: -0.1,
            physics: FixedExtentScrollPhysics(),
            children: List.generate(
              15,
                  (index) => _buildScrollableBox(index),
            ),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: FadeTransition(
              opacity: _fadeIn,
              child: FloatingActionButton(
                onPressed: () {
                  if(check_empty()){
                    _storeFormDataInFirebase();
                    Navigator.pushNamed(context, "/mySculptLR"); // Add your submit button onPressed logic here
                  }
                  else {
                    showerror(context, "Please Fill all the Details.");
                  }
                },
                child: Icon(Icons.check),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableBox(int index) {
    List<String> headings = [
      "Body Weight:",
      "Waist (at belly button):",
      "Hips at largest circumference:",
      "Thigh at largest circumference:",
      "Chest at largest circumference:",
      "Upper Arm at largest circumference:",
      "Face:",
      "Calf:",
      "Neck:",
      "Waist (5 fingers above belly button):",
      "Last Periods Date:",
      "Submit Front Picture:",
      "Submit Back Picture:",
      "Submit Side Picture:",
      "Submit Full Picture: (casual wear)",
    ];

    return Container(
      height: 350.0,
      decoration: BoxDecoration(
        color: Colors.indigo, // Changed back to indigoAccent color for all circles
        borderRadius: BorderRadius.circular(1000.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 5.0,
            spreadRadius: 3.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildHeading(headings[index]),
          if (index == 10) // Show date picker only for the "Last Periods Date" heading
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showDatePicker(context, index);
                  },
                  child: Container(
                    width: 180,
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(
                      "Select Date",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow, // Set the button color to yellow
                    onPrimary: Colors.black, // Set the text color to black
                  ),
                ),
                SizedBox(height: 20), // Adding a SizedBox for spacing
                TextFormField(
                  controller: controllers[index],
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 28.0, // Increased font size to 28
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  enabled: false, // Disabling editing of the field
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                    hintText: 'Select date above', // Placeholder text
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                      fontSize: 22,
                    ),
                  ),
                ),
              ],
            )
          else if (index >= 11 && index <= 14) // Show upload button for specified headings
            ElevatedButton(
              onPressed: () {
                _showUploadOptions(context, index);
              },
              child: Container(
                width: 180,
                height: 40,
                alignment: Alignment.center,
                child: Text(
                  "Upload Image",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow, // Set the button color to yellow
                onPrimary: Colors.black, // Set the text color to black
              ),
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (numberValues[index] > 0) {
                        numberValues[index]--;
                        controllers[index].text = numberValues[index].toString();
                      }
                    });
                  },
                  icon: Icon(Icons.remove, color: Colors.pinkAccent),
                  iconSize: 65,
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      width: 180.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: TextFormField(
                          controller: controllers[index],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28.0, // Increased font size to 28
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              numberValues[index] = int.tryParse(value) ?? 0;
                            });
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(8.0),
                            hintText: 'Enter number',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      numberValues[index]++;
                      controllers[index].text = numberValues[index].toString();
                    });
                  },
                  icon: Icon(Icons.add, color: Colors.greenAccent),
                  iconSize: 65,
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildHeading(String heading) {
    return Container(
      width: 200,
      child: Text(
        heading,
        style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold), // Increased font size to 28
        textAlign: TextAlign.center,
        maxLines: 2,
      ),
    );
  }

  void _showDatePicker(BuildContext context, int index) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        controllers[index].text = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
    }
  }

  void _showUploadOptions(BuildContext context, int index)  {

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text("Phone Camera"),
                  onTap: ()  async {
                    final image = await ImagePicker().pickImage(source: ImageSource.camera);
                    if (image != null) {
                      String imagePath = image.path;
                      String imageName = generateImageName(index);
                      setState(() {
                        selectedImages.add({'imagePath': imagePath, 'imageName': imageName});
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("You have Selected $imageName"),
                          ),
                        );
                      });
                    }
                    Navigator.pop(context);

                  }
              ),
              ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text("Phone Gallery"),
                  onTap: () async {
                    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      String imagePath = image.path;
                      String imageName = generateImageName(index);
                      setState(() {
                        selectedImages.add({'imagePath': imagePath, 'imageName': imageName});
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("You have Selected $imageName"),
                          ),
                        );
                      });
                    }
                    Navigator.pop(context);
                  }

              ),
            ],
          ),
        );
      },
    );
  }

  // Getting Name of Image by Index
  String generateImageName(int index) {
    String baseName = '';
    if (index == 11) {
      baseName = 'Front_Image';
    } else if (index == 12) {
      baseName = 'Back_Image';
    } else if (index == 13) {
      baseName = 'Side_Image';
    } else if (index == 14) {
      baseName = 'Full_Image';
    }
    return baseName;
  }

  // Check for any empty values
  bool check_empty() {
    if (selectedImages.length != 4) {
      return false;
    }
    return true;
  }
}

// Show error
void showerror(BuildContext context, String Msg) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Error'),
      content: Text(Msg),
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




class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;

  const MainAppBar({
    Key? key,
    required this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pushNamed(context, "/mySculptFP"); // Navigating to the route named "/home"
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          size: 16,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                'assets/images/login.png',
                height: appBar.preferredSize.height - 8,
                width: appBar.preferredSize.height - 0,
                fit: BoxFit.contain,
              ),
            ),
            const Text(
              'mySculpt',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
          ],
        ),
      ),
      centerTitle: true,
      actions: [
        TextButton(
          onPressed: () {},
          child: const Icon(
            Icons.notifications,
            size: 16,
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(5),
            maximumSize: const Size(30, 30),
            minimumSize: const Size(30, 30),
            shape: const CircleBorder(),
            primary: const Color(0xffffe6da),
            onPrimary: const Color(0xfffa7a3b),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
