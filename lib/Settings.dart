import 'package:annoying_friend_app/Data/Texts.dart';
import 'package:annoying_friend_app/Services.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<StatefulWidget> createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  bool light = true;
  final LocalNotification _localNotification = LocalNotification();
  final Notificationlist _notificationlist = Notificationlist();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Settings"),
          backgroundColor: Colors.black87,
        ),
        body: ListView(padding: const EdgeInsets.all(10), children: <Widget>[
          const Center(
            child: Card(
                elevation: 4.0,
                child: Column(children: <Widget>[
                  // custom card that shows annoying friend stuff.
                ])),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Display",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          Card(
              elevation: 4.0,
              child: Column(
                children: <Widget>[
                  // stop receiving notifications
                  ListTile(
                    title: const Text("Notifications"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        //Notifications toggle switch
                        Switch(
                            activeColor: Colors.yellow,
                            value: light,
                            onChanged: (bool value) {
                              setState(() {
                                light = value;
                                if (light) {
                                  _localNotification.scheduleRandomNotification(
                                      _notificationlist.notificationList);
                                } else {
                                  _localNotification.cancelAllNotifications();
                                }
                              });
                            }),
                      ],
                    ),
                  ),
                ],
              )),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "More",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          Card(
              elevation: 4.0,
              child: Column(children: <Widget>[
                //Displaying name
                ListTile(
                  title: const Text("Feed Back"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      //feedback page
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),

                /// Terms and conditions
                // ListTile(
                //   leading: const Text("Terms and Conditions"),
                //   trailing: Row(
                //     mainAxisSize: MainAxisSize.min,
                //     children: <Widget>[
                //       //Terms and Conditions
                //       IconButton(
                //         icon:
                //         const Icon(Icons.arrow_forward_ios),
                //         onPressed: () {
                //                                   },
                //       ),
                //     ],
                //   ),
                // ),
                const ListTile(
                  title: Text("About"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      //version
                      Text('Mock version'),
                    ],
                  ),
                )
              ]))
        ]));
  }
}
