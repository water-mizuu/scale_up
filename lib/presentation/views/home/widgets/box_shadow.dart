import "package:flutter/material.dart" hide BoxShadow;
import "package:flutter_inset_shadow/flutter_inset_shadow.dart";

const shadowDebug = false;

const defaultBoxShadow = [
  if (shadowDebug)
    BoxShadow(color: Colors.red, blurRadius: 8.0, offset: Offset(0, 4))
  else
    BoxShadow(color: Color(0x40000000), blurRadius: 8.0, offset: Offset(0, 4)),
];

const defaultInsetShadow = [
  if (shadowDebug)
    BoxShadow(color: Colors.blue, blurRadius: 4.0, offset: Offset(0, 4), inset: true)
  else
    BoxShadow(color: Color(0x40000000), blurRadius: 4.0, offset: Offset(0, 4), inset: true),
];
