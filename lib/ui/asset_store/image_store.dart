import 'package:flutter/material.dart';

class ImageStore {
  final Widget logo =
      const Image(image: AssetImage('assets/images/logo.png'), height: 50);

  final Widget logoLogin = const Image(
      image: AssetImage('assets/images/logo.png'), width: 167, height: 58);
}
