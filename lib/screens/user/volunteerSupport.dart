import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eldersphere/model/volunteer_models.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:uuid/uuid.dart';

class VolunteerSupport extends StatefulWidget {
  final DocumentSnapshot? data;
  const VolunteerSupport({Key? key, this.data}) : super(key: key);

  @override
  State<VolunteerSupport> createState() => _VolunteerSupportState();
}



class _VolunteerSupportState extends State<VolunteerSupport> {
  List<String> volunteers = [
    "Volunteer1",
    "Volunteer2",
    "Volunteer3",
    "Volunteer4",
    "Volunteer5",
    "Volunteer6",
  ];

  String? _selectedVolunteerId;
  Volunteer? _selectedVolunteer;
  TextEditingController _msgController = TextEditingController();
  final _key = GlobalKey<FormState>();

  // Declare a reference to the firebase collection
  CollectionReference _collectionRef = FirebaseFirestore.instance.collection('login');

  // Declare a stream to listen to the collection changes
  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    _stream = _collectionRef.where('usertype', isEqualTo: 'volunteer').snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Hey ${widget.data!['name']}"),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(

            padding: EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/svg/volu.svg',
                    semanticsLabel: 'Acme Logo',
                    height: 50,
                  ),
                  Text(
                    "How can I help you?",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Enter a brief description of the service you want?",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    controller: _msgController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Msg is mandatory";
                      }
                    },
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: _stream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      }

                      List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
                      List<Volunteer> items =
                      documents.map((doc) => Volunteer(doc['name'], doc['uid'])).toList();

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
                            print("Selected Volunteer: ${value?.name}, ID: ${value?.uid}");
                          });
                        },

                        onSaved: (Volunteer? value) {
                          print('Saved volunteer: ${value?.name}, ID: ${value?.uid}');
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {



                        var id=Uuid().v1();

                        FirebaseFirestore.instance.collection('requests').doc(id).set({



                          'id':id,
                          'title':_msgController.text,
                          'description':_msgController.text,
                          'requestedby':widget.data!['uid'],
                          'username':widget.data!['name'],
                          'volunteerSelected':_selectedVolunteerId!=null?1:0,
                          'volunteerteerid':_selectedVolunteerId!=null?_selectedVolunteerId:"NIL",
                          'status':1,
                          'createdat':DateTime.now(),
                          'volunteername':_selectedVolunteerId!=null?_selectedVolunteer!.name:"NIL",
                          'imgurl':"NIL",
                          'imgstatus':0


                        }).then((value) =>  Navigator.pop(context));




                      }
                    },
                    child: Text("Save"),

                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}