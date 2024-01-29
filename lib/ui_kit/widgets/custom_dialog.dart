import 'dart:ui';
import 'package:flutter/material.dart';

import '../../theme/app_theme_widget.dart';
import 'general_text.dart';

class CustomDialog {
  static getDialog(
      {BuildContext? ctx,
      required String title,
      required String description,
      Color? titleColor,
      Color? descColor,
      String? highlightedName,
      required String iconUrl,
      required void Function()? onTap}) {
    final appTheme = AppTheme.of(ctx!).theme;
    return showDialog(
        context: ctx,
        barrierColor: const Color(0xFF212129).withOpacity(0.1),
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: AlertDialog(
              backgroundColor: const Color(0xFF212129),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Image.asset(
                    iconUrl,
                    height: 50,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GeneralText(
                    title,
                    style: appTheme.typographies.interFontFamily.headline6
                        .copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: titleColor ?? const Color(0xFF8ea659),
                    ),
                  ),
                  // Text(title, style:  TextStyle(color: titleColor ?? const Color(0xFF8ea659), fontSize: 20, fontWeight: FontWeight.w500),),
                  const SizedBox(
                    height: 20,
                  ),
                  highlightedName == null
                      ? Text(description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: descColor ?? Colors.white,
                          ))
                      : RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: description,
                            style: TextStyle(
                              color: descColor ?? Colors.white,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: highlightedName,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xfff1c452),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 90,
                    child: ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 12,
                          )),
                      child: const Text('Okay'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
