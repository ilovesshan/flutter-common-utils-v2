import 'package:common_utils_v2/common_utils_v2.dart';
import 'package:flutter/material.dart';

class LoadingUtil {
  static CancelFunc showLoading({String msg = "加载中...", VoidCallback? onClose}) {
    return BotToast.showCustomLoading(
      onClose: onClose,
      toastBuilder: (CancelFunc cancelFunc) {
        return Container(
          width: 120, height: 120, alignment: Alignment.center,
          decoration: const BoxDecoration(color: Colors.black, borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [const CircularProgressIndicator(backgroundColor: Colors.white),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Text(msg, style: const TextStyle(color: Colors.white, fontSize: 12)),
              const Padding(padding: EdgeInsets.only(top: 10)),
              SizedBox(
                height: 20,
                child: ElevatedButton(
                  onPressed: () {
                    if (onClose != null) {
                      onClose();
                    }
                    cancelFunc();
                  },
                  child: Text("取消".tr, style: const TextStyle(fontSize: 12)),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static void hideAllLoading() {
    BotToast.closeAllLoading();
  }
}