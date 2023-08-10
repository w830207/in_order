import 'package:bot_toast/bot_toast.dart';

class PopupService1 {
  List popupQueue = [];

  _push(Function f) {
    popupQueue.add(f);
    // 唯一彈窗直接執行
    if (popupQueue.length == 1) _check();
  }

  _pop() {
    if (popupQueue.isEmpty) return;
    popupQueue.removeAt(0);
    // 執行下一個彈窗
    _check();
  }

  _check() {
    if (popupQueue.isEmpty) return;
    popupQueue.first();
  }

  popup() {
    _push(() {
      BotToast.showSimpleNotification(
        title: "pop",
        onClose: _pop,
      );
    });
  }
}
