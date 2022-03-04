import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DigitalId {
  static const String appName = "e_id";
  static SharedPreferences? preferences;
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static String collectionUser = "users";
  static String collectionOrders = "orders";
  static String usercartList = "usercart";
  static String subcollectionAddress = "useraddress";
  static String userphone = "phone";
  static String isuser = "isuser";

  static const String userName = "name";
  static const String userEmail = "email";
  static const String userUID = "uid";
  static const String userPhotoUrl = "photourl";
  static const String userAvatarurl = "url";

  static const String addressId = "addressId";

  static String currentuserPhotUrl = "";
}

String? geterror(String? controller) {
  final text = controller!.toString();
  if (text.isEmpty) {
    return "Field cannot be empty";
  }

  return null;
}
