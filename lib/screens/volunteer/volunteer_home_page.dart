import 'package:eldersphere/common/login_page.dart';
import 'package:eldersphere/screens/admin/shop_registration.dart';
import 'package:eldersphere/screens/volunteer/support.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class VolunterHomepage extends StatefulWidget {
  final data;
  const VolunterHomepage({super.key,this.data});

  @override
  State<VolunterHomepage> createState() => _VolunterHomepageState();
}

class _VolunterHomepageState extends State<VolunterHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0XFF68CAF0),
        title: const Text(
        "ElderSphere",
        style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
    ),
    ),
          actions: <Widget> [
            IconButton(
              onPressed: () {


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
                                  "Profile Details",
                                  style: TextStyle(fontSize: 22),
                                ),

                                TextButton(onPressed: (){

                                  FirebaseAuth.instance.signOut();
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);

                                }, child: Text("Logout"))


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
        ),
      body: SafeArea(
           child: Padding(
             padding: EdgeInsets.all(10),
             child: Column(
               children: [
                 GestureDetector(
                   onTap: ()
                   {
                   Navigator.push(context, MaterialPageRoute(builder: (context) =>ViewAllRequestsVolunteer(data:widget!.data ,)));

                   },
                   child: Container(
                     height: 100,
                     width: double.infinity,
                     padding: EdgeInsets.all(5),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       border: Border.all(color: Colors.black, width: 1,),
                       color: Colors.white,
                     ),
                     child: Column(
                       children: [
                        Text("Volunteer jobs",style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                        ),),
                       ],
                     ),
                   ),
                 ),
               ],

       ),
           ),

      ),
    );
  }
}
