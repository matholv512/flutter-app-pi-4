// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_ignore, use_key_in_widget_constructors, library_private_types_in_public_api
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  // _DashboardState createState() => _DashboardState();
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Query dbRef = FirebaseDatabase.instance.ref().child('ProjectData');

  Widget listItem({required Map data}) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 100.0),
              child: Container(
                alignment: Alignment.topLeft,
                height: 100.0,
                color: Colors.green,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                        onPressed: () {}),
                    Text(
                      'Dashboard',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                        onPressed: () {})
                  ],
                ),
              ),
            ),
            body: Container(
              // color: Colors.green,
              height: double.infinity,
              width: double.infinity,
              // alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 100.0),
              // 68.0
              child: Column(children: [
                Text(
                  data['temperatura'],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                Text(
                  data['umidadeAr'],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                Text(
                  data['umidadeSolo'],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ]),
            ),
          ),
          Positioned(
            // ignore: sort_child_properties_last
            child: Container(
              child: Container(
                  // ignore: sort_child_properties_last
                  child: Image.asset(
                    'images/plant2.png',
                    width: 110,
                  ),
                  decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(60),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.green,
                        width: 2.5,
                      ))),
            ),
            left: (size.width / 2) - 55,
            top: 48,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      child: FirebaseAnimatedList(
        query: dbRef,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          Map data = snapshot.value as Map;
          data['key'] = snapshot.key;

          return listItem(data: data);
        },
      ),
    ));
  }
}
