typedef EventBusCallback = void Function(dynamic data);

class EventBusCallbackModel {
  String? key;
  List<EventBusCallback>? callbacks;

  EventBusCallbackModel({this.key,this.callbacks});
}


class EventBusUtil {
  static final List<EventBusCallbackModel> _callbacks = [];

  /// 监听订阅
  static void $on(String key, EventBusCallback callback) {
    bool hasExit = false;
    int findIndex = _callbacks.isEmpty ? 0 : -1;

    for (var i = 0; i < _callbacks.length; i++) {
      if (_callbacks[i].key == key) {
        hasExit = true;
        findIndex = i;
      }
    }
    EventBusCallbackModel currentCallBack = EventBusCallbackModel(key: key, callbacks: []);
    if (findIndex != 0 && findIndex != -1) {
      currentCallBack = _callbacks.elementAt(findIndex);
    }

    if (!hasExit) {
      currentCallBack.callbacks = [];
    }
    currentCallBack.callbacks!.add(callback);
    _callbacks.add(currentCallBack);
  }


  /// 添加订阅
  static void $emit(String key, dynamic data) {
    List<EventBusCallback> callbackList = [];
    for (var i = 0; i < _callbacks.length; i++) {
      if (_callbacks[i].key == key) {
        callbackList = _callbacks[i].callbacks!;
        break;
      }
    }

    for(var callback in callbackList){
      callback.call(data);
    }
  }


  /// 取消订阅
  static void $remove(String key) {
    int findIndex = -1;
    for (var i = 0; i < _callbacks.length; i++) {
      if (_callbacks[i].key == key) {
        findIndex = i;
      }
    }
    if (findIndex != -1) {
      _callbacks.removeAt(findIndex);
    }
  }
}
