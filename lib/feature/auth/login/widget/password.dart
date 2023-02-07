
import 'package:demo_login/core/res/dimens.dart';
import 'package:flutter/material.dart';
import '../../../../core/res/border_styles.dart';
import '../../../../core/res/images.dart';
import '../../../../core/res/strings.dart';
import '../../../../core/utils/function.dart';
import '../../../../core/utils/styles.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    Key? key,
    required this.passwordController, required this.pwdFocusNode,  this.nextFocusNode,  required this.hintText,  this.isAutoFocus = false, this.validator = validatePwd
  }) : super(key: key);

  final TextEditingController passwordController;
  final FocusNode pwdFocusNode;
  final FocusNode? nextFocusNode;
  final String hintText;
  final bool isAutoFocus;
  final dynamic validator;


  @override
  Widget build(BuildContext context) {
    final obscure = ValueNotifier<bool>(true);
    // This widget is used for to show/hide the entered password
    return ValueListenableBuilder(
      valueListenable: obscure,
      builder: (context, _, __) => TextFormField(
        autofocus: isAutoFocus,
        style: inputTextStyle,
        controller: passwordController,
        obscureText: obscure.value,
        decoration: pwdFieldDecoration(hintText,obscure),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator:(v)=> validator(v,context),
        focusNode: pwdFocusNode,
        onFieldSubmitted: (text){
          var focusNode = validator(text,context);
          if(focusNode == null){
            FocusScope.of(context).requestFocus(nextFocusNode);
          }else{
            FocusScope.of(context).requestFocus(pwdFocusNode);
          }
        },
      ),
    );
  }
}

pwdFieldDecoration(String? hintText, ValueNotifier<bool> obscure){
  return InputDecoration(
    errorMaxLines: 4,
    isDense: true,
    hintText: hintText,
    contentPadding: const EdgeInsets.only(left: padding05,top: padding15,bottom: padding15),
    prefix: const Padding(padding: EdgeInsets.only(left: padding20)),
    hintStyle: hintStyle,
    filled: true,
    fillColor: Colors.white,
    enabledBorder: enabledFieldBorder,
    // focusedBorder: focusedFieldBorder,
    errorBorder: errorFieldBorder,
    focusedErrorBorder: errorFieldBorder,
    suffixIcon: IconButton(
      key: const Key(obscureKey),
      color: Colors.black,
      onPressed:  () {
        obscure.value = !obscure.value;
      },
      icon: obscure.value
          ? pwdHide
          : pwdShow,
    ),
  );
}
