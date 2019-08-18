import 'package:flutter/material.dart';

class Style {
  static final baseTextStyle = const TextStyle(fontFamily: 'Poppins');
  static final smallTextStyle = commonTextStyle.copyWith(
    fontSize: 9.0,
  );

//  static final commonTextStyle = baseTextStyle.copyWith(
//      color: const Color(0xffb6b2df),
//      fontSize: 14.0,
//      fontWeight: FontWeight.w400);

  static final commonTextStyle = baseTextStyle.copyWith(
      color: Colors.grey,
      fontSize: 14.0,
      fontWeight: FontWeight.w400);


  static final commonDetailsTextStyle = baseTextStyle.copyWith(
      color: Colors.blue, fontSize: 14.0, fontWeight: FontWeight.w400);
  static final titleTextStyle = baseTextStyle.copyWith(
      color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600);
  static final headerTextStyle = baseTextStyle.copyWith(
      color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w400);

  static final greyTextStyle = baseTextStyle.copyWith(
      color: Colors.grey, fontSize: 20.0, fontWeight: FontWeight.w400);

  static final commonHeadingTextStyle = baseTextStyle.copyWith(
      color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w400);

  static final currencyTextColor = baseTextStyle.copyWith(
      color: Colors.red, fontSize: 14.0, fontWeight: FontWeight.w400);

  static final languageTExt = baseTextStyle.copyWith(
      color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w400);
}
