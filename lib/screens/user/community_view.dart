import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eldersphere/data.dart';
import 'package:flutter/material.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({super.key});

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/img/main.png"),fit: BoxFit.cover),
          ),
          padding: EdgeInsets.all(20),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Latest Events"),
              Expanded(
                child: FutureBuilder(
                  future: FirebaseFirestore.instance.collection('events').where('status',isEqualTo: 1).get(),

                builder: (context,snapshot){

                    if(snapshot.connectionState==ConnectionState.waiting){

                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if(snapshot.hasError){

                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }



                    if(snapshot.hasData && snapshot.data!.docs.length!=0){

                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final event = snapshot.data!.docs[index];
                            return Card(
                                child: ExpansionTile(
                                  title: Text('${event['title']}'),
                                  children: <Widget>[
                                    ListTile(
                                      title: Text('${event['description']}'),
                                    ),
                                    ListTile(
                                      title: Text('${event['date and time']}'),
                                    ), ListTile(
                                      title: Text('${event['organiser name']}'),
                                    ),ListTile(
                                      title: Text('${event['venue']}'),
                                    ),ListTile(
                                      title: Text('${event['contact number']}'),
                                    ),
                                    // Add more ListTile widgets for additional subitems
                                  ],
                                ));
                          });
                    }

                    return Center(
                      child: CircularProgressIndicator(),
                    );
                }
                  ,

                ),
              )
            ],
          )),
    );
  }
}
