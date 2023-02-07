import 'package:flutter/material.dart';
import '../../../../core/res/border_styles.dart';
import '../../../../core/res/index.dart';
import '../../../../core/utils/function.dart';
import '../../../../core/utils/styles.dart';

// ignore: must_be_immutable
class EmailField extends StatelessWidget {
  EmailField({
    Key? key,
    required this.userNameController,required this.emailFocusNode, this.pwdFocusNode,  this.isAutoFocus = false, required this.hintText
  }) : super(key: key);

  final TextEditingController userNameController;
  FocusNode emailFocusNode = FocusNode();
  FocusNode? pwdFocusNode = FocusNode();
  final bool isAutoFocus;

  final String hintText;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: isAutoFocus,
      controller: userNameController,
      maxLength: 50,
      keyboardType: TextInputType.emailAddress,
      style: inputTextStyle,
      decoration: InputDecoration(
        counterText: "",
        contentPadding: const EdgeInsets.only(left: padding05, top: padding15, bottom: padding15),
        prefix: const Padding(padding: EdgeInsets.only(left: padding20)),
        isDense: true,
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        hintStyle: hintStyle,
        enabledBorder: enabledFieldBorder,
        focusedBorder: focusedFieldBorder,
        errorBorder: errorFieldBorder,
        focusedErrorBorder: errorFieldBorder,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator:(v)=> validateEmail(v,context),
      focusNode: emailFocusNode,
      onFieldSubmitted: (text){
        var focusNode = validateEmail(text,context);
        if(focusNode == null){
          FocusScope.of(context).requestFocus(pwdFocusNode);
        }else{
          FocusScope.of(context).requestFocus(emailFocusNode);
        }
      },
    );
  }
}
