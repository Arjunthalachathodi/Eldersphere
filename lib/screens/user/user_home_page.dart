import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eldersphere/common/login_page.dart';
import 'package:eldersphere/constants/constants1.dart';
import 'package:eldersphere/constants/formdecoration.dart';
import 'package:eldersphere/data.dart';
import 'package:eldersphere/notification_fedback/viewallnotification.dart';
import 'package:eldersphere/screens/user/add_feedback.dart';
import 'package:eldersphere/screens/user/community_view.dart';
import 'package:eldersphere/screens/user/homeDelivery.dart';
import 'package:eldersphere/screens/user/medical_support.dart';
import 'package:eldersphere/screens/user/volunteerSupport.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svg_flutter/svg_flutter.dart';

class HomePage extends StatefulWidget {
  final DocumentSnapshot? data;
  const HomePage({super.key, this.data});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "ElderSphere",
          style: TextStyle(
              color: Colors.blue, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewAllNotifications()));
            },
            icon: Icon(Icons.notifications_active),
          ),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Profile Details",
                                style: TextStyle(fontSize: 22),
                              ),
                              Text(widget.data!['name']),
                            ],
                          ),
                          Divider(
                            height: 2,
                            color: Colors.red,
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          TextButton(
                              onPressed: () async {
                                FirebaseAuth.instance.signOut();

                                SharedPreferences _pref =
                                await SharedPreferences.getInstance();

                                _pref.clear();
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()),
                                        (route) => false);
                              },
                              child: Text("Logout")),

                          TextButton(
                              onPressed: () async {

                                Navigator.push(context, MaterialPageRoute(builder: (context)=>SendFeedback()));
                              },
                              child: Text("Add Feedback"))
                        ],
                      ),
                    );
                  });
            },
            icon: Icon(Icons.person),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.40,
                  decoration: BoxDecoration(
                    color: Color(0xffF7BF71),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(70),
                      bottomRight: Radius.circular(00),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment(0, 0.5),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height * 0.20,
                          width: MediaQuery.of(context).size.width * 0.90,
                          decoration: BoxDecoration(
                            color: Color(0xffF9D49F),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  // Image.asset(
                                  //   "assets/img/clipboard.png",
                                  // ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/img/clipboard.png",
                                            height: 30,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Daily Tasks",
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text("Complete your daily tasks."),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                          height: 60,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.35,
                                          child: StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection('tasks')
                                                .snapshots(),
                                            builder: (context, snapshot) {

                                              if(snapshot.connectionState==ConnectionState.waiting){

                                                return Center(
                                                  child: Text("Waiting for taks.......")
                                                );
                                              }

                                              if (snapshot.hasError) {
                                                return Center(
                                                  child: Text(
                                                      "Something went wrong"),
                                                );
                                              }

                                              if (snapshot.hasData &&
                                                  snapshot.data!.docs.length ==
                                                      0) {
                                                return Center(
                                                  child:
                                                      Text("No requests added"),
                                                );
                                              }

                                              return ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: snapshot
                                                      .data!.docs.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final task = snapshot
                                                        .data!.docs[index];
                                                    return InkWell(
                                                      onTap: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                actions: [
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          FirebaseFirestore
                                                                              .instance
                                                                              .collection('tasks')
                                                                              .doc(task['id'])
                                                                              .update({
                                                                            'status':
                                                                                0,
                                                                          }).then((value) => Navigator.pop(context));
                                                                        });

                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                          "Completed"))
                                                                ],
                                                                content:
                                                                    Container(
                                                                  height: 450,
                                                                  width: 350,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                          "Your Daily Task"),
                                                                      Divider(
                                                                        height:
                                                                            3,
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                      Text(task[
                                                                              'taskname']
                                                                          .toString()),
                                                                      Text(task[
                                                                          'description'])
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            right: 10),
                                                        width: 60,
                                                        height: 60,
                                                        decoration: BoxDecoration(
                                                            color: task['status'] ==
                                                                    0
                                                                ? Colors
                                                                    .lightGreen
                                                                : Colors.grey,
                                                            shape: BoxShape
                                                                .circle),
                                                        child: Center(
                                                          child: Text(
                                                            "${tasklist[index]['id']}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        padding:
                                                            EdgeInsets.all(10),
                                                      ),
                                                    );
                                                  });
                                            },
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
                    MaterialPageRoute(
                        builder: (context) => VolunteerSupport(
                              data: widget.data,
                            )));
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            height: 180,
                            width: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color(0xffDFE2F1),
                            ),
                            child: Image.asset(
                              "assets/img/donation.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text(
                            "Volunteer support",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MedicalSupport(
                                            data: widget.data,
                                          )));
                            },
                            child: Container(
                              padding: EdgeInsets.all(20),
                              height: 180,
                              width: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color(0xffDFE2F1),
                              ),
                              child: Image.asset(
                                "assets/img/medical.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Text(
                            "Medical Support",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => homeDelivery(
                                        )));
                          },
                          child: Container(
                            padding: EdgeInsets.all(20),
                            height: 180,
                            width: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color(0xffDFE2F1),
                            ),
                            child: Image.asset(
                              "assets/img/delivery.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Text(
                          "Shops",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CommunityView()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(20),
                            height: 180,
                            width: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color(0xffDFE2F1),
                            ),
                            child: Image.asset(
                              "assets/img/people.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Text(
                          "Community",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
