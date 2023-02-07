

import 'package:demo_login/feature/auth/login/widget/password.dart';
import 'package:demo_login/feature/auth/login/widget/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/res/colors.dart';
import '../../../../core/res/dimens.dart';
import '../../../../core/res/fonts.dart';
import '../../../../core/res/strings.dart';
import '../../../forgotPassword/forgot_password.dart';
import '../../../homepage/homepage.dart';
import '../bloc/auth_bloc.dart';
import 'email.dart';


class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late GoogleSignInAccount _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  late final AuthBloc? _authBloc;
  TextEditingController email = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  TextEditingController password = TextEditingController();
  FocusNode pwdFocusNode = FocusNode();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  void initState(){
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
  }
  void clearText() {
    email.clear();
    password.clear();

  }
  void initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult =
        await facebookLogin.logIn(customPermissions: ['email']);
     switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error");
        break;
      case FacebookLoginStatus.cancel:
        print("CancelledByUser");
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return const HomePage();
        }));
        break;
      case FacebookLoginStatus.success:
        print("LoggedIn");
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return const HomePage();
        }));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    onLoginButtonPressed() {
      _authBloc!.add(LoginEvent(email:email.text,password:password.text),
      );
    }

    return BlocListener<AuthBloc,AuthState>(
    listener: (context, state) {

      if(state is AuthLoading){
         Center(child:CircularProgressIndicator(color:blue),);
      }
      else if(state is AuthSuccessful){
        clearText();
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return const HomePage();
        }));
      }
      else if(state is AuthError){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:  const Text(error),
          backgroundColor: Colors.red.shade300,
        )
        );
      }

        },
      child: Scaffold(
        backgroundColor: Colors.cyan.withOpacity(0.93),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.white,Colors.white],
                        end: Alignment.bottomCenter,
                        begin: Alignment.topCenter),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100))),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        bottom: alertPaddingTop,
                        right: alertPaddingTop,
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => SignupView()));
                            },
                            child: const Text(
                              signUp,
                              style: TextStyle(color:Colors.blue,fontSize: fSize16,fontFamily: readexProRegular,fontWeight: FontWeight.w700),
                            )
                        )
                    ),

                    Center(
                      child: Image.asset("assets/images/optisolLogo.png"),
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: initialPaddingValue,right:initialPaddingValue),
                    child: Padding(
                      padding: EdgeInsets.only(left:size35,right:padding20,top:padding20,bottom:padding20),
                      child: SizedBox(
                          height: 50,
                          child: Text(loginAccount,style:TextStyle(fontSize: fSize24,fontWeight:FontWeight.bold ))),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.only(
                          left: padding15, right: padding15,bottom:padding15),
                      child: EmailField(
                        userNameController: email,
                        hintText:emailText,
                        emailFocusNode: emailFocusNode,
                        pwdFocusNode: pwdFocusNode,
                      )),


                  Container(
                      padding: const EdgeInsets.only(
                          left: padding15, right: padding15,top:padding15),
                      child: PasswordField(
                        passwordController: password,
                        pwdFocusNode: pwdFocusNode,
                        nextFocusNode: null,
                        hintText: 'Password',
                      )),
                  Expanded(
                    flex: 0,
                    child: Container(
                      margin: const EdgeInsets.only(left: padding20, right: padding20,),
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                            },

                              child: Container(
                                margin: const EdgeInsets.only(top: padding10),
                                alignment: Alignment.centerRight,
                                child: const Text(
                                  forgotPassword,
                                ),
                              ),
                            ),
                          ] ),
                    ),
                  ),

                  const SizedBox(height:20.04),
                  Padding(
                    padding: EdgeInsets.only(left: padding25, right: padding25, top: padding15,),
                    child: Container(
                      height: MediaQuery.of(context).size.height/19,
                      width:MediaQuery.of(context).size.width/2,
                      decoration: BoxDecoration(
                          color: Colors.indigo, borderRadius: BorderRadius.circular(200)),

                      child: ElevatedButton(
                       onPressed: onLoginButtonPressed,

                        child: const Text(
                          logIn,
                          style: TextStyle(color: Colors.white, fontSize: fSize21),
                        ),
                      ),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(top:18.0,bottom:padding10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: 10,
                            padding: const EdgeInsets.fromLTRB(30, 0, 10, 0),
                            child: const Divider(
                              height: 1,
                              color: Colors.black,
                              thickness: 1,
                            ),
                          ),
                        ),
                        const Text(or, style: TextStyle(
                          color: Colors.black,
                        ),),
                        Expanded(
                          child: Container(
                            width: 40,
                            padding: const EdgeInsets.fromLTRB(10, 0, 30, 0),
                            child: Divider(
                              height: 1,
                              color: Colors.black,
                              thickness: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                        left: padding25, right: padding25, top: padding15, bottom: 0),
                    child: Container(
                      height: MediaQuery.of(context).size.height/19,
                      width:MediaQuery.of(context).size.width/1.29,

                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape:RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                        onPressed: () => {},
                        icon: const Padding(
                          padding: EdgeInsets.only(right:0.0,left:5),
                          child: Icon(Icons.send_rounded,),
                        ),
                        label: Padding(
                          padding: const EdgeInsets.only(left:padding10,right:padding30),
                          child:MaterialButton(
                              onPressed: () {
                            _googleSignIn.signIn().then((userData) {
                              print('userData');
                              print(userData);
                              setState(() {
                                _userObj = userData!;
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return const HomePage();
                                }));
                              });
                            }).catchError((e) {
                              print(e);
                            });
                          },
                          child: Text( google,style: TextStyle(color:Colors.black87),)),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                        left: padding25, right: padding25, top: padding15, bottom:50),
                    child: Container(
                      height: MediaQuery.of(context).size.height/19,
                      width:MediaQuery.of(context).size.width/1.29,

                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape:RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                        onPressed: () => {
                          initiateFacebookLogin(),

                        },
                        icon: Padding(
                          padding: const EdgeInsets.only(right:0.0,left:padding05),
                          child: Icon(Icons.facebook_rounded,),
                        ),
                        label: const Padding(
                          padding: EdgeInsets.only(right:padding15,left:horizontalPadding),
                          child: Text(facebook,style: TextStyle(color:Colors.black87),),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

        ),



      ),
    );
  }
}
