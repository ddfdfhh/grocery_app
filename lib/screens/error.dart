import 'package:flutter/material.dart';


class ErrorPage extends StatelessWidget {
  String? error;
   ErrorPage({this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/router_offline.png',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          const Positioned(
            bottom: 230,
            left: 120,
            child: Text(
              'Router Offline',

            ),
          ),
           Positioned(
            bottom: 170,
            left: 70,
            child: Text(
             error.toString(),
             textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            bottom: 100,
            left: 130,
            right: 130,
            child: ElevatedButton(
             child:const Text("Go Back"),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}