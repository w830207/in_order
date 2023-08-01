import 'package:bot_toast/bot_toast.dart';

class PopupService3 {
  List popupQueue = [];

  _push(Map map) {
    // 唯一彈窗直接執行
    if (popupQueue.isEmpty) {
      popupQueue.add(map);
      _check();
      return;
    }

    // 比較等級 插入
    for (int i = 1; i < popupQueue.length; i++) {
      if(map["level"] > popupQueue[i]["level"]){
        popupQueue.insert(i, map);
        return;
      }
    }

    // 等級最低末端加入
    popupQueue.add(map);
  }

  _popLow() {
    if (popupQueue.isEmpty) return;
    popupQueue.removeAt(0);
    // 執行下一個彈窗
    _check();
  }

  _check() {
    if (popupQueue.isEmpty) return;
    popupQueue.first["popup"]();
  }

  popupLevel(int level) {
    Map map = {
      "level": level,
      "popup": () {
        BotToast.showSimpleNotification(
          title: "$level",
          onClose: _popLow,
        );
      },
    };

    _push(map);
  }
}
