import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Farmers extends StatelessWidget {
  List farmers = [];
  Farmers({required this.farmers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text('Sharda')),
        body: Container(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: farmers.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 4.0),
                        child: Card(
                          child: ListTile(
                            onTap: () {},
                            title: Text(farmers[index]),
                            trailing: Icon(Icons.more_vert),
                          ),
                        ),
                      );
                    }))));
  }
}
