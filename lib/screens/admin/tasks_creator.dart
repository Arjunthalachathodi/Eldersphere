import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../constants/constants1.dart';

class TasksCreater extends StatefulWidget {
  const TasksCreater({super.key});

  @override
  State<TasksCreater> createState() => _TasksCreaterState();
}

final _key = GlobalKey<FormState>();
TextEditingController _idcontroller = TextEditingController();
TextEditingController _descriptioncontroller = TextEditingController();

class _TasksCreaterState extends State<TasksCreater> {
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
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _idcontroller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter title of task",
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
                  controller: _descriptioncontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Description is mandatory";
                    }
                  },
                  maxLines: 5,
                  decoration: InputDecoration(
                      hintText: "Enter the discription about task",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        var id = Uuid().v1();
                        Map<String,dynamic> data = {
                          'id': id,
                          "taskname": _idcontroller.text,
                          "description": _descriptioncontroller.text,
                          "status": 1,
                        };
                        FirebaseFirestore.instance.collection('tasks').doc(id).set(data).then((value) {


                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: AppColors.contColor6,
                              content: Text("Task Added")));
                          Navigator.pop(context);
                        });

                        print(data);

                        Navigator.pop(context);
                      }
                    },
                    child: Text("Submit"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
