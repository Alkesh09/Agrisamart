import 'package:flutter/material.dart';
import 'package:agrismart/Retailer/farmers.dart';

// ignore: must_be_immutable
class Chat extends StatefulWidget {
  List<dynamic> farmers = [];
  Chat({required this.farmers});
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 30));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Sharda'), actions: [
        IconButton(
          icon: Icon(Icons.group_rounded,
              color: Colors.black,
              size: 50.0,
              semanticLabel: 'Text to announce in accessibility modes'),
          tooltip: 'View Farmers',
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Farmers(farmers: widget.farmers)));
          },
        ),
        SizedBox(width: 20)
      ]),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
        child: Form(
          child: Column(children: <Widget>[
            ListView.builder(
                shrinkWrap: true,
                itemCount: widget.farmers.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text("Hii"),
                    ),
                  );
                }),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Post",
                    hintText: "Post",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            ElevatedButton(
                style: style,
                child: Text("Send"),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ]),
        ),
      ),
    );
  }
}
