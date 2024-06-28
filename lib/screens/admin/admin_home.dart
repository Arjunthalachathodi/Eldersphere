import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eldersphere/common/login_page.dart';
import 'package:eldersphere/notification_fedback/allfeedbacks.dart';
import 'package:eldersphere/notification_fedback/sendnotification.dart';
import 'package:eldersphere/screens/admin/Volunteer_job.dart';
import 'package:eldersphere/screens/admin/add_community.dart';
import 'package:eldersphere/screens/admin/shop_registration.dart';
import 'package:eldersphere/screens/admin/tasks_creator.dart';
import 'package:eldersphere/screens/admin/view_all_event_admin.dart';
import 'package:eldersphere/screens/admin/view_all_shops_admin.dart';
import 'package:eldersphere/screens/admin/viewall_req_completed.dart';
import 'package:eldersphere/screens/admin/viewall_requests.dart';
import 'package:eldersphere/screens/admin/viewall_task_admin.dart';
import 'package:eldersphere/utils/dashboardwidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  final DocumentSnapshot? data;
  const AdminHome({super.key, this.data});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
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
                              TextButton(
                                  onPressed: () {
                                    FirebaseAuth.instance.signOut();
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()),
                                        (route) => false);
                                  },
                                  child: Text("Logout"))
                            ],
                          ),
                          Divider(
                            height: 2,
                            color: Colors.red,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(widget.data!['name']),
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
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              DashboardItemWidget(
                  onTap1: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShopRegister()));
                  },
                  onTap2: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewAllShopsAdmin()));
                  },
                  titleOne: "Add Shops",
                  titleTwo: "View Shops"),
              SizedBox(
                height: 10,
              ),
              DashboardItemWidget(
                  onTap1: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TasksCreater()));
                  },
                  onTap2: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewAllTaskAdmin()));
                  },
                  titleOne: "Create Task",
                  titleTwo: "View Tasks"),

              SizedBox(
                height: 10,
              ),
              DashboardItemWidget(
                  onTap1: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CommunityCreate()));
                  },
                  onTap2: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewAllEventsAdmin()));
                  },
                  titleOne: "Create Event",
                  titleTwo: "View Events"),

              SizedBox(
                height: 10,
              ),
              DashboardItemWidget(
                  onTap1: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewAllRequestsAdmin()));
                  },
                  onTap2: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ViewAllRequestsCompletedAdmin()));
                  },
                  titleOne: "All Request",
                  titleTwo: "Completed requests"),
              SizedBox(
                height: 10,
              ),
              DashboardItemWidget(
                  onTap1: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewAllFeedbackAdmin()));
                  },
                  onTap2: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => SendNotification ()));
                  },
                  titleOne: "All Feedbacks",
                  titleTwo: "Notifications"),

              // GestureDetector(
              //   onTap: () {
              //
              //   },
              //   child: Container(
              //     height: 100,
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       color: Colors.blue[200],
              //       borderRadius: BorderRadius.circular(25),
              //     ),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Text(
              //           "ADD SHOPS",
              //           style: TextStyle(
              //             fontSize: 25,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //         Text("Add shops for users"),
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(height: 10),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => TasksCreater()));
              //   },
              //   child: Container(
              //     height: 100,
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       color: Colors.blue[200],
              //       borderRadius: BorderRadius.circular(25),
              //     ),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Text(
              //           "TASKS",
              //           style: TextStyle(
              //             fontSize: 25,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //         Text("Create new daily tasks for user"),
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => CommunityCreate()));
              //   },
              //   child: Container(
              //     height: 100,
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       color: Colors.blue[200],
              //       borderRadius: BorderRadius.circular(25),
              //     ),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Text(
              //           "COMMUNITY",
              //           style: TextStyle(
              //             fontSize: 25,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //         Text("Create new community programs for user"),
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => VolunteerJob()));
              //   },
              //   child: Container(
              //     height: 100,
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       color: Colors.blue[200],
              //       borderRadius: BorderRadius.circular(25),
              //     ),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Text(
              //           "VOLUNTEER",
              //           style: TextStyle(
              //             fontSize: 25,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //         Text("Allocate volunteer for user"),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
