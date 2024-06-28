//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:trawell/views/homescreen.dart';
import 'package:trawell/views/market.dart';
import 'package:trawell/views/speakNative.dart';
import 'firebase_options.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('A bg message just showed up :  ${message.messageId}');
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  await Permission.microphone.request();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        focusColor: Color.fromARGB(255, 138, 202, 255),
        hoverColor: Color.fromARGB(255, 55, 78, 142),
        primaryColorLight: Color(0xff3e97c9),
        primaryColor: Color(0xff233f8e),
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}


//your Smart travel buddy, powered by AI. A tourist guide which aids in easy navigation, communication and guidance throughout the journey.
//https://trawel01.netlify.app/


// <div id="top"></div>



// [![Contributors][contributors-shield]][contributors-url]
// [![Forks][forks-shield]][forks-url]
// [![Stargazers][stars-shield]][stars-url]
// [![Issues][issues-shield]][issues-url]
// [![MIT License][license-shield]][license-url]

// [![LinkedIn][linkedin-shield]][linkedin-url]




// <!-- PROJECT LOGO -->

// <br />
// <div align="center">
//   <a href="https://github.com/adi-code22/TraWell-App">
//     <img src="assets/git_images/logo.PNG" alt="Logo" width="800" height="287">
//   </a>

// <h3 align="center">TraWell App</h3>

//   <p align="center">
//     your Smart trawell buddy, Powered by AI.
//     <h4 align="center">Winner, RIBC Rural Agri-Tech Hackathon 2022, Kerala Startup Mission, ICAR-CPCRI</h4>
//     <br />
//     <br />
//     <a href="https://www.youtube.com/watch?v=dg3E_iASbt8">View Demo</a>
//     ·
//     <a href="https://github.com/adi-code22/TraWell-App/issues">Report Bug</a>
//     ·
//     <a href="https://github.com/adi-code22/TraWell-App/issues">Request Feature</a>
//   </p>
// </div>





// <!-- ABOUT THE PROJECT -->
// ## About The Project

// [![Product Name Screen Shot][product-screenshot]](https://example.com)

// <!-- Here's a blank template to get started: To avoid retyping too much info. Do a search and replace with your text editor for the following: `github_username`, `repo_name`, `twitter_handle`, `linkedin_username`, `email_client`, `email`, `project_title`, `project_description` -->

// #### TraWell comes with a cross platform mobile application and a website

// [![Proposed Solutions][solution]](https://example.com)

// ## Features.

// [![ScanMonument][scan]](https://example.com)
// #### Scan monument is basically an ML powered Image Classifier which detects monuments and reads out its historical and heirarchial importance with the help of a text to speach engine.

// [![SpeakNative][speak]](https://example.com)
// #### Speak native is a voice to voice language translator powered by google translate.

// [![Card and Market][card]](https://example.com)
// [![Card and Market][locate]](https://example.com)






// <p align="right">(<a href="#top">back to top</a>)</p>



// ### Built With

// * [![Flutter][Flutter]][Flutter-url]
// * [![ReactJS][React.js]][React-url]
// * [![Tensorflow][Tensorflow]][Tensorflow-url]
// * [![NodeJS][NodeJS]][NodeJS-url]
// * [![ExpressJS][ExpressJS]][ExpressJS-url]


// <p align="right">(<a href="#top">back to top</a>)</p>



// <!-- GETTING STARTED -->
// ## Getting Started

// This is an example of how you may give instructions on setting up your project locally.
// To get a local copy up and running follow these simple example steps.

// ### Prerequisites

// This is an example of how to list things you need to use the software and how to install them.
// * flutter

// ### Installation

// 1. Clone the repo
//    ```sh
//    git clone https://github.com/adi-code22/TraWell-App.git
//    ```
// 2. Direct to root folder and run flutter project
//    ```sh
//    flutter run
//    ```


// <p align="right">(<a href="#top">back to top</a>)</p>



// <!-- CONTRIBUTING -->
// ## Contributing

// Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

// If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
// Don't forget to give the project a star! Thanks again!

// 1. Fork the Project
// 2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
// 3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
// 4. Push to the Branch (`git push origin feature/AmazingFeature`)
// 5. Open a Pull Request

// <p align="right">(<a href="#top">back to top</a>)</p>



// <!-- LICENSE -->
// ## License

// Distributed under the MIT License. See `LICENSE.md` for more information.

// <p align="right">(<a href="#top">back to top</a>)</p>



// <!-- CONTACT -->
// ## Contact

// Your Name - Adityakrishnan [adityakrishnanp007@gmail.com]

// Twitter [@AdityakrishnanP](https://twitter.com/AdityakrishnanP)

// Project Link: [https://github.com/adi-code22/TraWell-App](https://github.com/adi-code22/TraWell-App)

// <p align="right">(<a href="#top">back to top</a>)</p>



// <!-- MARKDOWN LINKS & IMAGES -->
// <!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
// [contributors-shield]: https://img.shields.io/github/contributors/adi-code22/TraWell-App.svg?style=for-the-badge
// [contributors-url]: https://github.com/adi-code22/TraWell-App/graphs/contributors
// [forks-shield]: https://img.shields.io/github/forks/adi-code22/TraWell-App.svg?style=for-the-badge
// [forks-url]: https://github.com/adi-code22/TraWell-App/network/members
// [stars-shield]: https://img.shields.io/github/stars/adi-code22/TraWell-App.svg?style=for-the-badge
// [stars-url]: https://github.com/adi-code22/TraWell-App/stargazers
// [issues-shield]: https://img.shields.io/github/issues/adi-code22/TraWell-App.svg?style=for-the-badge
// [issues-url]: https://github.com/adi-code22/TraWell-App/issues
// [license-shield]: https://img.shields.io/github/license/adi-code22/TraWell-App.svg?style=for-the-badge
// [license-url]: https://github.com/adi-code22/TraWell-App/blob/main/LICENSE.md
// [linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
// [linkedin-url]: https://www.linkedin.com/in/adityakrishnan007/
// [product-screenshot]: assets/git_images/first.PNG
// [solution]: assets/git_images/solution.PNG
// [scan]: assets/git_images/scanMonument.PNG
// [speak]: assets/git_images/speakNa.PNG
// [card]: assets/git_images/trawell%2Bmarket.PNG
// [locate]: assets/git_images/suggestplan%2Blocate.PNG
// [Flutter]: https://img.shields.io/badge/Flutter-000000?style=for-the-badge&logo=flutter&logoColor=blue
// [Flutter-url]: https://flutter.dev/
// [React.js]: https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB
// [React-url]: https://reactjs.org/
// [Tensorflow]: https://img.shields.io/badge/Tensorflow-35495E?style=for-the-badge&logo=tensorflow&logoColor=orange
// [Tensorflow-url]: https://www.tensorflow.org/
// [NodeJS]: https://img.shields.io/badge/NodeJS-563D7C?style=for-the-badge&logo=nodedotjs&logoColor=green
// [NodeJS-url]: https://nodejs.org/en/
// [ExpressJS]: https://img.shields.io/badge/ExpressJS-4A4A55?style=for-the-badge&logo=express&logoColor=FF3E00
// [ExpressJS-url]: https://expressjs.com/
// [Laravel.com]: https://img.shields.io/badge/Laravel-FF2D20?style=for-the-badge&logo=laravel&logoColor=white
// [Laravel-url]: https://laravel.com
// [Bootstrap.com]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white
// [Bootstrap-url]: https://getbootstrap.com
// [JQuery.com]: https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white
// [JQuery-url]: https://jquery.com 
