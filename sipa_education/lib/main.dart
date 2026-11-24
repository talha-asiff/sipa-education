import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'logic.dart';

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
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 243, 13, 116),
        ),
      ),
      home: const MyHomePage(title: 'Sipa education | Dashboard'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _courseScrollController = ScrollController();

  @override
  void dispose() {
    _courseScrollController.dispose();
    super.dispose();
  }

  void _scrollCourses(double direction) {
    if (!_courseScrollController.hasClients) return;

    final position = _courseScrollController.position;
    final targetOffset = (position.pixels + direction * 516)
        .clamp(position.minScrollExtent, position.maxScrollExtent)
        .toDouble();

    _courseScrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "images/sipa-monogram-wine.png",
          width: 100,
          height: 100,
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(50),
            child: Text(
              "Sipa education Dashboard",
              style: TextStyle(
                fontSize: 70,
                fontFamily: 'curvy',
                //color: const Color.fromARGB(133, 244, 67, 54),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ListView.builder(
                  controller: _courseScrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 56),
                  scrollDirection: Axis.horizontal,
                  itemCount: courseList.length,
                  itemBuilder: (context, index) {
                    final course = courseList.values.elementAt(index);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 500,
                        height: 250,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 237, 200, 212),
                              Color.fromARGB(255, 240, 197, 212),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                course.icon,
                                color: const Color.fromARGB(255, 120, 1, 71),
                                size: 50,
                              ),
                              Text(
                                course.title,
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Color.fromARGB(255, 120, 1, 71),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  left: 8,
                  child: IconButton.filled(
                    tooltip: 'Scroll courses left',
                    onPressed: () => _scrollCourses(-1),
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
                Positioned(
                  right: 8,
                  child: IconButton.filled(
                    tooltip: 'Scroll courses right',
                    onPressed: () => _scrollCourses(1),
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
