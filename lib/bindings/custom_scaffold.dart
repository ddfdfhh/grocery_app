import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ScaffoldWrapper extends StatelessWidget {
final AppBar? appBar;
final bool? p;
final Widget child;
final BottomNavigationBar? bottomNavigationBar;
  const ScaffoldWrapper({Key? key, required this.child,
    this.appBar,this.bottomNavigationBar,this.p

  }) :super(key: key);


  // final Stream s=InternetConnection().onStatusChange;

  @override
  Widget build(BuildContext context) {
    // final broadcast= s.asBroadcastStream(
    //   onCancel: (subscription) {
    //     subscription.pause();
    //   },
    //   onListen: (subscription) {
    //     subscription.resume();
    //   },
    // );
    return Scaffold(

      bottomNavigationBar: bottomNavigationBar,
        appBar: appBar,
        backgroundColor: Colors.white,
        body: SafeArea(
            child: StreamBuilder(
              // mention the data source to the stream
                stream: InternetConnection().onStatusChange,
                // context and snapshot is used to capture the data coming from stream
                builder: (context, AsyncSnapshot<InternetStatus> snapshot) {
                  print('got data');
                  print(snapshot.data);
                          if(snapshot.hasData) {
                            if (snapshot.data==InternetStatus.disconnected)
                              return Text('No intenet ');
                          }

                      return  FutureBuilder(
                              // mention the data source to the stream
                              future: InternetConnection().hasInternetAccess,
                              // context and snapshot is used to capture the data coming from stream
                              builder: (context, AsyncSnapshot<bool> snapshot) {

                                if (snapshot.hasData) {
                                  final status = snapshot.data as bool;
                                  return status
                                      ? child
                                      : Center(child:const Text('No intenet '));
                                } else
                                  return child;
                              });


                })));
  }
}
