import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../constants/constants1.dart';
class CommunityCreate extends StatefulWidget {
  const CommunityCreate({super.key});

  @override
  State<CommunityCreate> createState() => _CommunityCreateState();
}
class _CommunityCreateState extends State<CommunityCreate> {
  final _key=GlobalKey<FormState>();
  TextEditingController _eventcontroller = TextEditingController();
  TextEditingController _titlecontroller=TextEditingController();
  TextEditingController _eventdescriptioncontroller = TextEditingController();
  TextEditingController _venuecontroller=TextEditingController();
  TextEditingController _datetimecontroller = TextEditingController();
  TextEditingController _namecontroller=TextEditingController();
  TextEditingController _contactnocontroller=TextEditingController();
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
            key: _key,
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
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _eventcontroller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter id of Event",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field is mandatory.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _titlecontroller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Event Title",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field is mandatory.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _eventdescriptioncontroller,
                    validator: (value){


                      if(value!.isEmpty){

                        return "Description is mandatory";
                      }
                    },
                    maxLines: 4,
                    decoration: InputDecoration(
                        hintText: "Event discription",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        )),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _venuecontroller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Venue",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field is mandatory.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _datetimecontroller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Date and time",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field is mandatory.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _namecontroller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Organiser name",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field is mandatory.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _contactnocontroller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Contact Number",
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
                  SizedBox(height: 10,),
                  ElevatedButton(onPressed: (){

                    if(_key.currentState!.validate()){
                      String id=Uuid().v1();
                      Map<String,dynamic> data={
                        'id':id,
                        "eventid":_eventcontroller.text,
                        "title":_titlecontroller.text,
                        "description":_eventdescriptioncontroller.text,
                        "venue":_venuecontroller.text,
                        "date and time":_datetimecontroller.text,
                        "organiser name":_namecontroller.text,
                        "contact number":_contactnocontroller.text,
                        "status":1,
                        'createdat':DateTime.now()

                      };

                      FirebaseFirestore.instance.collection('events').doc(id).set(data).then((value) {


                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: AppColors.contColor6,
                            content: Text("Event Added")));
                        Navigator.pop(context);
                      });

                      print(data);

                      Navigator.pop(context);


                    }

                  }, child: Text("Submit"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
