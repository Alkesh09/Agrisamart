
import 'package:agrismart/Retailer/Retailer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'HomePage.dart';



class AuthClass{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final storage = new FlutterSecureStorage();

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void storeTokenAndData(UserCredential userCredential) async {
    print("storing token and data");
    await storage.write(
        key: "token", value: userCredential.credential!.token.toString());
    await storage.write(
        key: "usercredential", value: userCredential.toString());
  }

  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

 Future<void> logout() async{
    try{
      await auth.signOut();
      await storage.delete(key: "token");
    }catch(e){}

 }


  Future<void> verifyPhoneNumber(String phoneNumber, BuildContext context, Function setData) async{
    PhoneVerificationCompleted verificationCompleted = (PhoneAuthCredential phoneAuthCredential)async{
      showSnackBar(context, "Verification Completed");
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception){
      showSnackBar(context, exception.toString());
    };

    PhoneCodeSent codeSent =
        (String verificationID, int? resendToken) {
      showSnackBar(context, "Verification Code sent on the phone number");
      setData(verificationID);
    };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationID){
      showSnackBar(context, "Time out");
    };
    try{
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    }catch(e){
      showSnackBar(context, e.toString());
    }
  }

  Future<void> signInwithPhoneNumber(
      String verificationId, String smsCode, BuildContext context)async{
      try{
        AuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);

        UserCredential userCredential =
        await auth.signInWithCredential(credential);
        storeTokenAndData(userCredential);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) =>RetailerPage()),
                (route) => false);

        showSnackBar(context, "logged In");
      }catch(e){
        showSnackBar(context, e.toString());
      }
  }
}
