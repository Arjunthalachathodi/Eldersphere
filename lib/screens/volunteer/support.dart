import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eldersphere/model/volunteer_models.dart';
import 'package:eldersphere/screens/admin/assign_volunteer_page.dart';
import 'package:eldersphere/screens/volunteer/request_details_page.dart';
import 'package:flutter/material.dart';

class ViewAllRequestsVolunteer extends StatefulWidget {
  final data;
  const ViewAllRequestsVolunteer({super.key,this.data});

  @override
  State<ViewAllRequestsVolunteer> createState() => _ViewAllRequestsVolunteerState();
}

class _ViewAllRequestsVolunteerState extends State<ViewAllRequestsVolunteer> {

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
            Text("All Requests"),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: StreamBuilder(
                  stream:
                  FirebaseFirestore.instance.collection('requests').where('volunteerteerid',isEqualTo:widget.data!['uid'] ).where('status',isEqualTo:1).snapshots(),
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

                              child: ListTile(
                                onTap: () {

                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestDetailsPage(request: request,)));

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
