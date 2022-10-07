import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_app/view/otp_page.dart';
import 'package:flutter/material.dart';

String? verificationCode;

class MobileNoPage extends StatefulWidget {
  const MobileNoPage({Key? key}) : super(key: key);

  @override
  _MobileNoPageState createState() => _MobileNoPageState();
}

class _MobileNoPageState extends State<MobileNoPage> {
  final mobail = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  CountryCode? countryCode;

  Future sendOtp() async {
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '$countryCode' + mobail.text,
        codeSent: (String verificationid, int? forceResendingToken) {
          setState(() {
            verificationCode = verificationid;
          });
        },
        verificationFailed: (FirebaseAuthException error) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("ERROR===>>${error.message}")));
        },
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
          print("Completed=====>>");
          print("*****************");
        },
        codeAutoRetrievalTimeout: (String verificationid) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.orange,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CountryCodePicker(
                      onChanged: (value) {
                        setState(() {
                          countryCode = value;
                        });
                      },
                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                      initialSelection: 'IT',
                      favorite: ['${countryCode}', 'FR'],
                      // optional. Shows only country name and flag
                      showCountryOnly: false,
                      // optional. Shows only country name and flag when popup is closed.
                      showOnlyCountryWhenClosed: false,
                      // optional. aligns the flag and the Text left
                      alignLeft: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: VerticalDivider(
                        color: Colors.orange,
                        thickness: 2,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "mobile can not be empty";
                          }
                        },
                        controller: mobail,
                        decoration: InputDecoration(
                            hintText: 'Mobile No', border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      sendOtp().then(
                        (value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtpPage(),
                          ),
                        ),
                      );
                    }
                  },
                  child: Text("Send OTP"))
            ],
          ),
        ),
      ),
    );
  }
}
