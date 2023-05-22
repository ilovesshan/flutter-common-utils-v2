import 'package:common_utils_v2/common_utils_v2.dart';
import 'package:encrypt/encrypt.dart';

/// RAS 加密工具
class RsaUtil {
  static String encode(String publicKey, String content) {
    final RSAAsymmetricKey rsaAsymmetricKey = RSAKeyParser().parse(publicKey);
    final encrypted = Encrypter(RSA(publicKey: rsaAsymmetricKey as RSAPublicKey));
    return encrypted.encrypt(content).base64;
  }
}
