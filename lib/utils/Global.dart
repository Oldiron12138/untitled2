import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:untitled2/utils/SharePerfManager.dart';

class Global {
  static Global instance = Global();

  static MediaQueryData mediaQueryData = MediaQueryData.fromWindow(window);
  static double screenWidth = mediaQueryData.size.width;
  static double screenHeight = mediaQueryData.size.height;
  static double paddingBottom = mediaQueryData.padding.bottom;
  static double paddingTop = mediaQueryData.padding.top;

  static bool isLoged = false;
  static String? userName;
  static String? userPwd;
  static int? mCoin;
  static int? mId;
  static List<String> mUnlockMovie = <String>[];
  static List<String> mUnlockInfos = <String>[];

}