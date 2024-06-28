import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eldersphere/data.dart';
import 'package:flutter/material.dart';

class homeDelivery extends StatefulWidget {
  const homeDelivery({super.key});

  @override
  State<homeDelivery> createState() => _homeDeliveryState();
}

class _homeDeliveryState extends State<homeDelivery> {


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
              Text("Nearest Shops"),
              Expanded(
                child: FutureBuilder(
                  future: FirebaseFirestore.instance.collection('shops').where('status',isEqualTo: 1).get(),

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
                            final shop = snapshot.data!.docs[index];
                            return Card(
                                child: ExpansionTile(
                                  title: Text('${shop['shopname']}'),
                                  children: <Widget>[
                                    ListTile(
                                      title: Text('${shop['location']}'),
                                    ),
                                    ListTile(
                                      title: Text('${shop['number']}'),
                                    ),
                                    ListTile(
                                      title: Text('${shop['shoptype']}'),
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
