
import 'package:flutter/material.dart';
import 'colors.dart';
import 'dimens.dart';
import 'fonts.dart';





TextStyle hintStyle = const TextStyle(
    color: blueAccent,fontFamily:readexProRegular,
);

OutlineInputBorder enabledFieldBorder =  OutlineInputBorder(
  borderSide: const BorderSide(color: fieldBorderColor),
  borderRadius: BorderRadius.circular(circleCurves10),
);

OutlineInputBorder focusedFieldBorder =  OutlineInputBorder(
    borderSide:  const BorderSide(color: danubeBaseColor),
    borderRadius: BorderRadius.circular(circleCurves10));

OutlineInputBorder errorFieldBorder =  OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.red),
    borderRadius: BorderRadius.circular(circleCurves10));

EdgeInsets contentPadding = const EdgeInsets.only(top: size15,bottom: size15,left: size5,right: size5);

EdgeInsets suffixIconPadding = const EdgeInsets.only(right:size20);
EdgeInsets prefixIconPadding = const EdgeInsets.only(left:size20);

TextStyle regularTxtWithBlack = const TextStyle(
  color: black,fontSize: fSize16,
  fontFamily: readexProRegular,
  fontWeight: FontWeight.w400,
  // letterSpacing: 0.3,
);
