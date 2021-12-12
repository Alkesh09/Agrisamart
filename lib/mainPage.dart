
import 'package:agrismart/Retailer/Retailer.dart';
import 'package:agrismart/authService.dart';
import 'package:agrismart/phoneAuthPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget currentPage = phoneAuthPage();
  AuthClass authClass = AuthClass();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  void checkLogin() async{
    String? token = await authClass.getToken();
    if(token != null){
      setState(() {
        currentPage = RetailerPage();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "AGRISMART",
          textAlign: TextAlign.justify,
        ),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 20),
              child: Icon(
                Icons.account_circle,
                color: Colors.green,
                size: 175.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: const Text.rich(
                TextSpan(
                  // default text style
                  children: <TextSpan>[
                    TextSpan(
                        text: ' LOGIN ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            color: Colors.green)),
                    TextSpan(
                        text: 'AS A',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            color: Colors.black)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 250, //width of button
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green, //border width and color
                      elevation: 3, //elevation of button
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding:
                      EdgeInsets.all(20) //content padding inside button
                  ),
                  child: Text(
                    'FARMER',
                    style: TextStyle(fontSize: 25.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => currentPage));
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40, left: 36, right: 36, bottom:20 ),
              child: SizedBox(
                width: 250,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green, //background color of button
                      elevation: 3, //elevation of button
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding:
                      EdgeInsets.all(20) //content padding inside button
                  ),
                  child: Text(
                    'RETAILER',
                    style: TextStyle(fontSize: 25.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => currentPage));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
