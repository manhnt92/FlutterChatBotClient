import 'dart:async';
import 'package:chat_bot/models/aiapp.pb.dart';
import 'package:chat_bot/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:connectivity_plus/connectivity_plus.dart';

enum AppWebSocketState {
  connecting, connected, disconnected
}

abstract class SocketEventListener {
  void onInternetConnection(bool connected) {}
  void onWebSocketOpen() {}
  void onWebSocketClose() {}
  void onWebSocketMessage(dynamic message) {}
}

class AppWebSocket {

  static final AppWebSocket instance = AppWebSocket._internal();
  factory AppWebSocket() => instance;
  AppWebSocket._internal();

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  static const String urlWebSocket = "wss://h2ksolution.com:3000/aichatserver";
  WebSocketChannel? _wsChannel;
  AppWebSocketState _currentState = AppWebSocketState.disconnected;
  Timer? _reconnectTimer;
  final List<SocketEventListener> _listeners = [];

  void init() async {
    ConnectivityResult status;
    try {
      status = await _connectivity.checkConnectivity();
    } on PlatformException catch (_) {
      status = ConnectivityResult.none;
    }
    for (var l in _listeners) {
      l.onInternetConnection(status != ConnectivityResult.none);
    }

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
      bool isInternetConnected = result != ConnectivityResult.none;
      for (var l in _listeners) {
        l.onInternetConnection(isInternetConnected);
      }
      _disconnect();
      if (isInternetConnected) {
        _connect();
      }
    });
  }

  void dispose() {
    _connectivitySubscription?.cancel();
    _disconnect();
  }

  void _connect() async {
    debugPrint('socket connecting');
    _currentState = AppWebSocketState.connecting;
    _wsChannel = WebSocketChannel.connect(Uri.parse(urlWebSocket));
    _wsChannel?.ready.then((value) {
      _currentState = AppWebSocketState.connected;
      debugPrint('socket connected');
      _reconnectTimer?.cancel();
      for (var l in _listeners) {
        l.onWebSocketOpen();
      }

      _wsChannel?.stream.listen((event) {
          for (var l in _listeners) {
            l.onWebSocketMessage(event);
          }
        },
        onError: (error, stackTrace) {
          debugPrint("socket error => reconnect");
          _disconnect();
          _reconnect();
        },
        onDone: () {
          debugPrint("socket disconnected");
          for (var l in _listeners) {
            l.onWebSocketClose();
          }
        }
      );
    });
  }

  void _disconnect() {
    _wsChannel?.sink.close(status.goingAway);
    _reconnectTimer?.cancel();
    _currentState = AppWebSocketState.disconnected;
    for (var l in _listeners) {
      l.onWebSocketClose();
    }
  }

  void _reconnect() {
    if (_reconnectTimer == null || !_reconnectTimer!.isActive) {
      _reconnectTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
        _connect();
      });
    }
  }

  bool isConnected() {
    return _currentState == AppWebSocketState.connected;
  }

  void sendLogin(String token) {
    debugPrint('request login: token=$token');
    var message = PBCommonMessage();
    message.id = 20002;
    message.params['type'] = _createIntValue(4);
    message.params['platform'] = _createStringValue(Utils.osName);
    message.params['token'] = _createStringValue(token);
    sendPBCommonMessage(message);
  }

  void checkLimit() {
    debugPrint('check limit');
    var msg = PBCommonMessage();
    msg.id = 20005;
    sendPBCommonMessage(msg);
  }

  void sendChat(String content, int topicId) {
    debugPrint('request send chat : isConnected=${isConnected()} - content=$content - topicId=$topicId}');
    var msg = PBCommonMessage();
    msg.id = 20003;
    msg.params['msg'] = _createStringValue(content);
    if (topicId > 0) {
      msg.params['topicId'] = _createIntValue(topicId);
    }
    sendPBCommonMessage(msg);
  }

  void sendIAP(String token, String productId) {
    var msg = PBCommonMessage();
    msg.id = 20006;
    msg.params["token"] = _createStringValue(token);
    msg.params["productid"] = _createStringValue(productId);
    sendPBCommonMessage(msg);
  }

  void sendPBCommonMessage(PBCommonMessage message) {
    // debugPrint("send pb common message: ${message.toDebugString()}");
    _wsChannel?.sink.add(message.writeToBuffer());
  }

  PBValue _createIntValue(int v) {
    var value = PBValue();
    value.intValue = v;
    return value;
  }

  PBValue _createStringValue(String v) {
    var value = PBValue();
    value.stringValue = v;
    return value;
  }

  void registerEventListener(SocketEventListener listener) {
    if (!_listeners.contains(listener)) {
      debugPrint("$listener register socket event");
      _listeners.add(listener);
    }
  }

  void unregisterEventListener(SocketEventListener listener) {
    if (_listeners.contains(listener)) {
      debugPrint("$listener unregister socket event");
      _listeners.remove(listener);
    }
  }

}