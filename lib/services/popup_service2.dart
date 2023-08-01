import 'package:bot_toast/bot_toast.dart';

class PopupService2 {
  List popupLowQueue = [];
  List popupHighQueue = [];

  _pushLow(Function f) {
    popupLowQueue.add(f);
    // 唯一彈窗直接執行
    if (popupLowQueue.length + popupHighQueue.length == 1) _check();
  }

  _pushHigh(Function f) {
    popupHighQueue.add(f);
    // 唯一彈窗直接執行
    if (popupLowQueue.length + popupHighQueue.length == 1) _check();
  }

  _popLow() {
    if (popupLowQueue.isEmpty) return;
    popupLowQueue.removeAt(0);
    // 執行下一個彈窗
    _check();
  }

  _popHigh() {
    if (popupHighQueue.isEmpty) return;
    popupHighQueue.removeAt(0);
    // 執行下一個彈窗
    _check();
  }

  _check() {
    // 優先執行高等級
    if (popupHighQueue.isNotEmpty) {
      popupHighQueue.first();
      return;
    }
    if (popupLowQueue.isEmpty) return;
    popupLowQueue.first();
  }

  popupLowLevel() {
    _pushLow(() {
      BotToast.showSimpleNotification(
        title: "low",
        onClose: _popLow,
      );
    });
  }

  popupHighLevel() {
    _pushHigh(() {
      BotToast.showSimpleNotification(
        title: "high",
        onClose: _popHigh,
      );
    });
  }
}
