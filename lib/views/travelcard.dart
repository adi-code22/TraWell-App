import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trawell/views/homescreen.dart';

class TravelCard extends StatefulWidget {
  const TravelCard({Key? key}) : super(key: key);

  @override
  State<TravelCard> createState() => _TravelCardState();
}

class _TravelCardState extends State<TravelCard> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
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
                              text: "Travel",
                              style: GoogleFonts.poppins(
                                  color: Theme.of(context).primaryColorLight)),
                          TextSpan(
                              text: "Card",
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
                SizedBox(
                  height: 15,
                ),
                Stack(
                  children: [
                    show
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 400,
                              width: 350,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                // border: Border.all(
                                //     color: Theme.of(context).primaryColorLight),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 200,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "  Reached Kasaragod",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "10",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Travel Points ",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "  Reached Kannur",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "10",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Travel Points ",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "  Reached Thrissur",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "10",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Travel Points ",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Divider()
                                ],
                              ),
                            ),
                          )
                        : SizedBox(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 175,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColorLight),
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/tra2.jpg'))),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      show = !show;
                    });
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          !show
                              ? "See Travelling History!"
                              : "Hide Travelling History!",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Icon(!show
                          ? Icons.keyboard_double_arrow_down_rounded
                          : Icons.keyboard_double_arrow_up_rounded),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => TravelCard(),
                            //     ));
                          },
                          child: ShadowButton(
                            fname: 'Credits\n',
                            fsize: 11,
                            icon: Icon(Icons.price_change),
                            sname: 'Earned',
                          )),
                      GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => TravelCard(),
                            //     ));
                          },
                          child: ShadowButton(
                            fname: 'Distance\n',
                            fsize: 11,
                            icon: Icon(Icons.price_change),
                            sname: 'Covered',
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
