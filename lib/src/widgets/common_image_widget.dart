import 'dart:io';

import 'package:common_utils_v2/common_utils_v2.dart';
import 'package:flutter/material.dart';

class CommonImageWidget extends StatelessWidget {
  final String path;
  final double width;
  final double height;
  final BorderRadius? borderRadius;
  final BoxFit boxFit;

  const CommonImageWidget({Key? key, required this.width, required this.height, required this.path, this.boxFit = BoxFit.cover, this.borderRadius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = const SizedBox();
    if (path.startsWith("https:") || path.startsWith("http:")) {
      child = CachedNetworkImage(imageUrl: path, width: width, height: height, fit: boxFit);
    } else if (path.startsWith("assets/")) {
      child = Image.asset(path, width: width, height: height, fit: boxFit);
    } else if (path.startsWith("/data") || path.startsWith("/mnt")) {
      child = Image.file(File(path), width: width, height: height, fit: boxFit);
    } else if (path.startsWith("/preview")) {
      child = CachedNetworkImage(imageUrl: HttpHelperUtil.baseurl + path, width: width, height: height, fit: boxFit);
    }else{
      child = Image.asset("assets/images/logo.png", width: width, height: height, fit: boxFit);
    }
    return ClipRRect(borderRadius: borderRadius, child: child);
  }
}
