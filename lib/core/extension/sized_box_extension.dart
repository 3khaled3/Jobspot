import 'package:flutter/material.dart';

extension SizedBoxExtension on num {
  SizedBox get hSpace => SizedBox(height: toDouble());
  SizedBox get wSpace => SizedBox(width: toDouble());
}
