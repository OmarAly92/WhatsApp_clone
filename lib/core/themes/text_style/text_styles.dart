import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';

import '../../networking/model/parameters_data/limit_font_size_model.dart';
import '../../utils/size_config.dart';

abstract class Styles {
  static TextStyle textStyle12() {
    return TextStyle(
      fontSize: getResponsiveFontSize(fontSize: 12),
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle textStyle14() {
    return TextStyle(
      fontSize: getResponsiveFontSize(fontSize: 14),
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle textStyle16() {
    return TextStyle(
      fontSize: getResponsiveFontSize(fontSize: 16),
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle textStyle18() {
    return TextStyle(
      fontSize: getResponsiveFontSize(fontSize: 18),
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle textStyle20() {
    return TextStyle(
      fontSize: getResponsiveFontSize(fontSize: 20),
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle textStyle22() {
    return TextStyle(
      fontSize: getResponsiveFontSize(fontSize: 22),
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle textStyle24() {
    return TextStyle(
      fontSize: getResponsiveFontSize(fontSize: 24),
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle textStyle26() {
    return TextStyle(
      fontSize: getResponsiveFontSize(fontSize: 26),
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle textStyle28() {
    return TextStyle(
      fontSize: getResponsiveFontSize(fontSize: 28),
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle textStyle30() {
    return TextStyle(
      fontSize: getResponsiveFontSize(fontSize: 30),
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle textStyle32() {
    return TextStyle(
      fontSize: getResponsiveFontSize(fontSize: 32),
      fontWeight: FontWeight.normal,
    );
  }

  static double getResponsiveFontSize({required double fontSize}) {
    final double scaleFactor = getScaleFactor();
    final double responsiveFontSize = fontSize * scaleFactor;
    final limits = getLimits();

    final double lowerLimit = fontSize * limits.lowerLimit;
    final double upperLimit = fontSize * limits.upperLimit;

    return responsiveFontSize.clamp(lowerLimit, upperLimit);
  }

  static LimitFontSizeModel getLimits() {
    final dispatcher = PlatformDispatcher.instance;
    final physicalWidth = dispatcher.views.first.physicalSize.width;
    final devicePixelRatio = dispatcher.views.first.devicePixelRatio;
    final double width = physicalWidth / devicePixelRatio;
    // final double width = MediaQuery.sizeOf(context).width;
    if (width < SizeConfig.tablet) {
      return const LimitFontSizeModel(lowerLimit: 0.6, upperLimit: 1.2);
    } else if (width < SizeConfig.desktop) {
      return const LimitFontSizeModel(lowerLimit: 0.8, upperLimit: 1.0);
    } else {
      return const LimitFontSizeModel(lowerLimit: 0.9, upperLimit: 1.6);
    }
  }

  static double getScaleFactor() {
    final dispatcher = PlatformDispatcher.instance;
    final physicalWidth = dispatcher.views.first.physicalSize.width;
    final devicePixelRatio = dispatcher.views.first.devicePixelRatio;
    final double width = physicalWidth / devicePixelRatio;
    log(width.toString());
    // final double width = MediaQuery.sizeOf(context).width;
    if (width < SizeConfig.tablet) {
      return width / 550;
    } else if (width < SizeConfig.desktop) {
      return width / 800;
    } else {
      return width / 1650;
    }
  }
}
