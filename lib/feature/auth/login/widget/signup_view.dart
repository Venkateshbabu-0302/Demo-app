

import 'package:demo_login/feature/auth/login/widget/password.dart';
import 'package:demo_login/feature/auth/login/widget/user_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

import '../../../../core/common/components/common_webview.dart';
import '../../../../core/res/border_styles.dart';
import '../../../../core/res/colors.dart';
import '../../../../core/res/dimens.dart';
import '../../../../core/res/fonts.dart';
import '../../../../core/res/strings.dart';
import '../../../../core/utils/styles.dart';
import '../../../homepage/homepage.dart';
import '../bloc/signupBloc/register_bloc.dart';
import 'checkbox.dart';
import 'email.dart';
import 'login_view.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late GoogleSignInAccount _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  late final RegisterBloc? _authBloc;
    var _selectedGender;

  TextEditingController emailTxtEdtController = TextEditingController();
  TextEditingController firstNameTxtEdtController = TextEditingController();
  TextEditingController lastNameTxtEdtController = TextEditingController();
  TextEditingController dateOfBirthTxtEdtController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode pwdFocusNode = FocusNode();
  TextEditingController dateinput = TextEditingController();

  TextEditingController pwdTxtEdtController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState(){
    dateinput.text = "";
    super.initState();
    _authBloc = BlocProvider.of<RegisterBloc>(context);
  }
  void clearText() {
    emailTxtEdtController.clear();
    pwdTxtEdtController.clear();
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

    onRegisterButtonPressed() {
      _authBloc!.add(SignUpEvent(email:emailTxtEdtController.text,password:pwdTxtEdtController.text),
      );
    }

    return BlocListener<RegisterBloc,RegisterState>(
        listener: (context, state) {
          if(state is RegisterLoading){
            Center(child:CircularProgressIndicator(color:blue),);
          }
          else if(state is RegisterSuccessful){
            clearText();
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return const HomePage();
            }));
          }
          else if(state is RegisterError){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:  Text(error),
              backgroundColor: Colors.red.shade300,
            )
            );
          }

        },
      child:Scaffold(
        backgroundColor: Colors.cyan.withOpacity(0.93),

        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [white,white],
                        end: Alignment.bottomCenter,
                        begin: Alignment.topCenter),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100))),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        bottom: padding20,
                        right: padding20,
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => LoginView()));
                            },
                            child: Text(
                              logInButton,
                              style: TextStyle(color:Colors.blue,fontSize:fSize16,fontFamily: readexProRegular,fontWeight: FontWeight.w700),
                            ))),
                    Center(
                      child: Image.asset("assets/images/optisolLogo.png"),
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: padding10,right:padding10),
                    child: Padding(
                      padding: EdgeInsets.only(left:padding35,right:padding20,top:padding20,bottom:padding20),
                      child: SizedBox(
                          height: size50,
                          child: Text(createAccount,style:TextStyle(fontSize: fSize24,fontWeight:FontWeight.bold ))),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.only(
                          left: padding15, right: padding15,bottom:padding15),
                      child: UsernameField(
                        userNameController: firstNameTxtEdtController,
                        hintText:firstName,
                        emailFocusNode: firstNameFocusNode,
                        pwdFocusNode: lastNameFocusNode,
                      )),
                  Container(
                      padding: const EdgeInsets.only(
                          left: padding15, right: padding15,bottom:padding15),
                      child: UsernameField(
                        userNameController: lastNameTxtEdtController,
                        hintText:lastName,
                        emailFocusNode: lastNameFocusNode,
                        pwdFocusNode: emailFocusNode,
                      )),
                  Container(
                    padding: const EdgeInsets.only(
                        left: padding15, right: padding15,bottom:padding15),
                      child:TextFormField(
                        controller: dateinput, //editing controller of this TextField
                        style: inputTextStyle,
                        readOnly: true,  //set it true, so that user will not able to edit text

                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.calendar_month_sharp,size:30),
                          counterText: "",
                          contentPadding: const EdgeInsets.only(left: padding05, top: padding15, bottom: padding15),
                          prefix: const Padding(padding: EdgeInsets.only(left: padding20)),
                          isDense: true,
                          hintText: dateOfBirth,
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: hintStyle,
                          enabledBorder: enabledFieldBorder,
                          focusedBorder: focusedFieldBorder,
                          errorBorder: errorFieldBorder,
                          focusedErrorBorder: errorFieldBorder,
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context, initialDate: DateTime.now(),
                              firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101)
                          );

                          if(pickedDate != null ){
                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                            //you can implement different kind of Date Format here according to your requirement

                            setState(() {
                              dateinput.text = formattedDate; //set output date to TextField value.
                            });
                          }else{
                            print("Date is not selected");
                          }
                        },
                      ),
                  ),


                  Container(
                      padding: const EdgeInsets.only(
                          left: padding15, right: padding15,bottom:padding15),
                      child: EmailField(
                        userNameController: emailTxtEdtController,
                        hintText:emailText,
                        emailFocusNode: emailFocusNode,
                        pwdFocusNode: pwdFocusNode,
                      )),


                  Container(
                      padding: const EdgeInsets.only(
                          left: padding15, right: padding15),
                      child: PasswordField(
                        passwordController: pwdTxtEdtController,
                        pwdFocusNode: pwdFocusNode,
                        nextFocusNode: null,
                        hintText: 'Password',
                      )),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: padding18, right: padding15,top:padding05),                 child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const Text(selectGender,
                          style: TextStyle(color: Colors.black, fontSize: fSize18),
                        ),
                        const SizedBox(width: 10),
                        Radio(
                          value: male,
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                        ),
                        Text(male,
                          style: TextStyle(color: Colors.black, fontSize: fSize18),
                        ),
                        SizedBox(width: 10),
                        Radio(
                          value: female,
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                        ),
                        Text(female,
                          style: TextStyle(color: Colors.black, fontSize: fSize18),
                        ),
                      ],
                    ),
                  ),


                  Padding(
                    padding: EdgeInsets.only(left: padding25, right: padding25, top: padding15, bottom: 0),
                    child: Container(
                      height: MediaQuery.of(context).size.height/19,
                      width:MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.indigo, borderRadius: BorderRadius.circular(200)),
                      child: ElevatedButton(
                        onPressed: onRegisterButtonPressed,

                        child: const Text(
                          signUpButton,
                          style: TextStyle(color: Colors.white, fontSize: fSize21),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children:  [
                        CheckBox(agree),
                        // Text('Terms & conditions')
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CommonWebView(
                                      url: "https://www.google.co.in/", title: "Privacy Policy"))
                          );
                          // Action to perform when the text is tapped
                        },
                        child: Text(
                          'Terms & conditions',
                          style: TextStyle(
                            fontSize: fSize15,
                            color: Colors.purple,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      ],
                    ),
                  ),





                  Padding(
                    padding: const EdgeInsets.only(top:padding18,bottom:padding10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: 10,
                            padding: const EdgeInsets.fromLTRB(padding30, 0, padding10, 0),
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
                            padding: const EdgeInsets.fromLTRB(padding10, 0, padding30, 0),
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
                        icon: Padding(
                          padding: const EdgeInsets.only(right:0.0,left:padding05),
                          child: Icon(Icons.send_rounded,),
                        ),
                        label: Padding(
                          padding: const EdgeInsets.only(left:padding10,right:padding30),
                          child: Text(signUpGoogle,style: TextStyle(color:Colors.black87),),
                        ),
                      ),
                    ),
                  ),



                  Padding(
                    padding: EdgeInsets.only(
                        left: padding25, right: padding25, top: padding15, bottom:padding50),
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
                        label: Padding(
                          padding: const EdgeInsets.only(right:padding15,left:horizontalPadding),
                          child: Text(signUpFacebook,style: TextStyle(color:Colors.black87),),
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