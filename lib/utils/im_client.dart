import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:palm_green/models/user.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';

class IMClient with ChangeNotifier {
  IOWebSocketChannel _channel;
  BuildContext _context;

  IMClient(this._context) {
    _channel = IOWebSocketChannel.connect('ws://114.55.92.221:7272');

    _channel.stream.listen((message) {
      var msg = json.decode(message);
      print(msg);
      switch (msg["type"]) {
        case "handshake": // 握手
          _onHandshake();
          break;
        case "ping": // 回应服务端发来的心跳包
          _onPing();
          break;
        default:
          break;
      }
    });
  }

  bool sendMessage(String message, [String toUserId = "all"]) {
    if (message.isEmpty) return false;
    _channel.sink.add(
      json.encode({
        "type": "say",
        "to_client_id": "all",
        "content": message,
      }),
    );
    return true;
  }

  void _onHandshake() {
    _channel.sink.add(
      json.encode({
        "type": "login",
        "client_name": Provider.of<User>(_context, listen: false).name,
        "room_id": "green_official",
      }),
    );
  }

  void _onPing() {
    _channel.sink.add(
      json.encode({"type": "pong"}),
    );
  }

  void close() {
    _channel.sink.close();
  }
}
