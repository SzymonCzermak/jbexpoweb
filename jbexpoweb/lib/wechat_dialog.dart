import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class WeChatDialog extends StatelessWidget {
  final bool isPolish;
  final Gradient borderGradient;

  const WeChatDialog({
    Key? key,
    required this.isPolish,
    required this.borderGradient,
  }) : super(key: key);

  final String phoneNumber = '+48 515 000 868';
  final String wechatUrl = 'https://www.wechat.com/en/';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          gradient: borderGradient,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(18),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "WeChat",
                    style: GoogleFonts.openSans(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 185, 0),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildWeChatItem(
                    context: context,
                    icon: Icons.chat_bubble_outline,
                    text: wechatUrl,
                    color: Colors.green,
                    isLink: true,
                  ),
                  const SizedBox(height: 15),
                  _buildWeChatItem(
                    context: context,
                    icon: Icons.phone_android,
                    text: phoneNumber,
                    color: Colors.lightGreen,
                    isLink: false,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        isPolish ? "Zamknij" : "Close",
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWeChatItem({
    required BuildContext context,
    required IconData icon,
    required String text,
    required Color color,
    required bool isLink,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 30),
        const SizedBox(width: 10),
        Expanded(
          child: SelectableText(
            text,
            style: GoogleFonts.openSans(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              decoration:
                  isLink ? TextDecoration.underline : TextDecoration.none,
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            isLink ? Icons.open_in_new : Icons.copy,
            color: Colors.white70,
          ),
          onPressed: () async {
            if (isLink) {
              if (await canLaunchUrl(Uri.parse(text))) {
                await launchUrl(Uri.parse(text));
              }
            } else {
              Clipboard.setData(ClipboardData(text: text));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Text(isPolish ? "Skopiowano: $text" : "Copied: $text")),
              );
            }
          },
        ),
      ],
    );
  }
}
