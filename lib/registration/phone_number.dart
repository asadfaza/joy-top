import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:joy_top/example.dart';
import 'package:joy_top/pages/home_page.dart';
import 'package:joy_top/registration/personal_info.dart';

class Number extends StatefulWidget {
  const Number({super.key});

  @override
  State<Number> createState() => _NumberState();
}

class _NumberState extends State<Number> {
  TextEditingController phoneController = TextEditingController();
  String? _verificationId;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Container(),
        actions: [
          TextButton(
              onPressed: () => confirmMassage(
                    title: 'Skip auth',
                    content: 'You are anyway requred to do auth later',
                    context: context,
                    func: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                      (Route<dynamic> route) =>
                          false, // Remove all previous routes
                    ),
                  ),
              child: Text(
                'Skip',
                style: TextStyle(color: Colors.grey),
              ))
        ],
        backgroundColor: Colors.white,
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: screenSize.width * 0.07,
              ),
              Container(
                margin: EdgeInsets.only(right: 25),
                width: screenSize.width * 0.24,
                height: 50,
                decoration: decoration(),
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text('Code',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600)),
                    ),
                    Text('+998',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15),
                decoration: decoration(),
                width: screenSize.width * 0.56,
                height: 50,
                child: TextFormField(
                  onSaved: (newValue) =>
                      (phoneController.text.length == 9) ? saveChanges : () {},
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                  keyboardType: TextInputType.phone,
                  onChanged: (value) => setState(() {}),
                  autofocus: true,
                  controller: phoneController,
                  cursorColor: firstColor,
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, color: Colors.transparent)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, color: Colors.transparent)),
                      labelText: 'Number',
                      labelStyle: TextStyle(color: Colors.grey)),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TextButton(
            style: buttonStyle(screenSize.width,
                (phoneController.text.length == 9) ? firstColor : Colors.grey),
            onPressed: (phoneController.text.length == 9) ? saveChanges : () {},
            child: isLoading
                ? Container(
                    height: 30,
                    width: 30,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text('Continue'),
          ),
        ],
      ),
    );
  }

  void saveChanges() {
    setState(() {
      isLoading = true;
    });
    verifyPhoneNumber();
  }

  void verifyPhoneNumber() async {
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+998${phoneController.text}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Info()));
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e);
        _showErrorSnackBar(e.message);
        setState(() {
          isLoading = false;
        });
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
          isLoading = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SmsVerify(
              verificationId: _verificationId!,
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void _showErrorSnackBar(String? message) {
    if (message != null) {
      final snackBar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

class SmsVerify extends StatefulWidget {
  final String verificationId;

  const SmsVerify({super.key, required this.verificationId});

  @override
  State<SmsVerify> createState() => _SmsVerifyState();
}

class _SmsVerifyState extends State<SmsVerify> {
  TextEditingController smsCodeController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [Container()],
        title: Center(
            child: Text('Verify code',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w900))),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(right: 25),
              padding: EdgeInsets.only(left: 15, right: 10),
              decoration: decoration(),
              width: screenSize.width * 0.8,
              height: 60,
              child: TextFormField(
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
                keyboardType: TextInputType.phone,
                onChanged: (value) => setState(() {}),
                autofocus: true,
                onSaved: (newValue) =>
                    (smsCodeController.text.length == 6) ? saveChanges : () {},
                controller: smsCodeController,
                cursorColor: firstColor,
                decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, color: Colors.transparent)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, color: Colors.transparent)),
                    labelText: 'SMS Code',
                    labelStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              style: buttonStyle(
                  screenSize.width,
                  (smsCodeController.text.length == 6)
                      ? firstColor
                      : Colors.grey),
              onPressed:
                  (smsCodeController.text.length == 6) ? saveChanges : () {},
              child: isLoading
                  ? Container(
                      height: 30,
                      width: 30,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }

  void saveChanges() {
    setState(() {
      isLoading = true;
    });
    signInWithPhoneNumber();
  }

  void signInWithPhoneNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: smsCodeController.text,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (contex) => const Info()));
    } on FirebaseAuthException catch (e) {
      _showErrorSnackBar(e.message);
    }
    setState(() {
      isLoading = false;
    });
  }

  void _showErrorSnackBar(String? message) {
    if (message != null) {
      final snackBar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
