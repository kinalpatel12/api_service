import 'package:firebase_demo_app/view/mobileno_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: ListTile(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MobileNoPage(),
                ),
              );
            },
            leading: Text(
              'Log Out',
              textScaleFactor: 3,
              style: TextStyle(
                foreground: Paint()
                  ..shader = LinearGradient(
                    colors: [
                      Color(0xff02F993),
                      Color(0xff1132D9),
                    ],
                  ).createShader(
                    Rect.fromLTWH(140, 50, 200, 70),
                  ),
              ),
            ),
            trailing: Icon(
              Icons.logout,
              color: Colors.orange,
              size: 30,
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Text('Home Page', textScaleFactor: 3),
        ),
      ),
    );
  }
}
