import 'package:daily_recipe2/consts/consts.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final IconData? leadingIcon;
  final IconData? actionIcon;
  final String? title;
  final Function()? onPressLeading;
  final Function()? onPressAction;
  const CustomAppBar(
      {super.key,required this.leadingIcon,required this.actionIcon, this.title,required this.onPressLeading, required this.onPressAction});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        shadowColor: ColorsApp.whiteColor,
        backgroundColor: ColorsApp.whiteColor,
        foregroundColor: ColorsApp.darkFontGrey,
surfaceTintColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          onPressed: onPressLeading,
          icon:   Icon(
              leadingIcon,
              size: 30,
            ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20,top: 5),
            child: IconButton(
              onPressed: onPressAction,
              icon:  Icon(
                actionIcon,
                size: 30,
              ),
            ),
          ),
        ]);
  }
}
