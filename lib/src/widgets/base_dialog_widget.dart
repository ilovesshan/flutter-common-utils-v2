import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

class BaseDialogWidget extends GetView {
  final String? title;
  final String? content;
  final String? lBtnText;
  final String? rBtnText;
  final VoidCallback? lBtnOnTap;
  final VoidCallback? rBtnOnTap;
  final bool single;
  final bool callbackBeforeClose;
  final Color mainColor;
  final Widget? contentView;

  const BaseDialogWidget({
    Key? key,
    this.title,
    this.content,
    this.lBtnText,
    this.rBtnText,
    this.lBtnOnTap,
    this.rBtnOnTap,
    this.single = false,
    this.callbackBeforeClose = false,
    this.contentView,
    this.mainColor = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ? buildAndroidSystemDialog() : buildIosSystemDialog();
  }

  Widget buildIosSystemDialog() {
    return CupertinoAlertDialog(
      title: Center(child: Text(title ?? "", style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold))),
      content: contentView ?? Text(content ?? "", style: const TextStyle(fontSize: 12, color: Colors.grey)),
      actions: single
          ? [
              CupertinoDialogAction(
                onPressed: () {
                  if (callbackBeforeClose) {
                    if (rBtnOnTap != null) {
                      rBtnOnTap!();
                    }
                  }
                  Get.back();
                  if (!callbackBeforeClose) {
                    if (rBtnOnTap != null) {
                      rBtnOnTap!();
                    }
                  }
                },
                textStyle: TextStyle(color: Get.theme.primaryColor),
                isDefaultAction: true,
                child: Text(rBtnText ?? "确定", style: const TextStyle(fontSize: 12)),
              ),
            ]
          : [
              CupertinoDialogAction(
                onPressed: () {
                  if (callbackBeforeClose) {
                    if (lBtnOnTap != null) {
                      lBtnOnTap!();
                    }
                  }
                  Get.back();
                  if (!callbackBeforeClose) {
                    if (lBtnOnTap != null) {
                      lBtnOnTap!();
                    }
                  }
                },
                textStyle: const TextStyle(color: Colors.grey),
                child: Text(lBtnText ?? "取消", style: const TextStyle(fontSize: 12)),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  if (callbackBeforeClose) {
                    if (rBtnOnTap != null) {
                      rBtnOnTap!();
                    }
                  }
                  Get.back();
                  if (!callbackBeforeClose) {
                    if (rBtnOnTap != null) {
                      rBtnOnTap!();
                    }
                  }
                },
                isDefaultAction: true,
                textStyle: TextStyle(color: Get.theme.primaryColor),
                child: Text(rBtnText ?? "确定", style: const TextStyle(fontSize: 12)),
              ),
            ],
    );
  }

  Widget buildAndroidSystemDialog() {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(title ?? "", style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 12),
                DefaultTextStyle(
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                  child: contentView ?? Text(content ?? ""),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    single
                        ? const SizedBox.shrink()
                        : GestureDetector(
                            onTap: () {
                              if (callbackBeforeClose) {
                                if (lBtnOnTap != null) {
                                  lBtnOnTap!();
                                }
                              }
                              Get.back();
                              if (!callbackBeforeClose) {
                                if (lBtnOnTap != null) {
                                  lBtnOnTap!();
                                }
                              }
                            },
                            child: Container(
                              width: 110,
                              height: 36,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: Colors.white, border: Border.all(color: Get.theme.primaryColor)),
                              child: Text(lBtnText ?? "取消", style: TextStyle(color: Get.theme.primaryColor)),
                            ),
                          ),
                    GestureDetector(
                      onTap: () {
                        if (callbackBeforeClose) {
                          if (rBtnOnTap != null) {
                            rBtnOnTap!();
                          }
                        }
                        Get.back();
                        if (!callbackBeforeClose) {
                          if (rBtnOnTap != null) {
                            rBtnOnTap!();
                          }
                        }
                      },
                      child: Container(
                        width: 110,
                        height: 36,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Get.theme.primaryColor,
                        ),
                        child: Text(rBtnText ?? "确定", style: const TextStyle(color: Colors.white)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
