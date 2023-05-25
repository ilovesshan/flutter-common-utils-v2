import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';
import 'package:flutter/services.dart';

class EncryptUtil {
  /// RAS 加密
  static String encodeRsa({required String content, required String publicKeyStr}) {
    dynamic publicKey = RSAKeyParser().parse(publicKeyStr);
    final encrypter = Encrypter(RSA(publicKey: publicKey));
    return encrypter.encrypt(content).base64;
  }

  /// RAS 解密
  static String decodeRsa({required String content, required String privateKeyStr}) {
    dynamic privateKey = RSAKeyParser().parse(privateKeyStr);
    final encrypter = Encrypter(RSA(privateKey: privateKey));
    return encrypter.decrypt(Encrypted.fromBase64(content));
  }

  /// RAS加密(通过读取public.pem私钥文件)
  static Future<String> encodeRsaLoadByFile({required String content, required String publicKeyFilePath}) async {
    final publicPem = await rootBundle.loadString(publicKeyFilePath);
    return encodeRsa(content: content, publicKeyStr: publicPem);
  }

  /// RAS解密(通过读取private.pem私钥文件)
  static Future<String> decodeRsaLoadByFile({required String content, required String privateKeyFilePath}) async {
    final privatePem = await rootBundle.loadString(privateKeyFilePath);
    return decodeRsa(content: content, privateKeyStr: privatePem);
  }

  /// md5 加密
  static String encodeMd5(String data) {
    var content = const Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  /// md5 解密
  static String decodeMd5(String data) {
    var content = const Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  /// Base64加密
  static String encodeBase64(String data) {
    var content = utf8.encode(data);
    var digest = base64Encode(content);
    return digest;
  }

  /// Base64解密
  static String decodeBase64(String data) {
    List<int> bytes = base64Decode(data);
    String result = utf8.decode(bytes);
    return result;
  }
}
