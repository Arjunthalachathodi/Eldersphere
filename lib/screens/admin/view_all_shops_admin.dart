import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewAllShopsAdmin extends StatefulWidget {
  const ViewAllShopsAdmin({super.key});

  @override
  State<ViewAllShopsAdmin> createState() => _ViewAllShopsAdminState();
}

class _ViewAllShopsAdminState extends State<ViewAllShopsAdmin> {
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
            Text("All Shops"),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('shops').snapshots(),
              builder: (context, snapshopt) {
                if (snapshopt.hasError) {
                  return Center(
                    child: Text("Something went wrong"),
                  );
                }

                if (snapshopt.hasData && snapshopt.data!.docs.length == 0) {
                  return Center(
                    child: Text("No shops added"),
                  );
                }

                if (snapshopt.hasData) {
                  return ListView.builder(
                      itemCount: snapshopt.data!.docs.length,
                      itemBuilder: (context, index) {
                        final shop = snapshopt.data!.docs[index];

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
                                                "Shop Details",
                                                style: TextStyle(fontSize: 22),
                                              ),

                                              shop['status'] == 1?     Text("Disable"):Text("Activate"),
                                              shop['status'] == 1
                                                  ? IconButton(
                                                      onPressed: () {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('shops')
                                                            .doc(shop['id'])
                                                            .update(
                                                                {'status': 0});

                                                        Navigator.pop(context);
                                                      },
                                                      icon: Icon(Icons.delete))
                                                  : IconButton(
                                                      onPressed: () {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('shops')
                                                            .doc(shop['id'])
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
                                          Text(shop['shopname']),
                                          Text(shop['location']),
                                          Text(shop['shoptype']),
                                          Text(shop['number']),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            trailing: Icon(Icons.arrow_drop_down_circle),
                            leading: CircleAvatar(
                              child: Text("${index + 1}"),
                            ),
                            title: Text(shop['shopname']),
                            subtitle: Text(shop['location']),
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
