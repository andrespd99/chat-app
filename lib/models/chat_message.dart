import 'package:flutter/material.dart';

class ChatMessage {
  String text;
  String uid;
  AnimationController controller;

  ChatMessage({
    required this.uid,
    required this.text,
    required this.controller,
  });
}
