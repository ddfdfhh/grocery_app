import 'package:citymall/screens/order_accepted_screen.dart';
import 'package:flutter/material.dart';

Widget OrderFailedDialogue(BuildContext context){
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: 25,
    ),
    height: 600.0,
    width: double.maxFinite,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
        Spacer(
          flex: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 45,
          ),
          child: Image(
              image: AssetImage("assets/images/order_failed_image.png")),
        ),
        Spacer(
          flex: 5,
        ),
        Text( "Oops! Order Failed",

        ),
        Spacer(
          flex: 2,
        ),
  ElevatedButton(
    child:const Text("Something Went wrong"),
    onPressed: () {
      // Navigator.pop(context);
    },
  ),
        Spacer(
          flex: 8,
        ),
        ElevatedButton(
          child:const Text("Please Try Again"),

          onPressed: () {
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (BuildContext context) {
                return OrderAcceptedScreen();
              },
            ));
          },
        ),
        Spacer(
          flex: 4,
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text("Back to home"),
        ),
        Spacer(
          flex: 4,
        ),
      ],
    ),
  );
}