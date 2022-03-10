import 'package:flutter/material.dart';
import 'package:jaziadigitalid/DigitalId/Screens/AuthScreens/authserviceupdated.dart';
import 'package:jaziadigitalid/DigitalId/Screens/AuthScreens/ChiefLoginDialog.dart';
import 'package:jaziadigitalid/DigitalId/Screens/AuthScreens/loginwithGoogle.dart';
import 'package:jaziadigitalid/DigitalId/Screens/multistageform.dart';

class ChiefDrawer extends StatelessWidget {
  const ChiefDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: MediaQuery.of(context).size.width / 1.2,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Card(
                        elevation: 20,
                        color: Colors.greenAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.asset("assets/icon/23.png")),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 0.0, bottom: 8),
                            child: Text(
                              'name',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Text(
                            'Phone',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blueGrey.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.wb_sunny),
                                  onPressed: () {})
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: const Text('Name: '),
                leading: const Icon(Icons.person),
                onTap: () {
                  // Navigator.pushNamed(context, '/sixth');
                },
                trailing: const Icon(Icons.edit),
              ),

              ListTile(
                title: const Text('Contact US'),
                leading: const Icon(Icons.headset_mic),
                onTap: () async {
                  Navigator.of(context).pop();
                  //  await launch('tel:0722494071');
                },
              ),
              //ListTile(title: Text('Edit Profile'),onTap: (){Navigator.pushNamed(context, '/sixth');},leading: Icon(Icons.edit),),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Card(
                      elevation: 0,
                      child: ListTile(
                        title: const Text('SignOut'),
                        onTap: () async {
                          await AuthServiceUpdated().signOut();
                          Route route =
                              MaterialPageRoute(builder: (context) => Login());
                          Navigator.pushReplacement(context, route);
                        },
                        leading: const Icon(Icons.link_off),
                        enableFeedback: true,
                      ))),
            ],
          ),
        ));
  }
}
