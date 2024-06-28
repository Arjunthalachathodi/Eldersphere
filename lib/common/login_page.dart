import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eldersphere/constants/constants1.dart';
import 'package:eldersphere/constants/formdecoration.dart';
import 'package:eldersphere/constants/textstyle.dart';
import 'package:eldersphere/screens/admin/admin_home.dart';
import 'package:eldersphere/screens/user/user_home_page.dart';
import 'package:eldersphere/screens/user/Registration_page.dart';
import 'package:eldersphere/screens/volunteer/volunteer_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isPasswordHidden =
      true; // Added boolean variable to handle password visibility
  final _loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/img/loginpage.png"), fit: BoxFit.cover),
          ),
          padding: EdgeInsets.all(20),
          height: double.infinity,
          width: double.infinity,
          child: Form(
            key: _loginKey,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        logoPath,
                        width: 100,
                      ),
                      Text(
                        appTitle,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your Email address.";
                          } else if (!value.contains("@") || !value.contains(".")) {
                            return "Please enter a valid Email address.";
                          }
                          return null;
                        },
                        controller: _emailController,
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          hintText: "Enter your Email",
                          hintStyle: TextStyle(fontSize: 14),
                          enabledBorder: enabledBorder,
                          focusedBorder: focusdBorder,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your password";
                          } else if (value.length < 8) {
                            return "Length of password must greater than 8";
                          }
                          return null;
                        },
                        controller: _passwordController,
                        obscureText: _isPasswordHidden,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          errorStyle: TextStyle(color: Colors.red),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          hintText: "Password",
                          hintStyle: hintStyle,
                          enabledBorder: enabledBorder,
                          focusedBorder: focusdBorder,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isPasswordHidden = !_isPasswordHidden;
                              });
                            },
                            child: Icon(
                              _isPasswordHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_loginKey.currentState!.validate()) {
                            login(context);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(color: Colors.blue),
                          height: 45,
                          child: Center(
                            child: Text(
                              "Login",
                              style: btntextStyle,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          // Implement forgotten password logic here
                        },
                        child: Text(
                          "Forgotten password?",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("OR"),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterPage()),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            color: Colors.white,
                          ),
                          height: 45,
                          child: Center(
                            child: Text(
                              "Create new account",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) async{
    SharedPreferences _pref=await SharedPreferences.getInstance();
    try {
   UserCredential user=await   FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);



   DocumentSnapshot snap = await FirebaseFirestore.instance
       .collection('login')
       .doc(user.user!.uid)
       .get();




      if(snap!=null){

        if (snap['usertype'] == "user") {

          _pref.setString('token', user.user!.getIdToken().toString());
          _pref.setString('name', snap['name']);
          _pref.setString('email', snap['email']);
          _pref.setString('phone', snap['phone']);
          _pref.setString('type', snap['usertype']);
          _pref.setString('uid', snap['uid']);



          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(
                    data: snap,
                  )),
                  (route) => false);
        }else if(snap['usertype']=="admin"){
          _pref.setString('token', user.user!.getIdToken().toString());
          _pref.setString('name', snap['name']);
          _pref.setString('email', snap['email']);
          _pref.setString('phone', snap['phone']);
          _pref.setString('type', snap['usertype']);
          _pref.setString('uid', snap['uid']);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => AdminHome(
                    data: snap,
                  )),
                  (route) => false);
        }
        else if(snap['usertype']=="volunteer"){

          _pref.setString('token', user.user!.getIdToken().toString());
          _pref.setString('name', snap['name']);
          _pref.setString('email', snap['email']);
          _pref.setString('phone', snap['phone']);
          _pref.setString('type', snap['usertype']);
          _pref.setString('uid', snap['uid']);


          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => VolunterHomepage(
                    data:snap ,
                  )),
                  (route) => false);
        }
      }

    } on FirebaseAuthException catch (e) {
      print(e);
    } on FirebaseException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }
}
