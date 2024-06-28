import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
class MedicalSupport extends StatefulWidget {
  final DocumentSnapshot? data;
  const MedicalSupport({super.key,this.data});

  @override
  State<MedicalSupport> createState() => _MedicalSupportState();
}

class _MedicalSupportState extends State<MedicalSupport> {

  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Hey ${widget.data!['name']}"),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/img/main.png"),fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Container(
                
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 1,),
                  color: Color(0XFFE8F2F1),
                ),

                width: double.infinity,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Upload prescription",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),),
                    Text("We will help you for buy it."),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black, width: 1,),
                            color: Color(0XFFE8F2F1),
                          ),
                          child: Column(
                            children: [
                              Center(
                                child: CircleAvatar(
                                  radius: 33,
                                  child: GestureDetector(
                                    onTap: () {
                                      showImage();



                                    },
                                    child: Center(
                                      child: _image != null
                                          ? Container(
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: FileImage(File(_image!.path)))),
                                      )
                                          : Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.upload_file,
                                              size: 20,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),






                              Text("Add prescription"),
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        InkWell(
                          onTap: (){
                            _uploadImages();
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black, width: 1,),
                              color: Color(0XFFE8F2F1),
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.shopping_bag_outlined),
                                Text("Buy medicines"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  _imagefromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    Navigator.pop(context);
  }

  _imagefromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;

    });
    Navigator.pop(context);
  }

  showImage() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Ink(
                      decoration: ShapeDecoration(
                        color: Colors.pink,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        onPressed: () {
                          _imagefromCamera();
                        },
                        icon: Icon(Icons.camera_alt),
                      ),
                    ),
                    Text("Camera")
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Ink(
                      decoration: ShapeDecoration(
                        color: Colors.pink,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        onPressed: () {
                          _imagefromGallery();
                        },
                        icon: Icon(Icons.photo),
                      ),
                    ),
                    Text("Gallery")
                  ],
                ),
              ],
            ),
          );
        });
  }




  Future<void> _uploadImages() async {
     String downloadURL="";
    var id=Uuid().v1();
    User? user = FirebaseAuth.instance.currentUser;

    var snap = await FirebaseFirestore.instance
        .collection('login')
        .doc(user!.uid)
        .get();


    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().toIso8601String()}');
    final UploadTask uploadTask = storageReference.putFile(File(_image!.path));

    await uploadTask.whenComplete(() async {
      downloadURL = await storageReference.getDownloadURL();

    });

    await FirebaseFirestore.instance.collection("requests").doc(id).set({

      'id':id,
      'title':"Medical Support",
      'description':"Medical Support",
      'requestedby':user!.uid,
      'username':snap['name'],
      'volunteerSelected':0,
      'volunteerteerid':"NIL",
      'status':1,
      'createdat':DateTime.now(),
      'volunteername':"NIL",
      'imgurl':downloadURL,
      'imgstatus':1

    });



    // Clear the image list after uploading



  }
}
