import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eldersphere/constants/constants1.dart';
import 'package:eldersphere/constants/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ShopRegister extends StatefulWidget {
  const ShopRegister({super.key});

  @override
  State<ShopRegister> createState() => _ShopRegisterState();
}





class _ShopRegisterState extends State<ShopRegister> {

  final _formkey = GlobalKey<FormState>();
  TextEditingController _shopnamecontroller = TextEditingController();
  TextEditingController _locationcontroller = TextEditingController();
  TextEditingController _shoptypecontroller = TextEditingController();
  TextEditingController _numbercontroller = TextEditingController();


  @override
  void dispose() {
    _shopnamecontroller.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Color(0XFF68CAF0),
    title: const Text(
    "ElderSphere",
    style: TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
    ),
    ),
      ),
        body: SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  logoPath,
                  scale: 2,
                ),
                TextFormField(
                  controller: _shopnamecontroller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your shop name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Field is mandatory.";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _locationcontroller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Attach location",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Field is mandatory.";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _shoptypecontroller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Shop type",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Field is mandatory.";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _numbercontroller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Phone number",
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
                SizedBox(
                  height: 10,
                ),
                GestureDetector(onTap: (){
                  if(_formkey.currentState!.validate()){

                    String id=Uuid().v1();

                    Map<String,dynamic> data={
                    'id':id,
                    "shopname":_shopnamecontroller.text,
                    "location":_locationcontroller.text,
                  "shoptype":_shoptypecontroller.text,
                  "number":_numbercontroller.text,
                      'status':1,
                      'createdat':DateTime.now()

                    };

                    FirebaseFirestore.instance.collection('shops').doc(id).set(data).then((value) {


                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: AppColors.contColor6,
                          content: Text("Shop Added")));
                      Navigator.pop(context);
                    });

                    print(data);




                  }

                },
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(color: Colors.blue,
                      borderRadius: BorderRadius.circular(5),),
                    height: 45,
                    child: Center(
                      child: Text(
                        "Register",
                        style: btntextStyle,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
