import 'dart:async';
import 'package:agrismart/authService.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class phoneAuthPage extends StatefulWidget {
  const phoneAuthPage({Key? key}) : super(key: key);

  @override
  _phoneAuthPageState createState() => _phoneAuthPageState();
}

class _phoneAuthPageState extends State<phoneAuthPage> {
  int start = 30;
  bool wait = false;
  String buttonName = "Send";
  TextEditingController phoneController = TextEditingController();
  AuthClass authClass = AuthClass();
  String verificationIdFinal = "";
  String smsCode = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff346107),
      appBar: AppBar(
        backgroundColor: Color(0xff346107),
        title: Text(
          "SIGN IN",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ),
              textField(),
              SizedBox(height: 20,),
              Container(
                width: MediaQuery.of(context).size.width - 30,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                    Text("Enter 6 digit OTP", style: TextStyle( fontSize: 19, color: Colors.white),),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              otpField(),
              SizedBox(height: 40,),
              RichText(text: TextSpan(
                children: [
                    TextSpan(
                    text: "send OTP again in",
                    style: TextStyle( fontSize: 19, color: Colors.white),
                    ),
                    TextSpan(
                    text: "00:$start",
                    style: TextStyle( fontSize: 19, color: Colors.red),
                    ),
                    TextSpan(
                    text: "sec",
                    style: TextStyle( fontSize: 19, color: Colors.white),
                    ),
                  ]
              ),

              ),
              SizedBox(height: 170,),
              InkWell(
                onTap: () {
                  authClass.signInwithPhoneNumber(
                      verificationIdFinal, smsCode, context);
                },
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width - 60,
                  decoration: BoxDecoration(
                      color: Color(0xff4ed527),
                      borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                        "Let's Go",
                       style: TextStyle(
                           fontSize: 19,
                           color: Color(0xfffbe2ae),
                         fontWeight: FontWeight.w700,
                       ),
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  void startTimer(){
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if( start==0){
        setState(() {
          timer.cancel();
          wait = false;
        });
      }else{
        setState(() {
          start--;
        });
      }
    });
  }

  Widget otpField(){
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width - 30,
      fieldWidth: 50,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: Color(0xffa0db5d),
        borderColor: Colors.white,
      ),

      style: TextStyle(
          fontSize: 17,
        color: Colors.black,
      ),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        print("Completed: " + pin);
        setState(() {
          smsCode = pin;
        });
      },
    );

  }
  
  Widget textField(){
    return Container(
      width: MediaQuery.of(context).size.width -40,
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xffa0db5d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: phoneController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Enter your phone number",
          hintStyle:  TextStyle(color: Colors.black, fontSize: 16),
          contentPadding: const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 15),
            child: Text("(+91)", style: TextStyle(color: Colors.black, fontSize: 16 ,),
        ),
          ),
          suffixIcon: InkWell(
            onTap: wait?null:() async{
              setState(() {
                start = 30;
                wait = true;
                buttonName = "Resend";
              });
              await authClass.verifyPhoneNumber(
                  "+91 ${phoneController.text}", context, setData);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Text(
                buttonName,
                style: TextStyle(
                    color: wait?Colors.grey:Colors.black,
                    fontSize: 18 ,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),

      ),
      ),
    );
  }

  void setData(String verificationId) {
    setState(() {
      verificationIdFinal = verificationId;
    });
    startTimer();
  }
  
}


