import 'package:flutter/widgets.dart';

class MyIcons {
  MyIcons._();
  static Widget cultivoPNG({double size = 24.0, Color? color}) {
    return Image.asset(
      'assets/icons/cultivo_icon.png',
      width: size,
      height: size,
      color: color,
    );
  }

  static Widget insumoPNG({double size = 24.0, Color? color}) {
    return Image.asset(
      'assets/icons/insumo_icon.png',
      width: size,
      height: size,
      color: color,
    );
  }

  static Widget cuboPNG({double size = 24.0, Color? color}) {
    return Image.asset(
      'assets/icons/cubo_icon.png',
      width: size,
      height: size,
      color: color,
    );
  }

  static Widget libroPNG({double size = 24.0, Color? color}) {
    return Image.asset(
      'assets/icons/libro_icon.png',
      width: size,
      height: size,
      color: color,
    );
  }

  static Widget tierraPNG({double size = 24.0, Color? color}) {
    return Image.asset(
      'assets/icons/tierra_icon.png',
      width: size,
      height: size,
      color: color,
    );
  }
}
