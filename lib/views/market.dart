import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:trawell/main.dart';
import 'package:trawell/models/api_post.dart';
import 'package:trawell/models/api_service.dart';
import 'package:trawell/models/market_model.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  late List<UserModel>? _userModel = [];
  bool selected = false;
  int itemNumber = 0;
  List<String> buyList = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _userModel = (await ApiService().getUsers())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  bool switchController() {
    return !selected;
  }

  void showNotification() {
    flutterLocalNotificationsPlugin.show(
        0,
        "Hooray!",
        "You just ordered a product from trawell!",
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
                  text: "Native",
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).primaryColorLight)),
              TextSpan(
                  text: "Market",
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).primaryColor)),
            ])),
      ),
      // floatingActionButton: ClipRRect(
      //   borderRadius: BorderRadius.circular(15),
      //   child: GestureDetector(
      //     onTap: () async {
      //       print(buyList);
      //     },
      //     child: Container(
      //       color: Theme.of(context).primaryColorLight,
      //       height: 75,
      //       width: 125,
      //       child: Row(
      //         children: [
      //           Icon(
      //             Icons.shopping_bag_rounded,
      //             color: Colors.white,
      //             size: 40,
      //           ),
      //           Text(
      //             "BUY ",
      //             style: TextStyle(color: Colors.white, fontSize: 20),
      //           ),
      //           CircleAvatar(
      //             radius: 18,
      //             child: Text(
      //               itemNumber.toString(),
      //               style: TextStyle(fontSize: 20),
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: _userModel!.length,
        itemBuilder: (context, index) {
          // return ListTile(
          //   selectedColor: Colors.amber,
          //   subtitle: Text(_userModel![index].description.toString()),
          //   title: Text(_userModel![index].itemName.toString()),
          //   leading: CircleAvatar(
          //     backgroundImage: NetworkImage(_userModel![index].img),
          //   ),
          //   trailing: Text(
          //     "₹" + _userModel![index].price.toString(),
          //     style: TextStyle(color: Colors.green, fontSize: 20),
          //   ),
          // );

          return GestureDetector(
            onTap: () {
              print(_userModel![index].description);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).primaryColor,
                ),
                height: 180,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 130,
                          // color: Colors.black,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(_userModel![index].img))),
                        ),
                      ),
                    ),
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          _userModel![index].itemName,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 185,
                          child: Text(
                            _userModel![index].description,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 0,
                        ),
                        // Row(
                        //   children: [
                        //     SizedBox(
                        //       width: 120,
                        //     ),
                        //     ElevatedButton(
                        //       onPressed: () async {
                        //         setState(() {
                        //           itemNumber++;
                        //         });
                        //         buyList.add(_userModel![index].itemId);
                        //         await ApiServicePost()
                        //             .post(_userModel![index].itemId.toString());
                        //         print(_userModel![index].itemId.toString());
                        //         showNotification();
                        //       },
                        //       child: Text("BUY"),
                        //       style: ElevatedButton.styleFrom(
                        //           primary: Theme.of(context).primaryColorLight),
                        //     )
                        //   ],
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(left: 122.0),
                          child: Text(
                            "₹" + _userModel![index].price.toString(),
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ),
                        Container(
                          width: 185,
                          child: Row(
                            children: [
                              Icon(Icons.pin_drop),
                              Text(
                                _userModel![index].location,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
