import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_app/view/home_page.dart';
import 'package:firebase_demo_app/view/mobileno_page.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String? otpCode;

  Future verifyOtp() async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationCode!, smsCode: otpCode!);
    print('$otpCode===================');
    await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        OTPTextField(
          length: 6,
          width: MediaQuery.of(context).size.width,
          fieldWidth: 50,
          style: const TextStyle(fontSize: 17),
          textFieldAlignment: MainAxisAlignment.spaceAround,
          fieldStyle: FieldStyle.underline,
          onCompleted: (pin) {
            setState(() {
              otpCode = pin;
            });
          },
        ),
        ElevatedButton(
            onPressed: () async {
              if (otpCode!.isNotEmpty) {
                verifyOtp().then(
                  (value) => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  ),
                );
              } else {
                return print('plz enter otp');
              }
            },
            child: Text("Verify"))
      ]),
    );
  }
}
