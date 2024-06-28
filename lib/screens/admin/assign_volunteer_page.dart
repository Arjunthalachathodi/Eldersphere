import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eldersphere/model/volunteer_models.dart';
import 'package:flutter/material.dart';

class AssignVolunteerPage extends StatefulWidget {
  final request;
  const AssignVolunteerPage({super.key, this.request});

  @override
  State<AssignVolunteerPage> createState() => _AssignVolunteerPageState();
}

class _AssignVolunteerPageState extends State<AssignVolunteerPage> {
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
        child: SingleChildScrollView(
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
                      ? Text("Disable")
                      : Text("Activate"),
                  widget!.request['status'] == 1
                      ? IconButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('requests')
                                .doc(widget!.request['id'])
                                .update({'status': 0});

                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.delete))
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

            widget.request['imgstatus']==1?  Container(
                  height: 250,
                  child: Image.network(
                    widget.request!['imgurl'],
                  )):SizedBox.shrink(),

              SizedBox(
                height: 20,
              ),
              Text(
                "Assign Volunteer",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              widget!.request['volunteerSelected'] == 0
                  ? Container(
                      height: 100,
                      width: double.infinity,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: _stream,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }

                          List<QueryDocumentSnapshot> documents =
                              snapshot.data!.docs;
                          List<Volunteer> items = documents
                              .map((doc) => Volunteer(doc['name'], doc['uid']))
                              .toList();

                          return DropdownButtonFormField<Volunteer>(
                            value: _selectedVolunteer,
                            items: items
                                .map((volunteer) => DropdownMenuItem<Volunteer>(
                                      child: Text(volunteer.name),
                                      value: volunteer,
                                    ))
                                .toList(),
                            hint: Text('Select a volunteer'),
                            onChanged: (Volunteer? value) {
                              setState(() {
                                _selectedVolunteer = value;
                                _selectedVolunteerId = value?.uid;
                                print(
                                    "Selected Volunteer: ${value?.name}, ID: ${value?.uid}");
                              });
                            },
                            validator: (Volunteer? value) {
                              if (value == null) {
                                return 'Please select a volunteer';
                              }
                              return null;
                            },
                            onSaved: (Volunteer? value) {
                              print(
                                  'Saved volunteer: ${value?.name}, ID: ${value?.uid}');
                            },
                          );
                        },
                      ),
                    )
                  : Text(
                      "Volunteer Selected: ${widget!.request['volunteername']}"),
              SizedBox(
                height: 20,
              ),
              widget!.request['volunteerSelected'] == 0
                  ? ElevatedButton(
                      onPressed: () {
                        print(_selectedVolunteer);
                        FirebaseFirestore.instance
                            .collection('requests')
                            .doc(widget!.request['id'])
                            .update({
                          'volunteerSelected': 1,
                          'volunteername': _selectedVolunteerId != null
                              ? _selectedVolunteer!.name
                              : "NIL",
                          'volunteerteerid': _selectedVolunteerId,
                        }).then((value) => Navigator.pop(context));
                      },
                      child: Text("Assign Volunteer"))
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
