import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:joy_top/example.dart';
import 'package:joy_top/registration/phone_number.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? name;
  String? phoneNumber;
  @override
  void initState() {
    super.initState();
    getUserDataFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: backColor,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Center(
            child: Text('joytop',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'DelaGothicOne'))),
      ),
      body: Center(
        child: (name == 'no')
            ? TextButton(
                child: Text('Sign up'),
                style: buttonStyle(screenSize.width, firstColor),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Number(),
                    )),
              )
            : Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 20),
                      Text(
                        name!,
                        style: TextStyle(
                            fontFamily: 'DelaGothicOne', fontSize: 30),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 20),
                      Text(
                        phoneNumber!,
                        style: TextStyle(
                            fontFamily: 'DelaGothicOne', fontSize: 20),
                      ),
                    ],
                  ),
                  _profileOption(Icons.settings, 'Settings'),
                  _profileOption(Icons.shopping_cart, 'Orders'),
                  _profileOption(Icons.notifications, 'Notifications'),
                  _profileOption(Icons.help, 'Help & Support'),
                  _profileOption(Icons.info, 'About'),
                  TextButton(
                    style: buttonStyle(screenSize.width, firstColor),
                    child: Text('Sign out'),
                    onPressed: () => signOut(context),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _profileOption(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        // You can add action for each ListTile here
        print('$title clicked');
      },
    );
  }

  void signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/',
        (route) =>
            false); // Assuming you have a named route for your login screen
  }

  Future<void> getUserDataFromFirestore() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userUID = user.phoneNumber!; // Using UID as the document ID
      setState(() {
        phoneNumber = userUID;
      });
      try {
        CollectionReference collection =
            FirebaseFirestore.instance.collection('users');
        DocumentSnapshot documentSnapshot = await collection.doc(userUID).get();

        // Check if the document exists
        if (documentSnapshot.exists) {
          // Get the data from the document
          Map<String, dynamic> data =
              documentSnapshot.data() as Map<String, dynamic>;
          setState(() {
            name = data['name'];
          });
          print(userUID);
        } else {
          print('Document does not exist');
          print(userUID);
        }
      } catch (e) {
        print("Error fetching user data: $e");
        setState(() {
          name = 'no';
        });
      }
    } else {
      print("No user is currently signed in.");
      setState(() {
        name = 'no';
      });
    }
  }
}
