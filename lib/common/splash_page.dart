import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eldersphere/common/error_page.dart';
import 'package:eldersphere/common/login_page.dart';
import 'package:eldersphere/screens/admin/admin_home.dart';
import 'package:eldersphere/screens/user/user_home_page.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:svg_flutter/svg.dart';


import '../constants/constants1.dart';

class Splashpage extends StatefulWidget {
  const Splashpage({super.key});

  State<Splashpage> createState() => _SplashpageState();
}

class _SplashpageState extends State<Splashpage> {
  final String assetName = 'assets/svg/logo.svg';

  String? _type;
  String? uid;
  String? name;
  String? email;
  String? phone;

  Map<String, dynamic> data = {};

  getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _type = await _pref.getString('type');
    email = await _pref.getString('email');
    name = await _pref.getString('name');
    phone = await _pref.getString('phone');
    uid = await _pref.getString('uid');

    setState(() {
      data = {
        'uid': uid,
        'name': name,
        'email': email,
        'type': _type,
        'phone': phone
      };
    });
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    final token = _pref.getString('token');

    if (token == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      if (_type == "admin") {
        DocumentSnapshot snap = await FirebaseFirestore.instance
            .collection('login')
            .doc(uid)
            .get();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AdminHome(
              data: snap,
            )),
                (route) => false);
      } else if (_type == "user") {

        DocumentSnapshot snap = await FirebaseFirestore.instance
            .collection('login')
            .doc(uid)
            .get();

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage(

              data: snap,

            )),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => ErrorPage(errorMessage: "Contact Administrator")),
                (route) => false);
      }
    }
  }

  @override
  void initState() {
    getData();
    // Future.delayed(
    //   Duration(seconds: 3),
    //     ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()))
    // );
    var d = Duration(seconds: 5);
    Future.delayed(d, () {
      _checkLoginStatus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
          ],
        ),
      ),
    );
  }
}
