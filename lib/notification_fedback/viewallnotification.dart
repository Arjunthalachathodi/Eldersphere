
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eldersphere/model/notificationmodel.dart';
import 'package:eldersphere/notification_fedback/notificationservice.dart';
import 'package:eldersphere/widgets/apptext.dart';
import 'package:eldersphere/widgets/customcontainer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:uuid/uuid.dart';

import '../constants/constants1.dart';



class ViewAllNotifications extends StatefulWidget {


  ViewAllNotifications({Key? key, }) : super(key: key);

  @override
  State<ViewAllNotifications> createState() => _ViewAllNotificationsState();
}

class _ViewAllNotificationsState extends State<ViewAllNotifications> {

  NotificationService _notificationService=NotificationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: AppText(
          data: "All Notification",
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: _notificationService.getAllNotification(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<NotificationModel> message=
                snapshot.data as List<NotificationModel>;

                return ListView.builder(
                    itemCount: message.length,
                    itemBuilder: (context, index) {
                      var msg = message[index];
                      print(msg.title);
                      return Padding(
                        padding:
                        const EdgeInsets.only(right: 20, left: 20, top: 20),
                        child: CustomContainer(
                          ontap: () {},
                          height: 150,
                          width: 220,
                          decoration: BoxDecoration(
                              color: Colors.blue[200],
                              borderRadius: BorderRadius.circular(10)),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.red[300],
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: AppText(
                                            data: msg.status == 1
                                                ? "Delete"
                                                : "Deleted",
                                            color: Colors.white,
                                          )),
                                      msg.status == 1
                                          ? IconButton(
                                          onPressed: (){


                                            _notificationService.deleteMessage(msg.msgid);
                                            setState(() {

                                            });


                                          },
                                          icon: FaIcon(
                                            FontAwesomeIcons.trash,
                                            color: Colors.white,
                                          ))
                                          : SizedBox()
                                    ],
                                  ),
                                ),
                              ),

                              Positioned(
                                  top: 25,
                                  left: 60,
                                  right: 10,
                                  child: AppText(
                                    size: 16,
                                    fw: FontWeight.bold,
                                    data: "${msg.title}",
                                    color: Colors.white,
                                  )),
                              Positioned(
                                  top: 45,
                                  left: 60,
                                  right: 10,
                                  child: AppText(
                                    data: "${msg.message}",
                                    color: Colors.white,
                                  )),

                            ],
                          ),
                        ),
                      );
                    });
              }

              return Center(
                child: Text("no data"),
              );
            }),
      ),
    );
  }


}
