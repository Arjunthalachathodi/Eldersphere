import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewAllEventsAdmin extends StatefulWidget {
  const ViewAllEventsAdmin({super.key});

  @override
  State<ViewAllEventsAdmin> createState() => _ViewAllEventsAdminState();
}

class _ViewAllEventsAdminState extends State<ViewAllEventsAdmin> {
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
            Text("All Events"),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: StreamBuilder(
                  stream:
                  FirebaseFirestore.instance.collection('events').snapshots(),
                  builder: (context, snapshopt) {
                    if (snapshopt.hasError) {
                      return Center(
                        child: Text("Something went wrong"),
                      );
                    }

                    if (snapshopt.hasData && snapshopt.data!.docs.length == 0) {
                      return Center(
                        child: Text("No events added"),
                      );
                    }

                    if (snapshopt.hasData) {

                      return ListView.builder(
                          itemCount: snapshopt.data!.docs.length,
                          itemBuilder: (context, index) {
                            final event = snapshopt.data!.docs[index];

                            return Card(
                              child: ListTile(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          width: MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.all(20),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    "Event Details",
                                                    style: TextStyle(fontSize: 22),
                                                  ),

                                                  event['status'] == 1?     Text("Disable"):Text("Activate"),
                                                  event['status'] == 1
                                                      ? IconButton(
                                                      onPressed: () {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('events')
                                                            .doc(event['id'])
                                                            .update(
                                                            {'status': 0});

                                                        Navigator.pop(context);
                                                      },
                                                      icon: Icon(Icons.delete))
                                                      : IconButton(
                                                      onPressed: () {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('events')
                                                            .doc(event['id'])
                                                            .update(
                                                            {'status': 1});

                                                        Navigator.pop(context);
                                                      },
                                                      icon: Icon(Icons.check))
                                                ],
                                              ),
                                              Divider(
                                                height: 2,
                                                color: Colors.red,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(snapshopt.data?.docs[index]['title'],style: TextStyle(
                                                fontSize:20,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                              Text(snapshopt.data?.docs[index]['description']),
                                              Text(snapshopt.data?.docs[index]['venue']),
                                              Text(snapshopt.data?.docs[index]['organiser name']),
                                              Text(snapshopt.data?.docs[index]['contact number']),
                                              Text(snapshopt.data?.docs[index]['date and time']),
                                            ],
                                          ),
                                        );
                                      });
                                },
                                trailing: Icon(Icons.arrow_drop_down_circle),
                                leading: CircleAvatar(
                                  child: Text("${index + 1}"),
                                ),
                                title: Text(snapshopt.data?.docs[index]['title']),
                                subtitle: Text(snapshopt.data?.docs[index]['organiser name']),
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
