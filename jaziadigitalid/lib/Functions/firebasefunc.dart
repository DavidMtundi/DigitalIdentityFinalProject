import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseFunc {
  List<String> downloadedUrls = [];

  String uniqueid = DateTime.now().millisecondsSinceEpoch.toString();
  Future<void> savePersonDetails(
      String fname,
      String lname,
      String work,
      DateTime dob,
      String fathername,
      String mothername,
      String grandfathername,
      String grandmothername,
      String location,
      String sublocation,
      String village,
      String vouchertype,
      String voucherid,
      List<String> personpicsurls) async {
    try {
      final itemsRef = FirebaseFirestore.instance.collection("items");
      itemsRef.doc(uniqueid).set({
        "fname": fname,
        "lname": lname,
        "work": work,
        "dob": dob,
        "fathername": fathername,
        "mothername": mothername,
        "grandfathername": grandfathername,
        "grandmothername": grandmothername,
        "location": location,
        "sublocation": sublocation,
        "village": village,
        "vouchertype": vouchertype,
        "voucherid": voucherid,
        "DigitalIdentity": uniqueid,
        "personpics": FieldValue.arrayUnion(downloadedUrls),
      });
    } catch (ex) {
      // setState(() {
      //   isloading = false;
      // });
    }
  }

//saving the profiles
  Future uploadAllImages(images) async {
//get all the images and save them
    if (images.isNotEmpty) {
      for (int i = 0; i < images.length; i++) {
        // downloadedUrls[i] = await _uploadandSaveimage(images[i]);
        downloadedUrls.add(await _uploadandSaveimage(images[i]));
      }
    } else {
      Fluttertoast.showToast(
          msg: "Please select atleast one image to continue");
    }
    return downloadedUrls;
  }

  Future<String> _uploadandSaveimage(mFileImage) async {
    // requestpermissions();
    String downloadurlvalue = "";
    if (mFileImage == null) {
      //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //  content: const Text("Unable to pick the File please Try again")));
    } else {
      // String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();

      final Reference storagereference =
          FirebaseStorage.instance.ref().child("profiles");
      print(mFileImage['originalPath'].toString());

      UploadTask uploadTask = storagereference
          .child("image_$uniqueid.jpg")
          .putFile(File(mFileImage['originalPath'].toString()));

      downloadurlvalue = await (await uploadTask).ref.getDownloadURL();
    }
    return downloadurlvalue;
  }

  Future readData(String uid) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((datasnapshot) async {
      // await DigitalIdentity.preferences!.setString(DigitalIdentity.userphone,
      //     datasnapshot.data()![DigitalIdentity.userphone]);
      // await DigitalIdentity.preferences!.setString(DigitalIdentity.userUID,
      //     datasnapshot.data()![DigitalIdentity.userUID]);
      // await DigitalIdentity.preferences!.setString(DigitalIdentity.userEmail,
      //     datasnapshot.data()![DigitalIdentity.userEmail]);
      // await DigitalIdentity.preferences!.setString(DigitalIdentity.userName,
      //     datasnapshot.data()![DigitalIdentity.userName]);

      // List<String> images = await datasnapshot
      //     .data()![DigitalIdentity.usercartList]
      //     .cast<String>();
      // await datasnapshot.data()![DigitalIdentity.usercartList] != null
      //     ? await DigitalIdentity.preferences!
      //         .setStringList(DigitalIdentity.usercartList, cartList)
      //     : await DigitalIdentity.preferences!
      //         .setStringList(DigitalIdentity.usercartList, []);
    });
  }
}
