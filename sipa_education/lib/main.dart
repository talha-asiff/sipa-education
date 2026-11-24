import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sipa education',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 243, 13, 116)),
      ),
      home: const MyHomePage(title: 'Sipa education | Dashboard'),
    );
  }
}


class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Image.asset("images/sipa-monogram-wine.png", width: 100, height: 100,)),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(50),
            child: Text(
              "Sipa education Dashboard",
              style: TextStyle(
                fontSize: 70,
                fontFamily: 'curvy'
                //color: const Color.fromARGB(133, 244, 67, 54),
              )
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 500,
                    height: 250,
                    color: const Color.fromARGB(255, 250, 172, 206),
                    child: Padding(padding: EdgeInsetsGeometry.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Biology Crash Course")
                      ],),
                    ),
                  ),
                ),
                
              ],
            ),
          )
        ],
      ),
    );
  }
}