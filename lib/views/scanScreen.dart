import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:tflite/tflite.dart';
import 'package:trawell/views/homescreen.dart';
import 'package:trawell/views/mail.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key, required this.flag}) : super(key: key);
  final int flag;
  @override
  _DiseaseDetectionState createState() => _DiseaseDetectionState();
}

class _DiseaseDetectionState extends State<ScanScreen> {
  List _outputs = [];
  List<String> speach = [
    "Athirappilly Falls, is situated in Athirappilly Panchayat, Chalakudy Taluk, Thrissur District of Kerala, India on the Chalakudy River, which originates from the upper reaches of the Western Ghats at the entrance to the Sholayar ranges.It is the largest waterfall in Kerala, which stands tall at 80 feet.",
    "The significance of Cheraman Juma Majsid in the Muziris Heritage Project lies in the fact that it is the first mosque in India. Built in 629 AD by Malik Ibn Dinar it is located in the district of Thrissur in Kerala, on the Paravur-Kodungallur road.The oral tradition is that Cheraman Perumal, the Chera king, went to Arabia where he met the Prophet and embraced Islam. From there he had sent letters with Malik Ibn Dinar to his relatives in Kerala, asking them to be courteous to the latter."
  ];
  XFile? _image;
  bool _loading = false;
  // int _selectedIndex = 1;
  bool isPlaying = false;

  FlutterTts flutterTts = FlutterTts();

  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(0.8);
    await flutterTts.speak(text);
  }

  stop() async {
    await flutterTts.stop();
  }

  loadModel() async {
    await Tflite.loadModel(
      model:
          false ? "assets/unquant2.tflite" : "assets/model_new_unquant.tflite",
      labels: "assets/model_new_unquant_labels.txt",
      numThreads: 1,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });

    widget.flag == 0 ? captureImage() : pickImage();
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.5,
        asynch: true);
    setState(() {
      _loading = false;
      _outputs = output!;
    });
  }

  Widget transitonImage = Container(
      child: FadeInImage(
    image: AssetImage("assets/bot.png"),
    fadeOutDuration: const Duration(milliseconds: 3000),
    fadeOutCurve: Curves.bounceIn,
    placeholder: AssetImage("assets/bot.png"),
  ));

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  //   if (index == 0) {
  //     captureImage();
  //   } else if (index == 2) {
  //     pickImage();
  //   } else if (index == 1) {
  //     Navigator.pushNamed(context, '/home');
  //   }
  // }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  Future pickImage() async {
    final pick = ImagePicker();
    var image = await pick.pickImage(source: ImageSource.gallery);
    if (image == null) {
      Navigator.pop(context);
      return null;
    }
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(File(_image!.path));
    print(_outputs);
  }

  captureImage() async {
    ImagePicker pick = ImagePicker();
    var image = await pick.pickImage(source: ImageSource.camera);
    if (image == null) {
      Navigator.pop(context);
      return null;
    }
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(File(_image!.path));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // bottomNavigationBar: BottomNavigationBar(
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.camera),
        //       label: 'Camera',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.image),
        //       label: 'Gallery',
        //     ),
        //   ],
        //   currentIndex: _selectedIndex,
        //   selectedItemColor: Theme.of(context).primaryColorLight,
        //   onTap: _onItemTapped,
        // ),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 680,
                    width: 400,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          opacity: 0.55,
                          fit: BoxFit.cover,
                          image: AssetImage("assets/bg.png")),
                    ),
                  ),

                  // ColorFiltered(
                  //     colorFilter: ColorFilter.mode(
                  //         Colors.white.withOpacity(0.5), BlendMode.dstATop),
                  //     child: Image.asset("assets/bg.png")),
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.black,
                            )),
                        //
                        //const DesName(fname: "Scan", sname: "Monument", size: 25),
                        RichText(
                            text: TextSpan(
                                style: GoogleFonts.poppins(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                                children: [
                              TextSpan(
                                  text: "Scan",
                                  style: GoogleFonts.poppins(
                                      color:
                                          Theme.of(context).primaryColorLight)),
                              TextSpan(
                                  text: "Monument",
                                  style: GoogleFonts.poppins(
                                      color: Theme.of(context).primaryColor)),
                            ])),
                        Container(
                          height: 50,
                          width: 50,
                          child: Image.asset("assets/logo.png"),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Stack(
                          children: [
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  width: 320,
                                  color: Colors.grey.withOpacity(0.2),
                                  child: _outputs[0]["confidence"] > 0.975
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            _loading
                                                ? Container(
                                                    height: 300,
                                                    width: 300,
                                                  )
                                                : Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            20),
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        _image == null
                                                            ? Container()
                                                            : Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                16),
                                                                        color: Colors
                                                                            .blue,
                                                                        image:
                                                                            DecorationImage(
                                                                          fit: BoxFit
                                                                              .fill,
                                                                          image:
                                                                              FileImage(
                                                                            File(
                                                                              _image!.path,
                                                                            ),
                                                                          ),
                                                                        )),
                                                                width: 300,
                                                                height: 300,
                                                              ),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        _image == null
                                                            ? Container()
                                                            : _outputs != null
                                                                ? Column(
                                                                    children: [
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            ElevatedButton(
                                                                          style:
                                                                              ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: const BorderRadius.only(topLeft: Radius.circular(0), bottomLeft: Radius.circular(0), topRight: Radius.circular(16), bottomRight: Radius.circular(16)), side: BorderSide(color: Theme.of(context).primaryColor)))),
                                                                          onPressed:
                                                                              () {
                                                                            isPlaying
                                                                                ? stop()
                                                                                : speak(speach[int.parse(_outputs[0]["label"].toString().substring(0, 1))]);

                                                                            setState(() {
                                                                              isPlaying = !isPlaying;
                                                                            });
                                                                          },
                                                                          child: !isPlaying
                                                                              ? const Text("Read out 🔊")
                                                                              : const Text("Stop 🛑"),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        _outputs[0]["label"]
                                                                            .toString()
                                                                            .substring(
                                                                              2,
                                                                            )
                                                                            .toUpperCase(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Theme.of(context).primaryColor,
                                                                            fontSize: 20),
                                                                      ),
                                                                      Text(_outputs[0]
                                                                              [
                                                                              "confidence"]
                                                                          .toString()),

                                                                      //_outputs[0]["label"]=="2 banana_black_sigatoka"Text('Good')?null:
                                                                      Text(_outputs[0]["label"] ==
                                                                              "0 Athirapilly"
                                                                          ? speach[
                                                                              0]
                                                                          : _outputs[0]["label"] == "1 Cheraman Mosque"
                                                                              ? speach[1]
                                                                              : ''),
                                                                    ],
                                                                  )
                                                                : Container(
                                                                    child:
                                                                        const Text(
                                                                            "")),
                                                        Column(
                                                          children: [
                                                            Container(
                                                              height: 3,
                                                            ),
                                                            Container(
                                                              height: 3,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                            // SizedBox(
                                            //   height:
                                            //       MediaQuery.of(context).size.height * 0.01,
                                            // ),
                                          ],
                                        )
                                      : Text("Can't Recognize the Image"),
                                ),
                              ),
                            ),
                            !isPlaying
                                ? Positioned(
                                    top: 140,
                                    left: 100,
                                    child: Container(
                                        height: 300,
                                        width: 300,
                                        child: transitonImage))
                                : SizedBox(),
                          ],
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SentMail()),
                              );
                            },
                            child: const Text("Couldn't find your Answer?")),

                        // FlatButton(
                        //     color: Theme.of(context).primaryColor,
                        //     textColor: Colors.white,
                        //     disabledColor: Colors.grey,
                        //     disabledTextColor: Colors.black,
                        //     padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
                        //     splashColor: Theme.of(context).primaryColorLight,
                        //     onPressed: () {},
                        //     child: const Text('''Couldn't Find Your Answer!''')),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:tflite/tflite.dart';
// import 'package:trawell/views/mail.dart';

// class ScanScreen extends StatefulWidget {
//   const ScanScreen({Key? key, required this.flag}) : super(key: key);

//   final int flag;
//   @override
//   _DiseaseDetectionState createState() => _DiseaseDetectionState();
// }

// class _DiseaseDetectionState extends State<ScanScreen> {
//   List _outputs = [];
//   List<String> speach = [
//     "Madhur temple was originally ShrimadAnantheswara (Shiva) Temple and as the lore goes, an old woman called Madaru from the local Tulu Moger Community discovered an 'Udbhava Murthy' (a statue that was not made by a human) of shiva linga. Initially, the Ganapathy picture was drawn by a boy, on the southern wall of the Garbhagriha(sanctum sanctorum) while playing.",
//     "It was at this place where Divakara Muni Vilwamangalam, the great Tulu Brahmin sage, did penance and performed poojas. Legend has it that one day Lord Narayana appeared before him as a child. The boy’s face was glowing with radiance and this overwhelmed the sage.",
//     "It was an important military station for Tipu Sultan when he led a military expedition to capture Malabar. The coins and artefacts found in archaeological excavations at Bekal fort indicate the strong presence of Mysore Sultans. Tipu Sultan's death during the Fourth Anglo-Mysore War ended Mysorean control in 1799."
//   ];
//   XFile? _image;
//   bool _loading = false;
//   int _selectedIndex = 1;
//   bool isPlaying = true;

//   FlutterTts flutterTts = FlutterTts();

//   speak(String text) async {
//     await flutterTts.setLanguage("en-US");
//     await flutterTts.setPitch(1);
//     await flutterTts.speak(text);
//   }

//   stop() async {
//     await flutterTts.stop();
//   }

//   loadModel() async {
//     await Tflite.loadModel(
//       model: true ? "assets/unquant2.tflite" : "assets/quantized.tflite",
//       labels: "assets/labels2.txt",
//       numThreads: 1,
//     );
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _loading = true;

//     loadModel().then((value) {
//       setState(() {
//         _loading = false;
//       });
//     });
//   }

//   classifyImage(File image) async {
//     var output = await Tflite.runModelOnImage(
//         path: image.path,
//         imageMean: 0.0,
//         imageStd: 255.0,
//         numResults: 2,
//         threshold: 0.5,
//         asynch: true);
//     setState(() {
//       _loading = false;
//       _outputs = output!;
//     });
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     if (index == 0) {
//       captureImage();
//     } else if (index == 2) {
//       pickImage();
//     } else if (index == 1) {
//       Navigator.pushNamed(context, '/home');
//     }
//   }

//   @override
//   void dispose() {
//     Tflite.close();
//     super.dispose();
//   }

//   Future pickImage() async {
//     final pick = ImagePicker();
//     var image = await pick.pickImage(source: ImageSource.gallery);
//     if (image == null) return null;
//     setState(() {
//       _loading = true;
//       _image = image;
//     });
//     classifyImage(File(_image!.path));
//   }

//   captureImage() async {
//     ImagePicker pick = ImagePicker();
//     var image = await pick.pickImage(source: ImageSource.camera);
//     if (image == null) return null;
//     setState(() {
//       _loading = true;
//       _image = image;
//     });
//     classifyImage(File(_image!.path));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: RichText(
//               text: TextSpan(
//                   style: GoogleFonts.poppins(
//                       fontSize: 30, fontWeight: FontWeight.bold),
//                   children: [
//                 TextSpan(
//                     text: "Scan",
//                     style: GoogleFonts.poppins(
//                         color: Theme.of(context).primaryColorLight)),
//                 TextSpan(
//                     text: "Monument",
//                     style: GoogleFonts.poppins(
//                         color: Theme.of(context).primaryColor)),
//               ])),
//           backgroundColor: Colors.white,
//           //elevation: 0,
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(Icons.camera),
//               label: 'Camera',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.image),
//               label: 'Gallery',
//             ),
//           ],
//           currentIndex: _selectedIndex,
//           selectedItemColor: Theme.of(context).primaryColorLight,
//           onTap: _onItemTapped,
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             color: Colors.white,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 _loading
//                     ? Container(
//                         height: 300,
//                         width: 300,
//                       )
//                     : Container(
//                         margin: const EdgeInsets.all(20),
//                         width: MediaQuery.of(context).size.width,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             _image == null
//                                 ? Container()
//                                 : Image.file(
//                                     File(_image!.path),
//                                     // scale: 3,
//                                   ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             _image == null
//                                 ? Container()
//                                 : _outputs != null
//                                     ? Column(
//                                         children: [
//                                           Text(
//                                             _outputs[0]["label"]
//                                                 .toString()
//                                                 .toUpperCase(),
//                                             style: TextStyle(
//                                                 color: Theme.of(context)
//                                                     .primaryColor,
//                                                 fontSize: 20),
//                                           ),

//                                           //_outputs[0]["label"]=="2 banana_black_sigatoka"Text('Good')?null:
//                                           Text(_outputs[0]["label"] ==
//                                                   "0 Madhur Sri Madanantheshwara Siddhivinaya"
//                                               ? "Madhur temple was originally ShrimadAnantheswara (Shiva) Temple and as the lore goes, an old woman called Madaru from the local Tulu Moger Community discovered an 'Udbhava Murthy' (a statue that was not made by a human) of shiva linga. Initially, the Ganapathy picture was drawn by a boy, on the southern wall of the Garbhagriha(sanctum sanctorum) while playing."
//                                               : _outputs[0]["label"] ==
//                                                       "1 Lake Temple"
//                                                   ? 'It was at this place where Divakara Muni Vilwamangalam, the great Tulu Brahmin sage, did penance and performed poojas. Legend has it that one day Lord Narayana appeared before him as a child. The boy’s face was glowing with radiance and this overwhelmed the sage.'
//                                                   : _outputs[0]["label"] ==
//                                                           "2 Bakel Fort"
//                                                       ? "It was an important military station for Tipu Sultan when he led a military expedition to capture Malabar. The coins and artefacts found in archaeological excavations at Bekal fort indicate the strong presence of Mysore Sultans. Tipu Sultan's death during the Fourth Anglo-Mysore War ended Mysorean control in 1799."
//                                                       : ''),
//                                           ElevatedButton(
//                                             style: ElevatedButton.styleFrom(
//                                                 primary: Theme.of(context)
//                                                     .primaryColor),
//                                             onPressed: () {
//                                               setState(() {
//                                                 isPlaying = !isPlaying;
//                                               });
//                                               isPlaying
//                                                   ? stop()
//                                                   : speak(speach[int.parse(
//                                                       _outputs[0]["label"]
//                                                           .toString()
//                                                           .substring(0, 1))]);
//                                             },
//                                             child: isPlaying
//                                                 ? Text("Read out ▶")
//                                                 : Text("Stop ⏹"),
//                                           ),
//                                         ],
//                                       )
//                                     : Container(child: const Text("")),
//                             Column(
//                               children: [
//                                 Container(
//                                   height: 3,
//                                 ),
//                                 FlatButton(
//                                     color: Theme.of(context).primaryColor,
//                                     textColor: Colors.white,
//                                     disabledColor: Colors.grey,
//                                     disabledTextColor: Colors.black,
//                                     padding: const EdgeInsets.fromLTRB(
//                                         50, 20, 50, 20),
//                                     splashColor:
//                                         Theme.of(context).primaryColorLight,
//                                     onPressed: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => SentMail()),
//                                       );
//                                     },
//                                     child: const Text(
//                                         '''Couldn't Find Your Answer!''')),
//                                 Container(
//                                   height: 3,
//                                 ),
//                                 // FlatButton(
//                                 //     color: Colors.green[300],
//                                 //     textColor: Colors.white,
//                                 //     disabledColor: Colors.grey,
//                                 //     disabledTextColor: Colors.black,
//                                 //     padding: const EdgeInsets.fromLTRB(
//                                 //         60, 20, 60, 20),
//                                 //     splashColor: Colors.greenAccent,
//                                 //     onPressed: () {
//                                 //       Navigator.pushNamed(context, '/location');
//                                 //     },
//                                 //     child:
//                                 //         const Text('Fertilizer Store Location'))
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.01,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
