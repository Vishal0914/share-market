import 'dart:async';
import 'package:flutter/material.dart';
import 'login/login_page.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState(){
    super.initState();
    Timer(Duration(seconds: 3), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset("assets/icons/stock.png",height: 100,width: 100)
          ),
          SizedBox(height: 15,),
          Text("Share Market",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23),)

        ],
      ),
    );
  }
}
