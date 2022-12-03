import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'dart:convert';
import 'package:date_format/date_format.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    final _refValue = FirebaseDatabase.instance
        .ref().child("ProjectData/leituras").orderByChild("data").limitToLast(1);

    
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
                query: _refValue,
                itemBuilder: (context, snapshot, animation, index) {
                  final value = jsonEncode(snapshot.value);
                  final state = value.isEmpty;

                  final response = jsonDecode(value)['dadosProjeto'];
                  

                  return Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 80.0),
                      child: Column(
                        children: [
                          loadContainer(state, response),
                        ],
                      )
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

  loadContainer(state, value){

    final _date = formatDate(DateTime.fromMillisecondsSinceEpoch(int.parse(value['data'])*1000, isUtc: true), [dd, '/', mm, '/', yyyy]);
    
    return state ? Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Center(child: CircularProgressIndicator(),)
    ) :  
    Container(
      child: Column(
        children: [
        Container(
          child: Column(
            children: [
              Text("Status:", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              Text(double.parse(value['umidadeSolo']) < 35.00 ? "Falta d'água" : (double.parse(value['umidadeSolo']) > 34.00 && double.parse(value['umidadeSolo']) < 80.00) ? "Saudável" : "Excesso de água")
          ]),
        ),
        Container(
          margin:  const EdgeInsets.fromLTRB(0,40,0,40),
          child: Column(
          children: [
            Text('Tempreratura do ar : ', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
    
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.thermostat,
                  color: Color.fromARGB(255, 255, 0, 0),
                ),
                Text(value['temperatura']+'°',style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300,))
              ],
            ),
          ],
        ),
      ),

      Container(
        margin:  const EdgeInsets.fromLTRB(0,0,0,40),
        child: Column(
          children: [
            Text('Umidade do solo: ',  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.water_drop,
                  color: Color.fromARGB(255, 33, 181, 218),
                ),
                Text(value['umidadeSolo'], style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300)),
              ]
            ),
          ],
        ), 
      ),

      Container(
        child: 
        Column(
          children: [
            Text('Umidade do ar: ', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.water_drop,
                  color: Color.fromARGB(255, 33, 181, 218),
                ),
                Text(value['umidadeAr'], style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300))
              ],
            ),
          ],
        ),
      ),

      Container(
        margin:  const EdgeInsets.fromLTRB(0, 230,0,0),
        child:  Column(children: [
          Text("Data da ultima coleta: ",  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          Text(_date,  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300))
        ]),
      )
        
      ]),
    );

    

  }
}
