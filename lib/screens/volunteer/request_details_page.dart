import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eldersphere/model/volunteer_models.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestDetailsPage extends StatefulWidget {
  final request;
  const RequestDetailsPage({super.key, this.request});

  @override
  State<RequestDetailsPage> createState() => _RequestDetailsPageState();
}

class _RequestDetailsPageState extends State<RequestDetailsPage> {
  String? _selectedVolunteerId;
  Volunteer? _selectedVolunteer;
  TextEditingController _msgController = TextEditingController();
  final _key = GlobalKey<FormState>();

  // Declare a reference to the firebase collection
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('login');

  // Declare a stream to listen to the collection changes
  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    _stream =
        _collectionRef.where('usertype', isEqualTo: 'volunteer').snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assign Volunteer"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
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
                  "Request",
                  style: TextStyle(fontSize: 22),
                ),
                widget!.request['status'] == 1
                    ? Text("Not Completed")
                    : Text("Completed"),
                widget!.request['status'] == 1
                    ? IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('requests')
                              .doc(widget!.request['id'])
                              .update({'status': 0});

                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.pending))
                    : IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('requests')
                              .doc(widget!.request['id'])
                              .update({'status': 1});

                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.check)),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Title",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            Divider(
              endIndent: 50,
              height: 2,
              color: Colors.red,
            ),
            SizedBox(
              height: 20,
            ),
            Text("${widget!.request['title']}"),
            SizedBox(
              height: 20,
            ),
            Text(
              "Description",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            Divider(
              endIndent: 50,
              height: 2,
              color: Colors.red,
            ),
            SizedBox(
              height: 20,
            ),
            Text("${widget!.request['description']}"),
            SizedBox(
              height: 20,
            ),
            Text(
              "Posted By",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            Divider(
              endIndent: 50,
              height: 2,
              color: Colors.red,
            ),
            SizedBox(
              height: 20,
            ),
            Text("${widget!.request['username']}"),
            SizedBox(
              height: 20,
            ),
            Text(
              "Job Details",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('login')
                  .doc(widget.request!['requestedby'])
                  .get(),
              builder: (context, snapshopt) {
                if (snapshopt.hasError) {
                  return Center(
                    child: Text("Something went wrong"),
                  );
                }

                if (snapshopt.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${snapshopt!.data!['name']}"),
                      Text("${snapshopt!.data!['email']}"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${snapshopt!.data!['phone']}"),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                                onPressed: () {
                                  _makePhoneCall(snapshopt!.data!['phone']);
                                },
                                icon: Icon(
                                  Icons.call,
                                  color: Colors.green,
                                )),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                                onPressed: () {
                                  openWhatsapp(
                                      context: context,
                                      text: "Helo",
                                      number: snapshopt.data!['phone']);
                                },
                                icon: Icon(
                                  Icons.whatshot,
                                  color: Colors.green,
                                )),
                          )
                        ],
                      )
                    ],
                  );
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            )),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }

  void openWhatsapp(
      {required BuildContext context,
      required String text,
      required String number}) async {
    print(number);
    var whatsapp = "+91${number}";
    print(whatsapp); //+92xx enter like this
    var whatsappURlAndroid =
        "whatsapp://send?phone=" + whatsapp + "&text=$text";
    var whatsappURLIos = "https://wa.me/$whatsapp?text=${Uri.tryParse(text)}";
    if (Platform.isAndroid) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
        await launchUrl(Uri.parse(
          whatsappURLIos,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp not installed")));
      }
    } else {
      // android , web
      if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
        await launchUrl(Uri.parse(whatsappURlAndroid));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp not installed")));
      }
    }
  }
}
