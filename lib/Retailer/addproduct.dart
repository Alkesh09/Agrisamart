import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
/* import 'package:path_provider/path_provider.dart'; */

class AddProduct extends StatefulWidget {
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  Map<String, dynamic> product = {
    "name": "",
    "price": "",
    "quantity": "",
    "url": ""
  };
  CollectionReference retailer = FirebaseFirestore.instance
      .collection('retailer')
      .doc("1")
      .collection('products');
  Future<void> addProduct() {
    // Call the user's CollectionReference to add a new user

    return retailer
        .add(product)
        .then((value) => print("Added"))
        .catchError((error) => print("Failed to add product: $error"));
  }

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    /* final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 30)); */
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Product'),
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
          child: Form(
              child: Column(
            children: <Widget>[
              Center(
                child: Stack(children: <Widget>[
                  /*  _imageFile != null
                      ? ClipOval(
                          child: Image.file(File(_imageFile!.path),
                              width: 160, height: 160, fit: BoxFit.cover))
                      : Container(), */
                  CircleAvatar(
                      radius: 80.0,
                      backgroundImage: _imageFile == null
                          ? AssetImage("assets/tomato.jpg")
                          : FileImage(_imageFile!) as ImageProvider),
                  Positioned(
                    bottom: 20.0,
                    right: 20.0,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: ((builder) {
                            return (Container(
                              height: 100.0,
                              // width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Choose Product photo",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        TextButton.icon(
                                          icon: Icon(Icons.camera),
                                          onPressed: () {
                                            takePhoto(ImageSource.camera);
                                          },
                                          label: Text("Camera"),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        TextButton.icon(
                                          icon: Icon(Icons.image),
                                          onPressed: () {
                                            takePhoto(ImageSource.gallery);
                                          },
                                          label: Text("Gallery"),
                                        ),
                                      ])
                                ],
                              ),
                            ));
                          }),
                        );
                      },
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.teal,
                        size: 28.0,
                      ),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  onChanged: (value) {
                    product['name'] = value;
                  },
                  decoration: InputDecoration(
                      labelText: "Name",
                      hintText: "Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  /* on: (value) {
                    product['quantity'] = value;
                  }, */
                  decoration: InputDecoration(
                      labelText: "Quantity",
                      hintText: "Quantity",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    onChanged: (value) {
                      product['price'] = value;
                    },
                    decoration: InputDecoration(
                        labelText: "Price",
                        hintText: "Price",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ))
            ],
          )),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.done),
            onPressed: () {
              /* Directory appDocDir = await getApplicationDocumentsDirectory();
              String appDocpath = appDocDir.path;
              final File localimage = await _imageFile!
                  .copy('$appDocpath/assets/${product['name']}.jpg');
              print("success");
              product['url'] = localimage.path;
              print(localimage.path); */
              addProduct();
              Navigator.pop(context);
            }));
  }
}
