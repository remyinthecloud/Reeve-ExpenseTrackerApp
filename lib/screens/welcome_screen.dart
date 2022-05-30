// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:budget_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      body: Container(

        width: double.infinity,
        height: MediaQuery.of(context).size.height,

        decoration: BoxDecoration(

          gradient: LinearGradient(
            colors: [
              Color(0xFF962F72),
              Color(0xFF6F4496),
            ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
          )

        ),

        child: Center(
          child: Stack(
            children: [
              Positioned(
                bottom: 400,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Image.asset('/Users/remycloud/Documents/CEN4360C/budget_tracker/assets/images/bitcoins.png', width: 130,),
                    Text('Reeve', style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),)
                  ],
                ),
              ),
            Positioned(
              bottom: 200,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.all(80.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => HomeScreen())
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 25.0,
                          spreadRadius: 1.0,

                        )
                      ]
                    ),
                    child: Text(
                      'Continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                  ),
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