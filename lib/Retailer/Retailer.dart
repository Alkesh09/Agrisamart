import 'package:agrismart/Retailer/addproduct.dart';
import 'package:agrismart/Retailer/communitychat.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RetailerPage extends StatefulWidget {
  const RetailerPage({Key? key}) : super(key: key);

  @override
  State<RetailerPage> createState() => _RetailerPage();
}

/// This is the private State class that goes with MyStatefulWidget.
class _RetailerPage extends State<RetailerPage> {
  CollectionReference retailer = FirebaseFirestore.instance
      .collection('retailer')
      .doc("1")
      .collection('products');
  final Stream<QuerySnapshot> _retailerStream = FirebaseFirestore.instance
      .collection('retailer')
      .doc("1")
      .collection('products')
      .snapshots();
  final Stream<QuerySnapshot> _communities =
      FirebaseFirestore.instance.collection('communities').snapshots();
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blueGrey);
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 30));
  List<Widget> _widgetOptions = <Widget>[];

  initState() {
    super.initState();
    this._widgetOptions.add(
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Farmer Communities", style: optionStyle),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _communities,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  return Expanded(
                      child: ListView(
                    shrinkWrap: true,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      String name = document.id;
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      print(data['farmers']);
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 4.0),
                          child: Card(
                              child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Chat(farmers: data['farmers'])));
                            },
                            title: Text(name),
                            leading: CircleAvatar(
                              backgroundImage: AssetImage('assets/$name.jpg'),
                            ),
                            subtitle: Text(data['location']),
                            trailing: IconButton(
                              icon: const Icon(Icons.more_vert),
                              tooltip: 'View Profile',
                              onPressed: () {
                                _showMyDialog(context, name);
                              },
                            ),
                            isThreeLine: true,
                          )));
                    }).toList(),
                  ));
                },
              ),
            ],
          ),
        );

    this._widgetOptions.add(Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: style,
                child: Text("Add Product"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddProduct()));
                },
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _retailerStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                return Expanded(
                    child: ListView(
                  shrinkWrap: true,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    String id = document.id;
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 4.0),
                        child: Card(
                            child: ListTile(
                          title: Text(data['name']),
                          leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/${data['name']}.jpg')),
                          trailing: IconButton(
                            icon: const Icon(Icons.more_vert),
                            tooltip: 'Delete Product',
                            onPressed: () {
                              _showMyDialog(context, id);
                            },
                          ),
                          subtitle: Text('Price : Rs.${data['price']}/quintal'),
                          isThreeLine: true,
                        )));
                  }).toList(),
                ));
              },
            ),
          ],
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Retailer'),
      ),
      body: Center(child: _widgetOptions[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Communities',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.production_quantity_limits),
            label: 'Products',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext context, String index) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Product will be deleted'),
          content: const Text('Confirm to delete'),
          actions: <Widget>[
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                retailer
                    .doc(index)
                    .delete()
                    .then((value) => print("User Deleted"))
                    .catchError(
                        (error) => print("Failed to delete user: $error"));
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
