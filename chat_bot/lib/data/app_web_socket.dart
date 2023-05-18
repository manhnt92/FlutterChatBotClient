import 'package:chat_bot/models/aiapp.pb.dart';
import 'package:flutter/widgets.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class AppWebSocket {

  static final AppWebSocket instance = AppWebSocket._internal();
  factory AppWebSocket() => instance;
  AppWebSocket._internal();

  static const String urlWebSocket = "ws://h2ksolution.com:3000/aichatserver";
  late WebSocketChannel _wsChannel;
  late Stream _wsChannelStream;

  void init() {
    _wsChannel = WebSocketChannel.connect(Uri.parse(urlWebSocket));
    _wsChannelStream = _wsChannel.stream.asBroadcastStream();
    _wsChannelStream.listen((event) {
      //debugPrint("AppWebSocket: $event");
    });
  }

  void sendMessage(Map<String, dynamic> map) {
    debugPrint("send socket message: $map");
    _wsChannel.sink.add(null/*jsonEncode(map)*/);
  }

  void setPBCommonMessage(PBCommonMessage message) {
    // debugPrint("send pb common message: ${message.toDebugString()}");
    _wsChannel.sink.add(message.writeToBuffer());
  }

  Stream getWebSocketStream() {
    return _wsChannelStream;
  }

  void dispose() {
    _wsChannel.sink.close(status.goingAway);
  }

}