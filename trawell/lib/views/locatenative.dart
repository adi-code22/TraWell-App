import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LocateNative extends StatefulWidget {
  const LocateNative({Key? key}) : super(key: key);

  @override
  State<LocateNative> createState() => _LocateNativeState();
}

class _LocateNativeState extends State<LocateNative> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   title: RichText(
      //       text: TextSpan(
      //           style: GoogleFonts.poppins(
      //               fontSize: 30, fontWeight: FontWeight.bold),
      //           children: [
      //         TextSpan(
      //             text: "Locate",
      //             style: GoogleFonts.poppins(
      //                 color: Theme.of(context).primaryColorLight)),
      //         TextSpan(
      //             text: "Native",
      //             style: GoogleFonts.poppins(
      //                 color: Theme.of(context).primaryColor)),
      //       ])),
      //   centerTitle: true,
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
                        fit: BoxFit.fill, image: AssetImage("assets/bg2.PNG")),
                  ),
                ),

                // ColorFiltered(
                //     colorFilter: ColorFilter.mode(
                //         Colors.white.withOpacity(0.5), BlendMode.dstATop),
                //     child: Image.asset("assets/bg.png")),
              ],
            ),
            // SingleChildScrollView(
            //   child: Column(
            //     children: [
            //       Container(
            //         color: Colors.black38,
            //         width: 400,
            //         height: 30,
            //         child: Center(
            //           child: Text(
            //             "Restaurants",
            //             style: TextStyle(fontSize: 20),
            //           ),
            //         ),
            //       ),
            //       ListTile(
            //         title: Text("Thattakam Kudumbasree Hotel"),
            //         subtitle: Text("9946071797"),
            //         trailing: Text("4.9 kms"),
            //       ),
            //       ListTile(
            //         title: Text("Hotel Kadamba"),
            //         subtitle: Text("9946071797"),
            //         trailing: Text("2 kms"),
            //       ),
            //       ListTile(
            //         title: Text("Darbar Thattukada"),
            //         subtitle: Text("7034480491"),
            //         trailing: Text("2.2 kms"),
            //       ),
            //       Container(
            //         color: Colors.black38,
            //         width: 400,
            //         height: 30,
            //         child: Center(
            //           child: Text(
            //             "Auto/Taxi Stands",
            //             style: TextStyle(fontSize: 20),
            //           ),
            //         ),
            //       ),
            //       ListTile(
            //         title: Text("Autorickshaw Stand Kanyappady"),
            //         subtitle: Text("9946071797"),
            //         trailing: Text("5.3 kms"),
            //       ),
            //       ListTile(
            //         title: Text("Kasargode Municipality Taxi Stand"),
            //         subtitle: Text("9526011662"),
            //         trailing: Text("7.8 kms"),
            //       ),
            //       ListTile(
            //         title: Text("B.M.S Auto stand"),
            //         subtitle: Text("7034480491"),
            //         trailing: Text("9.5 kms"),
            //       ),
            //       // Container(
            //       //   color: Colors.black38,
            //       //   width: 400,
            //       //   height: 30,
            //       //   child: Center(
            //       //     child: Text(
            //       //       "Native Calendar",
            //       //       style: TextStyle(fontSize: 20),
            //       //     ),
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
