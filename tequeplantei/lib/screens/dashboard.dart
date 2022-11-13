import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ref = FirebaseDatabase.instance
        .ref()
        .child("ProjectData");
    
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
                      'TéquePlantei',
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
            body: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  return Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 80.0),
                      child: ListTile(
                        title: Text(
                          snapshot.value.toString().replaceAll("umidadeSolo", "Umidade do Solo").replaceAll("umidadeAr", "Umidade do Ar").replaceAll("temperatura", "Temperatura").replaceAll("{", "").replaceAll("}", "").replaceAll("dadosProjeto", "").replaceAll(":", "").replaceAll("data", ""),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  );
                }),



            

          ),
          Positioned(
            child: Container(
              child: Container(
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
}
