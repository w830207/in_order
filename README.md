# 前言
在公司的專案使用[BotToast](https://pub.dev/packages/bot_toast)執行彈窗功能，用起來很舒服很全面。

然而隨著產品迭代更新，功能越加越多，開始出現彈窗的互頂與互蓋，最多曾遇到6個彈窗同時疊在一塊，四周背景陰影疊得烏漆麻黑。

此時讓彈窗按順序彈出就顯得格外重要了。

# 思路

說到按順序，那就是先進先出概念的Queue，需要一個array，可以直接使用List。

需要一個函式執行Push，負責放入彈窗到隊列尾端中。

需要一個函式執行Pop，負責將隊列頭部的彈窗移除。

最後還需要一個函式負責在上述兩個動作後，執行隊列在頭部的彈窗。

# 實現

![basic.gif](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e7fc92baec1c415795bff6b4a3926eb0~tplv-k3u1fbpfcp-watermark.image?)

基本內容：
```Dart
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
```
結合BotToast：

```Dart
showAnimationWidget() {
  _push((){
    BotToast.showAnimationWidget(... onClose: _pop);
  });
}
```


# 升級：彈窗優先度

### 基本雙等級


![two.gif](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/cd47051bb54645b2a92b97d0961b3a08~tplv-k3u1fbpfcp-watermark.image?)

可以分成兩個Queue代表不同等級
直接上code

```dart
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
```
然而這種做法，等級一旦多了，會顯得非常麻煩與混亂。


### 多等級優先度


![multi.gif](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/763d919a00684f5b9b16a8045db210fa~tplv-k3u1fbpfcp-watermark.image?)

使用Map包裝彈窗function並標上等級，通過等級比較決定順序。

```dart
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
```
