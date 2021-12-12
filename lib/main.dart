import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'mainPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: RetailerLogin(),
    );
  }
}

class RetailerLogin extends StatefulWidget {
  @override
  State<RetailerLogin> createState() => _RetailerLoginState();
}

class _RetailerLoginState extends State<RetailerLogin> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
        body: Column(

          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 15),
              child: const Text.rich(
                TextSpan(
                  // default text style
                  children: <TextSpan>[
                    TextSpan(
                        text: 'AGRI',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            color: Colors.green)),
                    TextSpan(
                        text: 'SMART',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            color: Colors.green)),
                  ],
                ),
              ),
            ),
            Center(
              child: CarouselSlider(
                options: CarouselOptions(
                    height: 500.0, autoPlay: true, enlargeCenterPage: true),
                items: _source.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Image.network(i),
                      );
                    },
                  );
                }).toList(),
              ),
            ),

            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: SizedBox(
                width: 300, //width of button

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green, //border width and color
                      elevation: 3, //elevation of button
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(20) //content padding inside button
                  ),
                  child: Text(
                    'CONTINUE',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainPage()));
                  },
                ),
              ),
            ),
          ],
        ));

  }
}

final List _source = [
  'https://images.unsplash.com/photo-1505471768190-275e2ad7b3f9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80',
  'https://images.unsplash.com/photo-1568104559658-be6a9b475b0e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=375&q=80',
  'https://images.unsplash.com/photo-1596633607590-7156877ef734?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80',
  'https://images.unsplash.com/photo-1527525443983-6e60c75fff46?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=332&q=80',
];

