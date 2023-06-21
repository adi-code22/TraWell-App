import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';

class SentMail extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<SentMail> {
  List<String> attachments = [];
  bool isHTML = false;
  XFile? _image;

  final _recipientController = TextEditingController(
    text: 'adityakrishnanp007@gmail.com',
  );

  final _subjectController =
      TextEditingController(text: 'New Monument Detected');

  final _bodyController = TextEditingController(
    text: 'A new monument was detected.\nlocation: 12.4996° N, 74.9869° E',
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Future<void> send() async {
  //   final Email email = Email(
  //     body: _bodyController.text,
  //     subject: _subjectController.text,
  //     recipients: [_recipientController.text],
  //     attachmentPaths: attachments,
  //     isHTML: isHTML,
  //   );

  //   String platformResponse = "";

  //   // try {
  //   //   await FlutterEmailSender.send(email);
  //   // } catch (error) {
  //   //   platformResponse = error.toString();
  //   // }

  //   if (!mounted) return;

  //   // _scaffoldKey.currentState!.showSnackBar(SnackBar(
  //   //   content: Text(platformResponse),
  //   // ));
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        secondaryHeaderColor: Colors.green,
      ),
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Send Mail',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {},
              icon: Icon(Icons.send),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: _recipientController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Recipient',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: _subjectController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Subject',
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _bodyController,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                        labelText: 'Body', border: OutlineInputBorder()),
                  ),
                ),
              ),

              // CheckboxListTile(
              //   contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
              //   title: Text('HTML'),
              //   onChanged: (bool value) {
              //     setState(() {
              //       isHTML = value;
              //     });
              //   },
              //   value: isHTML,
              // ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    for (var i = 0; i < attachments.length; i++)
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              attachments[i],
                              softWrap: false,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.remove_circle),
                            onPressed: () => {_removeAttachment(i)},
                          )
                        ],
                      ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(Icons.attach_file),
                        tooltip: 'Attach Image',
                        onPressed: _openImagePicker,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Future _openImagePicker() async {
    final pick = ImagePicker();
    var image = await pick.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image;
        attachments.add(_image!.path);
      });
    }
  }

  // Future pickImage() async {
  //   final pick = ImagePicker();
  //   var image = await pick.pickImage(source: ImageSource.gallery);
  //   if (image == null) return null;
  //   setState(() {
  //     _image = image;
  //   });
  //   classifyImage(File(_image!.path));
  // }

  void _removeAttachment(int index) {
    setState(() {
      attachments.removeAt(index);
    });
  }
}
