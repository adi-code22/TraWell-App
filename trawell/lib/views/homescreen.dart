import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trawell/main.dart';
import 'package:trawell/views/locatenative.dart';
import 'package:trawell/views/market.dart';
import 'package:trawell/views/scanScreen.dart';
import 'package:trawell/views/speakNative.dart';
import 'package:trawell/views/suggestplan.dart';
import 'package:trawell/views/travelcard.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String subAdminArea = "";
  String postal = "";
  Placemark place = Placemark();

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    setState(() {
      place = placemarks[0];
    });
  }

  initialiseLocation() async {
    Position pos = await _getGeoLocationPosition();
    await GetAddressFromLatLong(pos);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initialiseLocation();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title.toString()),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body.toString())],
                  ),
                ),
              );
            });
      }
    });
  }

  void showNotification() {
    setState(() {
      _counter++;
    });
    flutterLocalNotificationsPlugin.show(
        0,
        "⚠ Warning",
        "Tourists are advised to refrain from entering waterbodies as waterlevels are increasing!",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   centerTitle: true,
      //   title: RichText(
      //       text: TextSpan(
      //           style: GoogleFonts.poppins(
      //               fontSize: 40, fontWeight: FontWeight.bold),
      //           children: [
      //         TextSpan(
      //             text: "tra",
      //             style: GoogleFonts.poppins(
      //                 color: Theme.of(context).primaryColorLight)),
      //         TextSpan(
      //             text: "well",
      //             style: GoogleFonts.poppins(
      //                 color: Theme.of(context).primaryColor)),
      //       ])),
      // ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 750,
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
                Container(
                  height: 350,
                  width: 400,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: AssetImage("assets/tem.png")),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 90),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hey!\nWelcome to",
                          style: GoogleFonts.poppins(
                              fontSize: 23, color: Colors.white),
                        ),
                        Text(
                          "Thrissur",
                          //place.subAdministrativeArea.toString(),
                          style: GoogleFonts.poppins(
                              fontSize: 23,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Text(
                              "Postal Code: ",
                              style: GoogleFonts.poppins(
                                  fontSize: 13, color: Colors.white),
                            ),
                            Text(
                              "680009",
                              //place.postalCode.toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 39.0, right: 20),
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 100,
                              width: 100,
                              child: const Image(
                                  image: AssetImage("assets/trawellw.png")),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 50,
                        // ),
                        // Container(
                        //   width: 200,
                        //   height: 5,
                        //   color: Colors.blue,
                        // )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SpeakNative()));
                      },
                      child: ShadowButton(
                          sname: "Native",
                          fname: "Speak",
                          icon: Icon(
                            Icons.g_translate_rounded,
                            color: Theme.of(context).primaryColor,
                          ),
                          fsize: 11),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) => Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 5.0, sigmaY: 5.0),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.6),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(17),
                                          ),
                                        ),
                                        width: 180,
                                        alignment: FractionalOffset.center,
                                        height: 180,
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.qr_code_scanner_rounded,
                                              size: 40,
                                              color: Colors.white,
                                            ),
                                            RichText(
                                                text: TextSpan(
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 23,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    children: [
                                                  TextSpan(
                                                      text: "Scan",
                                                      style: GoogleFonts.poppins(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColorLight)),
                                                  TextSpan(
                                                      text: "Monument",
                                                      style: GoogleFonts.poppins(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor)),
                                                ])),
                                            SizedBox(
                                              height: 25,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    ScanScreen(
                                                                      flag: 0,
                                                                    )));
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons
                                                          .camera_alt_outlined),
                                                      Text(" Camera")
                                                    ],
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    ScanScreen(
                                                                      flag: 1,
                                                                    )));
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.photo_library),
                                                      Text(" Gallery")
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        )),
                                  ),
                                ));
                      },
                      child: ShadowButton(
                          sname: "Monument",
                          fname: "Scan\n",
                          icon: Icon(
                            Icons.qr_code_scanner_sharp,
                            color: Theme.of(context).primaryColor,
                          ),
                          fsize: 11),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LocateNative()));
                      },
                      child: ShadowButton(
                          sname: "Native",
                          fname: "Locate",
                          icon: Icon(
                            Icons.travel_explore_rounded,
                            color: Theme.of(context).primaryColor,
                          ),
                          fsize: 11),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SuggestPlan(),
                            ));
                      },
                      child: ShadowButton(
                          fname: 'Suggest',
                          sname: "Plan",
                          icon: Icon(
                            Icons.auto_graph_rounded,
                            color: Theme.of(context).primaryColor,
                          ),
                          fsize: 11),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TravelCard()));
                      },
                      child: ShadowButton(
                          fname: 'Travel',
                          sname: "Card",
                          icon: Icon(
                            Icons.card_membership_rounded,
                            color: Theme.of(context).primaryColor,
                          ),
                          fsize: 11),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DesName(
                        fname: "Native",
                        sname: "Market",
                        size: 30,
                      )),
                ),
                Container(
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).primaryColorLight.withOpacity(0.2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(17),
                      ),
                    ),
                    width: 350,
                    alignment: FractionalOffset.center,
                    height: 420,
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        Row(
                          children: [
                            Container(
                              width: 150,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Container(
                            //   decoration: BoxDecoration(
                            //       color: Colors.blue,
                            //       borderRadius: BorderRadius.circular(16)),
                            //   width: 130,
                            //   height: 200,
                            //   child: Builder(
                            //     builder: (context) {
                            //       return Container(
                            //         child: Image(
                            //             image: NetworkImage(
                            //                 "https://images.marico.in/uploads/img-0010-shutterstock-1549188695-4610.jpg")),
                            //       );
                            //     }
                            //   ),
                            // )
                            marketCard(
                                url:
                                    "https://images.marico.in/uploads/img-0010-shutterstock-1549188695-4610.jpg",
                                name: "Coconut Oil",
                                sub: "250 ml"),
                            marketCard(
                                url:
                                    "https://m.media-amazon.com/images/I/71l5T4sy6QL._UL1500_.jpg",
                                name: "Slipper",
                                sub: "Thrissur"),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            marketCard(
                                url:
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc7aQH_vy7yfJ7xrmVSnDh9mKr93HXdHtj5A&usqp=CAU",
                                name: "Soap",
                                sub: "Irinjalakuda")
                          ],
                        )
                      ]),
                    )),

                SizedBox(height: 00),

                //

                //

                //
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: GestureDetector(
                //     onTap: () async {
                //       Position pos = await _getGeoLocationPosition();
                //       await GetAddressFromLatLong(pos);
                //     },
                //     child: Row(
                //       children: [
                //         CircleAvatar(
                //           radius: 15,
                //           backgroundColor: Theme.of(context).primaryColorLight,
                //           child: Icon(
                //             Icons.pin_drop_outlined,
                //             color: Colors.white,
                //             size: 15,
                //           ),
                //         ),
                //         Text(
                //           "  Refresh Location?",
                //           style: GoogleFonts.inconsolata(fontSize: 15),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                // Text(
                //   "Welcome to,",
                //   style: GoogleFonts.inter(
                //       fontSize: 15, fontWeight: FontWeight.bold),
                // ),
                // Text(
                //   place.subAdministrativeArea.toString(),
                //   style: GoogleFonts.roboto(fontSize: 35),
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     Text(
                //       "Locality: ${place.locality}",
                //       style: GoogleFonts.inter(fontSize: 15),
                //     ),
                //     Text(
                //       "Postal: ${place.postalCode}",
                //       style: GoogleFonts.inter(
                //         fontSize: 15,
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Padding(
                //     padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.only(
                //           topRight: Radius.circular(20),
                //           bottomRight: Radius.circular(20)),
                //       child: Container(
                //         height: 40,
                //         color: Theme.of(context).primaryColor,
                //         child: Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Text(
                //             "Things to do in ${place.subAdministrativeArea}          ",
                //             style: GoogleFonts.roboto(
                //                 fontSize: 18, color: Colors.white),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

                // //SPEAK NATIVE

                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       GestureDetector(
                //         onTap: () {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                 builder: (context) => SpeakNative(),
                //               ));
                //         },
                //         child: Container(
                //           decoration: BoxDecoration(
                //               gradient: LinearGradient(
                //                 begin: Alignment.topRight,
                //                 end: Alignment.bottomLeft,
                //                 colors: [
                //                   Theme.of(context).primaryColor,
                //                   Theme.of(context).primaryColorLight
                //                 ],
                //               ),
                //               borderRadius: BorderRadius.circular(20),
                //               color: Theme.of(context).primaryColorLight,
                //               border: Border.all(
                //                   color: Theme.of(context).primaryColorLight,
                //                   width: 3)),
                //           height: 140,
                //           width: 165,
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //             children: [
                //               Icon(
                //                 Icons.translate,
                //                 size: 50,
                //                 color: Colors.white,
                //               ),
                //               Text(
                //                 "Speak Native",
                //                 style: GoogleFonts.aBeeZee(
                //                     color: Colors.white,
                //                     fontWeight: FontWeight.bold),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),

                //       //NATIVE MARKET

                //       GestureDetector(
                //         onTap: () {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                 builder: (context) => MarketPage(),
                //               ));
                //         },
                //         child: Container(
                //           decoration: BoxDecoration(
                //               gradient: LinearGradient(
                //                 begin: Alignment.topRight,
                //                 end: Alignment.bottomLeft,
                //                 colors: [
                //                   Theme.of(context).primaryColorLight,
                //                   Theme.of(context).primaryColor,
                //                 ],
                //               ),
                //               borderRadius: BorderRadius.circular(20),
                //               color: Theme.of(context).primaryColor,
                //               border: Border.all(
                //                   color: Theme.of(context).primaryColorLight,
                //                   width: 3)),
                //           height: 140,
                //           width: 165,
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //             children: [
                //               Icon(
                //                 Icons.shopify_rounded,
                //                 size: 50,
                //                 color: Colors.white,
                //               ),
                //               Text(
                //                 "Native market",
                //                 style: GoogleFonts.aBeeZee(
                //                     color: Colors.white,
                //                     fontWeight: FontWeight.bold),
                //               ),
                //             ],
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // ),

                // //SCAN MONUMENT

                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       GestureDetector(
                //         onTap: () {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                 builder: (context) => ScanScreen(),
                //               ));
                //         },
                //         child: Container(
                //           decoration: BoxDecoration(
                //               gradient: LinearGradient(
                //                 begin: Alignment.topRight,
                //                 end: Alignment.bottomLeft,
                //                 colors: [
                //                   Theme.of(context).primaryColor,
                //                   Theme.of(context).primaryColorLight,
                //                 ],
                //               ),
                //               borderRadius: BorderRadius.circular(20),
                //               color: Theme.of(context).primaryColor,
                //               border: Border.all(
                //                   color: Theme.of(context).primaryColorLight,
                //                   width: 3)),
                //           height: 140,
                //           width: 165,
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //             children: [
                //               Icon(
                //                 Icons.qr_code_scanner_sharp,
                //                 size: 50,
                //                 color: Colors.white,
                //               ),
                //               Text(
                //                 "Scan Monument",
                //                 style: GoogleFonts.aBeeZee(
                //                     color: Colors.white,
                //                     fontWeight: FontWeight.bold),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //       GestureDetector(
                //         onTap: () {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                 builder: (context) => TravelCard(),
                //               ));
                //         },
                //         child: Container(
                //           decoration: BoxDecoration(
                //               gradient: LinearGradient(
                //                 begin: Alignment.topRight,
                //                 end: Alignment.bottomLeft,
                //                 colors: [
                //                   Theme.of(context).primaryColorLight,
                //                   Theme.of(context).primaryColor,
                //                 ],
                //               ),
                //               borderRadius: BorderRadius.circular(20),
                //               color: Theme.of(context).primaryColor,
                //               border: Border.all(
                //                   color: Theme.of(context).primaryColorLight,
                //                   width: 3)),
                //           height: 140,
                //           width: 165,
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //             children: [
                //               Icon(
                //                 Icons.card_membership_sharp,
                //                 size: 50,
                //                 color: Colors.white,
                //               ),
                //               Text(
                //                 "Travel Card",
                //                 style: GoogleFonts.aBeeZee(
                //                     color: Colors.white,
                //                     fontWeight: FontWeight.bold),
                //               ),
                //             ],
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // ),

                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       GestureDetector(
                //         onTap: () {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (context) => SuggestPlan()));
                //         },
                //         child: Container(
                //           decoration: BoxDecoration(
                //               gradient: LinearGradient(
                //                 begin: Alignment.topRight,
                //                 end: Alignment.bottomLeft,
                //                 colors: [
                //                   Theme.of(context).primaryColor,
                //                   Theme.of(context).primaryColorLight,
                //                 ],
                //               ),
                //               borderRadius: BorderRadius.circular(20),
                //               color: Theme.of(context).primaryColor,
                //               border: Border.all(
                //                   color: Theme.of(context).primaryColorLight,
                //                   width: 3)),
                //           height: 140,
                //           width: 165,
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //             children: [
                //               Icon(
                //                 Icons.gamepad_outlined,
                //                 size: 50,
                //                 color: Colors.white,
                //               ),
                //               Text(
                //                 "Suggest a Plan",
                //                 style: GoogleFonts.aBeeZee(
                //                     color: Colors.white,
                //                     fontWeight: FontWeight.bold),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //       GestureDetector(
                //         onDoubleTap: showNotification,
                //         onTap: () {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (context) => LocateNative()));
                //         },
                //         child: Container(
                //           decoration: BoxDecoration(
                //               gradient: LinearGradient(
                //                 begin: Alignment.topRight,
                //                 end: Alignment.bottomLeft,
                //                 colors: [
                //                   Theme.of(context).primaryColorLight,
                //                   Theme.of(context).primaryColor,
                //                 ],
                //               ),
                //               borderRadius: BorderRadius.circular(20),
                //               color: Theme.of(context).primaryColorLight,
                //               border: Border.all(
                //                   color: Theme.of(context).primaryColorLight,
                //                   width: 3)),
                //           height: 140,
                //           width: 165,
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //             children: [
                //               Icon(
                //                 Icons.pin_drop,
                //                 size: 50,
                //                 color: Colors.white,
                //               ),
                //               Text(
                //                 "Locate Native",
                //                 style: GoogleFonts.aBeeZee(
                //                     color: Colors.white,
                //                     fontWeight: FontWeight.bold),
                //               ),
                //             ],
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class marketCard extends StatefulWidget {
  const marketCard(
      {Key? key, required this.url, required this.name, required this.sub})
      : super(key: key);

  final String url;
  final String name;
  final String sub;
  @override
  State<marketCard> createState() => _marketCardState();
}

class _marketCardState extends State<marketCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.black,
      ),
      width: 150,
      height: 230,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.blue,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(widget.url),
                )),
            width: 135,
            height: 160,
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                widget.sub,
                style: TextStyle(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ShadowButton extends StatefulWidget {
  const ShadowButton(
      {Key? key,
      required this.fname,
      required this.sname,
      required this.icon,
      required this.fsize})
      : super(key: key);

  final String fname;
  final String sname;
  final Icon icon;
  final double fsize;

  @override
  State<ShadowButton> createState() => _ShadowButtonState();
}

class _ShadowButtonState extends State<ShadowButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 105,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColorLight),
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(0.10),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          widget.icon,
          DesName(fname: widget.fname, sname: widget.sname, size: widget.fsize)
        ],
      ),
    );
  }
}

class DesName extends StatefulWidget {
  const DesName({
    Key? key,
    required this.fname,
    required this.sname,
    required this.size,
  }) : super(key: key);

  final String fname;
  final String sname;
  final double size;

  @override
  State<DesName> createState() => _DesNameState();
}

class _DesNameState extends State<DesName> {
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            style: GoogleFonts.poppins(
                fontSize: widget.size, fontWeight: FontWeight.bold),
            children: [
          TextSpan(
              text: widget.fname,
              style: GoogleFonts.poppins(
                  color: Theme.of(context).primaryColorLight)),
          TextSpan(
              text: widget.sname,
              style:
                  GoogleFonts.poppins(color: Theme.of(context).primaryColor)),
        ]));
  }
}
