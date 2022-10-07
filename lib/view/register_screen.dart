import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_app/service/facebook_services.dart';
import 'package:firebase_demo_app/service/google_services.dart';
import 'package:firebase_demo_app/view/home_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../service/firebase_auth_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _obscureText = true;

  final picker = ImagePicker();
  File? image;

  void getImage() async {
    final file = await picker.getImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        image = File(file.path);
      });
    }
  }

  Future<String?> uploadUserImage() async {
    try {
      await FirebaseStorage.instance.ref(email.text).putFile(image!);
      final url =
          await FirebaseStorage.instance.ref(email.text).getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      print("ERROR===>>${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.black, shape: BoxShape.circle),
                  child: ClipOval(
                    child: image == null
                        ? Icon(
                            Icons.camera_alt_outlined,
                            size: 40,
                          )
                        : Image.file(image!, fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "email can not be empty";
                  }
                },
                controller: email,
                decoration: InputDecoration(
                  hintText: 'email',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                obscureText: _obscureText,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password can not be empty";
                  } else if (value.length < 6) {
                    return "password must be at lest 6 digit";
                  }
                },
                controller: password,
                decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      FirebaseAuthService.registerUser(
                              email: email.text.trim(),
                              password: password.text.trim())
                          .then((user) async {
                        if (user != null) {
                          final url = await uploadUserImage();
                          FirebaseFirestore.instance
                              .collection('notes')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .set({'email': email.text, 'image': url});
                        }
                      });
                    }
                  },
                  child: Text('Register')),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  signInWithGoogle().then(
                    (value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    ),
                  );
                },
                color: Colors.green,
                height: 50,
                minWidth: 300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/ggl.png', height: 30),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Continue with Google"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  FaceBookAuthServices.facebookLogin().then(
                    (value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    ),
                  );
                },
                color: Colors.green,
                height: 50,
                minWidth: 300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.facebook),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Continue with Facebook"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
