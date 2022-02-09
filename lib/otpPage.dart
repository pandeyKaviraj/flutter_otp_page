import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/rendering.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomPinField extends StatefulWidget {
  const CustomPinField({Key? key}) : super(key: key);

  @override
  _CustomPinFieldState createState() => _CustomPinFieldState();
}

class _CustomPinFieldState extends State<CustomPinField> {
  int start = 45;
  String numStr = '';
  String currentText = '';
  bool hasError = false;
  bool isButtonActive = false;
  int pinLength = 4;
  bool colorChange = false;
  bool timerChecker = true;
  late TextEditingController controller;

  //TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
    startTimer();
    controller.addListener(() {
      final isButtonActive = (controller.text.length >= pinLength);
      setState(() {
        this.isButtonActive = isButtonActive;
        colorChange = true;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 25, top: 20),
                    //width: 24,
                    // height: 24,
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 24,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: 20, left: 25),
                    child: AutoSizeText(
                      'Phone verificaton',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 26,
                        color: Color(0xff2b2b2b),
                        letterSpacing: 0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 33),
                width: 155,
                height: 150,
                child: Image.asset(
                  'images/group1.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(
                  top: 39,
                ),
                height: 20,
                width: MediaQuery.of(context).size.width,
                child: AutoSizeText(
                  'Enter the 4 digit code sent to',
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              Container(
                height: 30,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText.rich(
                      TextSpan(
                        text: '+91-9999999999',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.blue,
                          fontFamily: 'Poppins',
                        ),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {}, //action for mob no
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit,
                        color: Colors.blue,
                        size: 14,
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                  ],
                ),
              ),

              //Pin code field column section 4
              Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.5 * 0.15,
                child: PinCodeTextField(
                  // showCursor: true,
                  // cursorColor: Colors.black,
                  // cursorWidth: 1,
                  appContext: context,
                  controller: controller,
                  //autoFocus: true,
                  length: 4,
                  obscureText: false,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  scrollPadding: EdgeInsets.only(),
                  textStyle: TextStyle(
                    fontSize: 26.0,
                  ),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(6),
                    activeColor: Color(0XFF1353CB),
                    selectedFillColor: Color(0XFF1353CB),
                    selectedColor: Color(0XFF1353CB),
                    //activeFillColor: Color.fromRGBO(19, 83, 203, 1),
                    borderWidth: 1,
                    errorBorderColor: Colors.redAccent,
                    inactiveColor: Color(0XFF1353CB),
                    fieldHeight:
                        MediaQuery.of(context).size.height * 0.5 * 0.15,
                    fieldWidth: 60,
                  ),
                  //animationDuration: Duration(milliseconds: 300),
                  //enableActiveFill: true,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    //This field will show when user enters right pin
                    if (value.length != 4 || value == '1234' || value == null) {
                      setState(() {
                        hasError = true;
                      });
                    } else {
                      setState(() {
                        hasError = false;
                      });
                    }
                  },
                  onCompleted: (v) {
                    print("Succesful");
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? "Incorrect verification code" : "",
                  style: TextStyle(
                    color: Color(0xffff0000),
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(top: 109),
                child: timerChecker
                    ? RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Resend Code in ',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.normal,
                                  color: Color(0XFF2B2B2B)),
                            ),
                            TextSpan(
                              text: '$start',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: Color(0XFF2B2B2B)),
                            ),
                            TextSpan(
                              text: ' seconds',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: Color(0XFF2B2B2B)),
                            ),
                          ],
                        ),
                      )
                    : RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Didn't receive the OTP? ",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.normal,
                                  color: Color(0XFF2B2B2B)),
                            ),
                            TextSpan(
                              text: 'RESEND',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.blue,
                                fontFamily: 'Poppins',
                              ),
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    timerChecker = true;
                                    start = 45;
                                    startTimer();
                                  });
                                }, //action for mob no
                            ),
                          ],
                        ),
                      ),
              ),

              Container(
                height: 60,
                width: 284,
                margin: EdgeInsets.only(top: 48),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    onSurface:
                        colorChange ? Color(0xff1353cb) : Color(0xffb1b1b1),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                    ),
                  ),
                  child: AutoSizeText(
                    'CONTINUE  >',
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      letterSpacing: -0.4,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    minFontSize: 8,
                    maxLines: 1,
                  ),
                  onPressed: isButtonActive
                      ? () {
                          // If section code to check otp entered is right or wrong
                          if (hasError == false) {
                            print('Right code validation working');
                          }
                          setState(() {
                            isButtonActive = true;
                            controller.clear();
                          });
                        }
                      : null,
                  // conditions for validating
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Timer
  void startTimer() {
    const onSec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onSec, (timer) {
      if (start == 0) {
        setState(() {
          timerChecker = false;
        });
        timer.cancel();
      } else {
        setState(() {
          start--;
        });
      }
    });
  }
}
