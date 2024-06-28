import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eldersphere/model/volunteer_models.dart';
import 'package:eldersphere/screens/admin/assign_volunteer_page.dart';
import 'package:flutter/material.dart';

class ViewAllRequestsCompletedAdmin extends StatefulWidget {
  const ViewAllRequestsCompletedAdmin({super.key});

  @override
  State<ViewAllRequestsCompletedAdmin> createState() => _ViewAllRequestsCompletedAdminState();
}

class _ViewAllRequestsCompletedAdminState extends State<ViewAllRequestsCompletedAdmin> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("All Completed Requests"),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: StreamBuilder(
                  stream:
                  FirebaseFirestore.instance.collection('requests').where('status',isEqualTo:0 ).snapshots(),
                  builder: (context, snapshopt) {
                    if (snapshopt.hasError) {
                      return Center(
                        child: Text("Something went wrong"),
                      );
                    }

                    if (snapshopt.hasData && snapshopt.data!.docs.length == 0) {
                      return Center(
                        child: Text("No requests completed"),
                      );
                    }

                    if (snapshopt.hasData) {
                      return ListView.builder(
                          itemCount: snapshopt.data!.docs.length,
                          itemBuilder: (context, index) {
                            final request = snapshopt.data!.docs[index];

                            return Card(
                              color: request['volunteerSelected'] == 1
                                  ? Colors.green
                                  : Colors.white,
                              child: ListTile(
                                onTap: () {

                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AssignVolunteerPage(request: request,)));

                                },
                                trailing: Icon(Icons.arrow_drop_down_circle),
                                leading: CircleAvatar(
                                  child: Text("${index + 1}"),
                                ),
                                title: Text(snapshopt.data?.docs[index]['title']),
                                subtitle: Text(
                                    snapshopt.data?.docs[index]['description']),
                              ),
                            );
                          });
                    }

                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}
