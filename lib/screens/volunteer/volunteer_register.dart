import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eldersphere/screens/user/Registration_page.dart';
import 'package:eldersphere/common/login_page.dart';
import 'package:eldersphere/constants/constants1.dart';
import 'package:eldersphere/constants/textstyle.dart';
import 'package:eldersphere/screens/user/Otp_page.dart';
import 'package:eldersphere/screens/volunteer/volunteerOtp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VolunteerRegisterPage extends StatefulWidget {
  const VolunteerRegisterPage({Key? key}) : super(key: key);

  @override
  State<VolunteerRegisterPage> createState() => _VolunteerRegisterPageState();
}

class _VolunteerRegisterPageState extends State<VolunteerRegisterPage> {
  final _formkey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _firstNameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _emailcontroller.dispose();
    _firstNameController.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/img/loginpage.png"), fit: BoxFit.cover),
        ),
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: SafeArea(
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      logoPath,
                      scale: 3,
                    ),
                    Text(
                      appTitle,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: TextFormField(
                        controller: _firstNameController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                          hintText: "Enter your name",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter your name";
                          } else if (value.length < 4) {
                            return "your username is too short";
                          }
                          return null;
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.phone),
                          border: OutlineInputBorder(),
                          hintText: "Enter your phone.",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Field is mandatory.";
                          }
                          else if(value.length < 10||value.length > 10)
                          {
                            return "Enter a valid phone number";
                          }
                          return null;
                        },
                      ),
                    ),



                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: TextFormField(
                        controller: _emailcontroller,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                          hintText: "Enter your Email.",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your Email address.";
                          } else if (!value.contains("@") ||
                              !value.contains(".")) {
                            return "Please enter a valid Email address.";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        obscuringCharacter: "*",
                        decoration: const InputDecoration(
                          icon: Icon(Icons.lock),
                          border: OutlineInputBorder(),
                          hintText: "Enter your password.",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your password";
                          } else if (value.length < 8) {
                            return "Length of password must greater than eight";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: TextFormField(
                        obscureText: true,
                        obscuringCharacter: "*",
                        decoration: const InputDecoration(
                          icon: Icon(Icons.lock),
                          border: OutlineInputBorder(),
                          hintText: "Reenter your password.",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please reenter your password";
                          } else if (value.length < 8) {
                            return "Length of password must greater than eight";
                          } else if (value != _passwordController.text) {
                            return "Password missmatch";
                          }
                          return null;
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          registerVolunteer(context);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        height: 45,
                        child: Center(
                          child: Text(
                            "Register",
                            style: btntextStyle,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text("Register as "),
                        TextButton(
                          onPressed: () {

                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()),
                                      (route) => false);

                          },
                          child: Text(
                            "User",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                                (route) => false);
                      },
                      child: Text(
                        "Im already a member.",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }



  // login user

  void registerVolunteer(BuildContext context) {



    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: _emailcontroller.text.trim(),
        password: _passwordController.text)
        .then((value) {
      FirebaseFirestore.instance
          .collection('login')
          .doc(value.user!.uid)
          .set({
        "email": value.user!.email,
        "password": _passwordController.text,
        'uid': value.user!.uid,
        'usertype': "volunteer",
        'phone':_phoneController.text,
        'name':_firstNameController.text,
        'createdat': DateTime.now(),
        'status': 1
      });
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text("Success")));

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginPage()));
    });
  }
}
