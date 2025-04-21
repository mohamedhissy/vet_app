import 'package:flutter/material.dart';
import '../resources/manager_colors.dart';
import '../resources/manager_font_sizes.dart';
import '../resources/manager_font_weight.dart';
import '../resources/manager_height.dart';
import '../resources/manager_raduis.dart';
import '../resources/manager_strings.dart';
import '../resources/manager_width.dart';
import 'package:animalsapp/core/extension/extensions.dart';

class BaseButton extends StatelessWidget {
  String? title = ManagerStrings.start;
  final bool isVisibleIcon;
  final double elevation;
  final double width;
  final double height;
  final Color bgColor;
  void Function() onPressed;

  TextStyle? textStyle = TextStyle(
    fontSize: ManagerFontSizes.s16,
    fontWeight: ManagerFontWeight.regular,
    color: ManagerColors.white,
  );

  BaseButton({
    super.key,
    this.elevation = 0,
    this.title,
    this.isVisibleIcon = false,
    this.width = ManagerWidth.w355,
    this.height = ManagerHeight.h60,
    this.bgColor = ManagerColors.primaryColor,
    this.textStyle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: bgColor,
        minimumSize: Size(
          width,
          height,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ManagerRadius.r5),
        ),
      ),
      child: Text(
        title.onNull(),
        style: TextStyle(
          color: ManagerColors.white,
          fontWeight: ManagerFontWeight.regular,
          fontSize: ManagerFontSizes.s16,
        ),
      ),
    );
  }
}
