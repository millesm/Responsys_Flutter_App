import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pendo_sdk/pendo_sdk.dart';
import 'dart:io';

import 'package:pushiomanager_flutter/pushiomanager_flutter.dart';

import 'utilities/Fade_Animation.dart';
import 'utilities/hex_color.dart';
import 'main.dart';

enum FormData {
  Email,
  password,
}

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Color enabled = const Color.fromARGB(255, 63, 56, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color(0xFF1F1A30);
  bool ispasswordev = true;
  FormData selected;
  String _platformVersion = 'Unknown';

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  initState() {
    super.initState();
    print("initState Called");
    configure();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.1, 0.4, 0.7, 0.9],
            colors: [
              HexColor("#4b4293").withOpacity(0.8),
              HexColor("#4b4293"),
              HexColor("#08418e"),
              HexColor("#08418e")
            ],
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                HexColor("#fff").withOpacity(0.2), BlendMode.dstATop),
            image: const NetworkImage(
              'https://mir-s3-cdn-cf.behance.net/project_modules/fs/01b4bd84253993.5d56acc35e143.jpg',
            ),
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 5,
                  color:
                      const Color.fromARGB(255, 171, 211, 250).withOpacity(0.4),
                  child: Container(
                    width: 400,
                    padding: const EdgeInsets.all(40.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FadeAnimation(
                          delay: 0.8,
                          child: Image.network(
                            "https://cdni.iconscout.com/illustration/premium/thumb/job-starting-date-2537382-2146478.png",
                            width: 100,
                            height: 100,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: const Text(
                            "Please sign in to continue",
                            style: TextStyle(
                                color: Colors.white, letterSpacing: 0.5),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: Container(
                            width: 300,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: selected == FormData.Email
                                  ? enabled
                                  : backgroundColor,
                            ),
                            padding: const EdgeInsets.all(5.0),
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              onTap: () {
                                setState(() {
                                  selected = FormData.Email;
                                });
                              },
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: selected == FormData.Email
                                      ? enabledtxt
                                      : deaible,
                                  size: 20,
                                ),
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                    color: selected == FormData.Email
                                        ? enabledtxt
                                        : deaible,
                                    fontSize: 12),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                  color: selected == FormData.Email
                                      ? enabledtxt
                                      : deaible,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: Container(
                            width: 300,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: selected == FormData.password
                                    ? enabled
                                    : backgroundColor),
                            padding: const EdgeInsets.all(5.0),
                            child: TextField(
                              controller: passwordController,
                              onTap: () {
                                setState(() {
                                  selected = FormData.password;
                                });
                              },
                              decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.lock_open_outlined,
                                    color: selected == FormData.password
                                        ? enabledtxt
                                        : deaible,
                                    size: 20,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: ispasswordev
                                        ? Icon(
                                            Icons.visibility_off,
                                            color: selected == FormData.password
                                                ? enabledtxt
                                                : deaible,
                                            size: 20,
                                          )
                                        : Icon(
                                            Icons.visibility,
                                            color: selected == FormData.password
                                                ? enabledtxt
                                                : deaible,
                                            size: 20,
                                          ),
                                    onPressed: () => setState(
                                        () => ispasswordev = !ispasswordev),
                                  ),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                      color: selected == FormData.password
                                          ? enabledtxt
                                          : deaible,
                                      fontSize: 12)),
                              obscureText: ispasswordev,
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                  color: selected == FormData.password
                                      ? enabledtxt
                                      : deaible,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: TextButton(
                              onPressed: () {
                                registerUserId(emailController.text);
                                trackPendo(
                                    "Login", {"Screen Name": "Login Screen"});
                                Navigator.pop(context);
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return MyHomePage(
                                      title: 'Flutter Sample App');
//                                  return MyApp(isLogin: true);
                                }));
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFF2697FF),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14.0, horizontal: 80),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)))),
                        ),
                      ],
                    ),
                  ),
                ),

                //End of Center Card
                //Start of outer card
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void configure() {
    PushIOManager.configure("pushio_config.json")
        .then((_) => showToast("Configuration successful"))
        .catchError((error) {
      showToast("Configuration Failed: $error");
    });
  }

  void registerApp() {
    if (Platform.isAndroid) {
      PushIOManager.registerApp(useLocation: true)
          .then((_) => showToast("Registration Successful"))
          .catchError((error) {
        showToast("Registration error: $error");
      });
    } else if (Platform.isIOS) {
      PushIOManager.registerForAllRemoteNotificationTypes()
          .then((_) => {PushIOManager.registerApp()})
          .then((_) => print("Registration Successful"))
          .catchError((error) => print("Registration error: $error"));
    }
  }

  void registerUserId(String email) {
    final userId = email;
    print("UserID: $userId");

    PushIOManager.registerUserId(userId);
    startSession(userId);
  }

  showToast(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> trackPendo(eventKey, eventProperties) async {
    // Start a new session with an identified visitor
    await PendoFlutterPlugin.track(eventKey, eventProperties);
  }

  Future<void> startSession(email) async {
    var originalVisitorId = email;
    dynamic originalVisitorData = {"Age": 27, "Country": "USA"};

    // Start a new session with an identified visitor
    await PendoFlutterPlugin.startSession(
        originalVisitorId, null, originalVisitorData, null);
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      dynamic arguments = {
        "visitorId": "flutter_visitorId1",
        "accountId": "flutter_accountId"
      };

      // Setup the Pendo SDK
      await PendoFlutterPlugin.setup(
          "eyJhbGciOiJSUzI1NiIsImtpZCI6IiIsInR5cCI6IkpXVCJ9.eyJkYXRhY2VudGVyIjoidXMiLCJrZXkiOiI3MzI5MmViYmQyOTA2MTNmNDQ3YTRlYjcyNTA2MjVhMGFiMjA3OTA0M2YzOTlmMjIzNjgyYmU0NDdjNGQzOGM0ZDIwOTVkNjdhMDFkMDY4M2EyYzFkZmFhNDBhNzRmZDE5NjVmNDg4NjkwYzMwNTk2YmU3YjRmYzBiMGMwYzkxMDg4YmNkZjRkNTMxM2I4NDZiOWIxZjdlZjMyOTIwMDA4MTZiNTM1N2MzMmRmNjhlNjAwOTQ1NjFkM2I1ZmQzYzFmMjhlMDIwODEwODBhNjdjZjk1MDg1MTQzMDZmMjE5Ni40ZWY1YzkyMTU5Njk2ZWNkYTc2NWM5MGEyMzlmNTA2NS40YzMwMTFhZTg2YjAzYmM0ZTNjNzdiM2RkZmE2NGU1NTc3ODgyODQwMTFkNDkxNzkyOTVmNGNhZWUzYmViMzE3In0.K23WE1Oc4jnnQjlv2EkICV3yc-QOoldNh10NFjRwluJyyFSiCCJ6yo7-7Ivm0DB57MjjEuaSjaSQ0NVtatzkVxpfVF32cAkO72gjsaCHkI5r0aYief3Zuq7c0pglsiw9EDGeYWetoG-f1EYI0WXJtJ2KV8Ny1zPibo7Ww9SlE4Y");

      // Track an event that is happening in your application.
      await PendoFlutterPlugin.track(
          "App Open", {"Screen Name": "Main Screen"});
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }
}
