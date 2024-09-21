import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:joy_top/example.dart';
import 'package:joy_top/pages/home_page.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(left: 15, right: 10),
              decoration: decoration(),
              width: screenSize.width * 0.8,
              height: 60,
              child: TextFormField(
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
                onChanged: (value) => setState(() {}),
                autofocus: true,
                onSaved: (newValue) => saveChanges(newValue!),
                controller: nameController,
                cursorColor: firstColor,
                decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, color: Colors.transparent)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, color: Colors.transparent)),
                    labelText: 'Your name',
                    labelStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              style: buttonStyle(screenSize.width,
                  (nameController.text.length != 0) ? firstColor : Colors.grey),
              onPressed: () => saveChanges(nameController.text),
              child: isLoading
                  ? Container(
                      height: 30,
                      width: 30,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void saveChanges(String name) async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      isLoading = true;
    });

    if (user != null) {
      // User is signed in
      String? phoneNumber = user.phoneNumber;
      await createUserDocument(phoneNumber!, name);
      print("Signed in with phone number: $phoneNumber");
    } else {
      // No user is signed in
      print("No user is currently signed in");
    }
  }

  Future<void> createUserDocument(String phoneNumber, String name) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    try {
      await users
          .doc(phoneNumber) // Use the phone number as the document ID
          .set({'name': name}).then((value) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
          (Route<dynamic> route) => false, // Remove all previous routes
        );
      });
    } catch (e) {
      // Handle the error, possibly rethrowing it or logging it
      print('Error creating user document: $e');
      throw e; // Rethrowing the error
    }
  }
}
