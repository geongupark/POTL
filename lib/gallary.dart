import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.place, color: Colors.black),
                  Text(
                    "부산광역시",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  SizedBox(height: 15),
                  body: Padding(
        padding: const EdgeInsets.all(8.0),
        // implement GridView.builder
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: myProducts.length,
            itemBuilder: (BuildContext ctx, index) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(15)),
                child: Text(myProducts[index]["name"]),
              );
            }),
      ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


