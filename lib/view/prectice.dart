import 'package:flutter/material.dart';

// class OtpPage extends StatefulWidget {
//   @override
//   State<OtpPage> createState() => _OtpPageState();
// }

// class _OtpPageState extends State<OtpPage> {
//   final otpCode = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//
//   Future verifyOtp() async {
//     PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
//         verificationId: verificationCode!, smsCode: otpCode.text);
//     await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       body: Form(
//         key: _formKey,
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextFormField(
//                 maxLength: 6,
//                 keyboardType: TextInputType.phone,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return "Otp can not be empty";
//                   }
//                 },
//                 controller: otpCode,
//                 decoration: InputDecoration(
//                   hintText: "Enter Otp",
//                   counterText: "",
//                   filled: true,
//                   fillColor: Colors.white,
//                   border: InputBorder.none,
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(40),
//                     borderSide: BorderSide(
//                       color: Colors.blue,
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(40),
//                     borderSide: BorderSide(color: Colors.blue),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               ElevatedButton(
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       await verifyOtp()
//                           .then((value) => Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => HomePage(),
//                                 ),
//                               ));
//                     }
//                   },
//                   child: Text('Send otp'))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
