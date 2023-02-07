import 'package:flutter/material.dart';

import '../../core/res/dimens.dart';
import '../../core/res/strings.dart';
import '../auth/login/widget/email.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailTxtEdtController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode pwdFocusNode = FocusNode();
  TextEditingController pwdTxtEdtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 0,
        centerTitle: true,
        title: Text(forgot,style:TextStyle(fontSize:fSize24,fontWeight: FontWeight.bold,color: Colors.black)),
      ),

      body:Container(
        width:MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.cyan,


        ),
        child: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                      child: Text(reset,
                          style: TextStyle(
                              fontSize: 60.0, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                      child: Text(password,
                          style: TextStyle(
                              fontSize: 60.0, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(285.0, 175.0, 0.0, 0.0),
                      child: Text('?',
                          style: TextStyle(
                              fontSize: 60.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue)),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      yourAccount,
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          top:padding20),
                      child: EmailField(
                        userNameController: emailTxtEdtController,
                        hintText:emailText,
                        emailFocusNode: emailFocusNode,
                        pwdFocusNode: pwdFocusNode,
                      ),
                    ),

                    SizedBox(height: 30.0),
                    Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.blueAccent,
                        color: Colors.blue,
                        elevation: 7.0,
                        child: GestureDetector(
                            onTap: () {},
                            child: Center(
                                child: Text(
                                  resetPassword,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, color: Colors.white),
                                ))),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  // InkWell(
                  //   onTap: () {
                  //        Navigator.push(
                  //         context,
                  //         new MaterialPageRoute(
                  //           builder: (BuildContext context) =>
                  //               new ResetPasswordMobilePage(title: 'Reset Password : Mobile'),
                  //         ));
                  //   },
                  //   child: Text('Try another way ?',
                  //       style: TextStyle(
                  //           color: Colors.blue,
                  //           fontWeight: FontWeight.bold,
                  //           decoration: TextDecoration.underline)),
                  // )
                ],
              )
            ],
          ),
        ),
      ),

    );
  }
}