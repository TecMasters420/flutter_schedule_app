import 'package:share_plus/share_plus.dart';

class ShareUtil {
  static Future<void> generate(String title, String subject) async {
    await Share.share(
      title,
      subject: subject,
    );
  }
}
