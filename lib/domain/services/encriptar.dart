import 'dart:convert';

import 'package:crypto/crypto.dart';

class Encriptrar {
  String encript(String texto) {
//     var bytes = utf8.encode(texto);
//     var digest = sha256.convert(bytes);
//     // return  digest.toString();

//       var sha256 = new SHA256();
//   sha256.add('message'.codeUnits);
//   var digest = sha256.close();
//   var hexString = CryptoUtils.bytesToHex(digest);
//   print(hexString ==
//       'ab530a13e45914982b79f9b7e3fba994cfd1f3fb22f71cea1afbf02b460c6d1d'); /
//   }
    var key = utf8.encode(texto);
    var bytes = utf8.encode("sgrsoft2022");

    var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);

    // print("HMAC digest as bytes: ${digest.bytes}");
    // print("HMAC digest as hex string: $digest");
    return (digest.toString());
  }
}
