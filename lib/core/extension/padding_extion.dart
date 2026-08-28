import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension PaddingExtension on num {
  EdgeInsets get allPadding => EdgeInsets.all(toDouble().r);

  EdgeInsets get horizontalPadding =>
      EdgeInsets.symmetric(horizontal: toDouble().w);

  EdgeInsets get verticalPadding =>
      EdgeInsets.symmetric(vertical: toDouble().h);
}
