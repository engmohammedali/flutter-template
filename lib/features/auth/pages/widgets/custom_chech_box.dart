import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomChechBox extends StatelessWidget {
  final void Function() onTap;
  final bool isAccepted;
  const CustomChechBox(
      {super.key, required this.onTap, required this.isAccepted});
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'لا يمكن فتح الرابط $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              height: 24.0,
              width: 24.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: isAccepted
                  ? Icon(Icons.check, color: Colors.blue, size: 20.0)
                  : null,
            ),
          ),
          TextButton(
            onPressed: () async {
              _launchURL('https://flutter.dev');
            },
            child: Text('Accept privacy policy'),
          ),
        ],
      ),
    );
  }
}
