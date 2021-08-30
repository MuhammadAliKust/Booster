library booster;

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Booster {
  static verticalSpace(double height) {
    return SizedBox(
      height: height,
    );
  }

  static horizontalSpace(double width) {
    return SizedBox(
      width: width,
    );
  }

  static Widget dynamicFontSize({
    required String label,
    required double fontSize,
    bool isAlignCenter = true,
    bool isBold = false,
    bool isUnderline = false,
    double lineHeight = 1.0,
    double letterSpacing = 0.5,
    String fontFamily,
    FontWeight fontWeight = FontWeight.bold,
    Color? color,
  }) {
    return Text(
      label,
      textAlign: isAlignCenter ? TextAlign.center : TextAlign.start,
      style: TextStyle(
        letterSpacing: letterSpacing,
        height: lineHeight,
        fontFamily: fontFamily,
        decoration:
            isUnderline ? TextDecoration.underline : TextDecoration.none,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }

  static Widget noDataFound(BuildContext context,
      {required IconData icon,
      required Color iconColor,
      double iconSize = 65}) {
    return Container(
      height: MediaQuery.of(context).size.height - 150,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: iconSize,
          ),
          verticalSpace(10),
          Center(
            child: dynamicFontSize(
              label: "No Data Found!",
              color: Colors.grey[400],
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  static Widget paddedWidget({
    required Widget child,
    double left = 0.0,
    double right = 0.0,
    double top = 0.0,
    double bottom = 0.0,
  }) {
    return Padding(
      padding:
          EdgeInsets.only(top: top, left: left, right: right, bottom: bottom),
      child: child,
    );
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static Widget networkProfileAvatar(
      {File? image,
      required String networkImage,
      required String placeHolderImage,
      required Widget loadingWidget,
      required VoidCallback onTap,
      Color iconColor = Colors.green}) {
    return Stack(
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          // ignore: unnecessary_null_comparison
          child: image == null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: networkImage,
                    placeholder: (context, url) => loadingWidget,
                    errorWidget: (context, url, error) => Image.asset(
                      placeHolderImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.file(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        profileImagePicker(() => onTap(), color: iconColor)
      ],
    );
  }

  static Widget localProfileAvatar(
      {required double radius, required String assetImage}) {
    return Container(
      height: radius,
      width: radius,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage(
                assetImage,
              ),
              fit: BoxFit.cover)),
    );
  }

  static Widget profileImagePicker(VoidCallback onTap, {required Color color}) {
    return Positioned.fill(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: InkWell(
            onTap: () => onTap(),
            child: Container(
              child: Icon(
                Icons.image,
                color: Colors.white,
              ),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  color: color,
                  shape: BoxShape.circle),
            ),
          ),
        ),
      ],
    ));
  }
}
