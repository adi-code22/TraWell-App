import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SpeakNative extends StatefulWidget {
  const SpeakNative({Key? key}) : super(key: key);

  @override
  State<SpeakNative> createState() => _SpeakNativeState();
}

class _SpeakNativeState extends State<SpeakNative> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 7,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: RichText(
            text: TextSpan(
                style: GoogleFonts.poppins(
                    fontSize: 30, fontWeight: FontWeight.bold),
                children: [
              TextSpan(
                  text: "Speak",
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).primaryColorLight)),
              TextSpan(
                  text: "Native",
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).primaryColor)),
            ])),
      ),
      body: SafeArea(
        child: Stack(children: [
          WebView(
            initialUrl: "https://translate.google.com/",
            backgroundColor: Theme.of(context).primaryColorLight,
            javascriptMode: JavascriptMode.unrestricted,
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              color: Colors.white,
              height: 110,
              width: 400,
            ),
          ),
        ]),
      ),
    );
  }
}
