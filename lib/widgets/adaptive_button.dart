import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveButton extends StatelessWidget {
  late final String title;
  late final Function() handler;

  AdaptiveButton({required this.title, required this.handler});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            color: Colors.purple,
            child: Text(title),
            disabledColor: Colors.black,
            onPressed: handler,
          )
        : ElevatedButton(
            onPressed: handler,
            child: Text(title),
          );
  }
}
