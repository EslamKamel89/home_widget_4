import 'package:flutter/material.dart';

enum St {
  reg12,
  bold12,
  reg14,
  semi14,
  bold14,
  reg16,
  semi16,
  bold16,
  reg18,
  semi18,
  bold18,
  reg20,
  semi20,
  bold20,
  reg25,
  semi25,
  bold25,
  reg30,
  semi30,
  bold30,
}

/// e =>  enum         => St
///
/// s =>  fontSize     => double?
///
/// w =>  fontWeight   => FontWeight?
///
/// f =>  fontFamily   => String?
///
/// c =>  color        => Color?
///
///googleFontCallback => TextSylte Function()?
///
/// maxLines => int?
///
/// Default fontSize = 16
///
/// Default fontWeight = FontWeight.normal
Text txt(
  String text, {
  St? e,
  double? s,
  FontWeight? w,
  String? f,
  Color? c,
  int? maxLines,
  TextStyle Function()? googleFontCallback,
  TextAlign? textAlign,
}) {
  s = s ?? 18;
  w = FontWeight.normal;
  if (e != null) {
    switch (e) {
      case St.reg12:
        s = 12;
        w = FontWeight.normal;
        break;
      case St.bold12:
        s = 12;
        w = FontWeight.bold;
        break;
      case St.semi14:
        s = 14;
        w = FontWeight.w600;
        break;
      case St.reg14:
        s = 14;
        w = FontWeight.normal;
        break;
      case St.bold14:
        s = 14;
        w = FontWeight.w900;
        break;
      case St.semi16:
        s = 16;
        w = FontWeight.w600;
        break;
      case St.reg16:
        s = 16;
        w = FontWeight.normal;
        break;
      case St.bold16:
        s = 16;
        w = FontWeight.bold;
        break;
      case St.semi18:
        s = 18;
        w = FontWeight.w600;
        break;
      case St.reg18:
        s = 18;
        w = FontWeight.normal;
        break;
      case St.bold18:
        s = 18;
        w = FontWeight.bold;
        break;
      case St.semi20:
        s = 20;
        w = FontWeight.w600;
        break;
      case St.reg20:
        s = 20;
        w = FontWeight.normal;
        break;
      case St.bold20:
        s = 20;
        w = FontWeight.bold;
        break;
      case St.semi25:
        s = 25;
        w = FontWeight.w600;
        break;
      case St.reg25:
        s = 25;
        w = FontWeight.normal;
        break;
      case St.bold25:
        s = 25;
        w = FontWeight.bold;
        break;
      case St.semi30:
        s = 30;
        w = FontWeight.w600;
        break;
      case St.reg30:
        s = 30;
        w = FontWeight.normal;
        break;
      case St.bold30:
        s = 30;
        w = FontWeight.bold;
        break;
    }
  }
  if (googleFontCallback != null) {
    return Text(
      text,
      style:
          googleFontCallback().copyWith(fontSize: s, fontWeight: w, color: c),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
    );
  }
  return Text(
    text,
    style: TextStyle(fontSize: s, fontWeight: w, fontFamily: f, color: c),
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    textAlign: textAlign,
  );
}
