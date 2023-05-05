import 'package:flutter/material.dart';

class VideoConfig extends InheritedWidget {
  const VideoConfig({super.key, required super.child});

  final bool autoMute = false;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
