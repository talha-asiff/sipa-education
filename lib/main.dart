import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CIPA International',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4146CF)),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Row(children: [
            Icon(Icons.school_outlined, color: Colors.blue, size: 40,),
            Text(" CIPA International")
          ],),
          actions: [
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Home"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Courses"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Catalog"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Billing & Pricing"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Profile"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Settings"),
            ),
          ],
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment : CrossAxisAlignment.start,
                children: [
                  Text("Continue your", style: TextStyle(
                color: Colors.black, fontSize: 40
              ),),
              Text("Ultimate Biology Course", style: TextStyle(
                color: Colors.blue, fontSize: 60, fontWeight: FontWeight.bold
              ),),
                ],
              )
            ),
          //  ListView(
          //       scrollDirection: Axis.horizontal,
          //       children: [
          //         Container(
          //           width: 200,
          //           height: 100,
          //           decoration: BoxDecoration(
          //             color: Colors.blue,
          //           ),
          //         )
          //       ],
          //     ),
          ],
        ),
      ),
    );
  }
}
