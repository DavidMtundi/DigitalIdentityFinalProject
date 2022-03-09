import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jaziadigitalid/DigitalId/Screens/AuthScreens/authservice.dart';
import 'package:jaziadigitalid/DigitalId/Screens/customDrawer.dart';
import 'package:jaziadigitalid/DigitalId/Screens/multistageform.dart';
import 'package:jaziadigitalid/DigitalId/Screens/profilepages/buildAppBarwidget.dart';
import 'package:jaziadigitalid/DigitalId/Screens/profilepages/profileWidget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        drawer: CustomDrawer(),
        body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
              stream: firestore
                  .collection("DigitalIdentity")
                  .doc("ChiefId")
                  .collection("Vouched")
                  .where("uid", isEqualTo: auth.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                try {
                  return snapshot.hasData
                      ? ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            ProfileWidget(
                              imagePath: snapshot.data!.docs.first['personpics']
                                  [0],
                              onClicked: () async {},
                            ),
                            const SizedBox(height: 24),
                            buildid(
                                snapshot.data!.docs.first['DigitalIdentity']),
                            const SizedBox(
                              height: 24,
                            ),
                            //build individual details
                            buildHeaderName("First Name", "Second Name"),
                            buildNameDetails(snapshot.data!.docs.first['fname'],
                                snapshot.data!.docs.first['lname']),
                            const SizedBox(height: 24),

                            //build parentdetails
                            buildHeaderName("Father", "Mother Name"),
                            buildNameDetails(
                                snapshot.data!.docs.first['fathername'],
                                snapshot.data!.docs.first['mothername']),
                            const SizedBox(height: 24),

                            //build parentdetails
                            buildHeaderName("Location", "Village"),
                            buildNameDetails(
                                snapshot.data!.docs.first['location'],
                                snapshot.data!.docs.first['village']),
                            const SizedBox(height: 24),

                            //buildHeaderName(),
                            const SizedBox(height: 24),
                            //Center(child: buildUpgradeButton()),
                            const SizedBox(height: 24),
                            // NumbersWidget(),
                            const SizedBox(height: 48),
                            //buildAbout(user),
                          ],
                        )
                      : CircularProgressIndicator();
                } catch (e) {
                  return DIRegister(
                    isenabled: false,
                  );
                }
              }),
        ));
  }

  Widget buildHeaderName(String firstheader, String secondHeader) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            firstheader,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          const SizedBox(height: 10),
          Text(
            secondHeader,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          )
        ],
      );

  Widget buildNameDetails(String firstname, String sname) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            firstname,
            style: const TextStyle(color: Colors.grey, fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
            sname,
            style: const TextStyle(color: Colors.grey, fontSize: 20),
          )
        ],
      );

  Widget buildid(String digitalId) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Digital Id',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              digitalId,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
