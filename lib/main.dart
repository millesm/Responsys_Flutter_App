import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pushiomanager_flutter/beacon_region.dart';
import 'package:pushiomanager_flutter/geo_region.dart';
import 'package:pushiomanager_flutter/pushiomanager_flutter.dart';

import 'package:flutter_sample_app/message_center.dart';
import 'login_screen.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sample App',
      theme: ThemeData(
          primaryColor: Color(0xffc53f34),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                primary: Color(0xffc53f34),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                minimumSize: Size(250, 45)),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                color: Color(0xffc53f34),
                style: BorderStyle.solid,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 26,
            ),
          )),
//      home: MyHomePage(title: 'Flutter Sample App'),
      home: LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController userIdController = new TextEditingController();
  TextEditingController badgeCountController = new TextEditingController();
  TextEditingController iamEventController = new TextEditingController();
  TextEditingController serviceIdController = new TextEditingController();
  bool _isVisible = false;

  Future<List<Recommendations>> futureRecommendation;
  Future<List<DadJoke>> futureDadJoke;

  @override
  void initState() {
    PushIOManager.setLogLevel(LogLevel.VERBOSE);
    super.initState();
    PushIOManager.setMessageCenterEnabled(false);
    PushIOManager.setMessageCenterEnabled(true);
    futureDadJoke = fetchDadJoke();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(1.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network('https://picsum.photos/300'),
                        ),
                      ),
                    ),
                    FutureBuilder<List<DadJoke>>(
                      future: futureDadJoke,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Card(
                                    elevation: 5.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 15, 10, 15),
                                          child: Text(snapshot.data[index].text,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        )
                                      ],
                                    ));
                              });
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      },
                    ),

/*                     Card(
                        margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text("Setup",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold)),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 30),
                                    child: Text(
                                        "Set up the Responsys SDK using configure( ). Once the SDK is configured, call registerApp( ) to register your app with Responsys.",
                                        style:
                                            TextStyle(color: Colors.black54))),
                                Center(
                                    child: ElevatedButton(
                                  onPressed: () {
                                    configure();
                                  },
                                  child: Text('CONFIGURE',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                )),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                                    child: Center(
                                        child: ElevatedButton(
                                      onPressed: () {
                                        registerApp();
                                      },
                                      child: Text('REGISTER',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    )))
                              ],
                             ))),
*/
                    Card(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text("User Identification",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold)),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 30),
                                    child: Text(
                                        "Use registerUserId( ) to associate this app installation with a user (usually after login). And use unregisterUserId( ) on log out.",
                                        style:
                                            TextStyle(color: Colors.black54))),
                                Container(
                                    margin: const EdgeInsets.only(
                                        right: 40, left: 40),
                                    child: TextField(
                                        maxLines: 1,
                                        controller: userIdController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                          hintText: "Enter user ID",
                                        ))),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                                    child: Center(
                                        child: ElevatedButton(
                                      onPressed: () {
                                        registerUserId();
                                      },
                                      child: Text('REGISTER USER ID',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    )))
                              ],
                            ))),
                    Card(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text("Engagements And Conversion",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold)),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 30),
                                    child: Text(
                                        "User actions can be attributed to a push notification using trackEngagement( )\n\nPushIOManager.EngagementType lists the different actions that can be attributed.",
                                        style:
                                            TextStyle(color: Colors.black54))),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    child: Center(
                                        child: ElevatedButton(
                                      onPressed: () {
                                        trackEngagement();
                                      },
                                      child: Text('TRACK CONVERSION',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    )))
                              ],
                            ))),
                    Card(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text("Recommendations Service",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold)),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 30),
                                    child: Text(
                                        "Provide a recommendtion service ID to associate this app installation with a recommendation service.  The service ID will be appended to the US based infinity environment",
                                        style:
                                            TextStyle(color: Colors.black54))),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 30),
                                    child: Text(
                                        "Working service IDs include g4pw19ml, 547yzr4p, 249d8lmr, gmj9yn4n, w4nryrm0 g4pw19ml",
                                        style:
                                            TextStyle(color: Colors.black54))),
                                Container(
                                    margin: const EdgeInsets.only(
                                        right: 40, left: 40),
                                    child: TextField(
                                        maxLines: 1,
                                        controller: serviceIdController,
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                          hintText: "Enter service ID",
                                        ))),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                                    child: Center(
                                        child: ElevatedButton(
                                      onPressed: () {
                                        futureRecommendation =
                                            fetchRecommendations();
                                        setState(() {});
                                      },
                                      child: Text('REGISTER SERVICE ID',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    )))
                              ],
                            ))),
                    FutureBuilder<List<Recommendations>>(
                      future: futureRecommendation,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Card(
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(1.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Image.network(
                                              snapshot.data[index].thumb),
                                        ),
                                      ),
                                      Text(snapshot.data[index].name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(snapshot.data[index].currency +
                                          snapshot.data[index].price),
                                    ],
                                  ));
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      },
                    ),
                    Card(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text("In-App Messages",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold)),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 30),
                                    child: Text(
                                        "In-App Message (IAM) can be displayed via system-defined events like \$ExplicitAppOpen or custom events. IAM that use system-defined triggers are displayed automatically."
                                        "\n\nIAM can also be displayed on-demand using custom events."
                                        "\n\n\t- Your marketing team defines a custom event in Responsys system and shares the event name with you."
                                        "\n\n\t- The IAM is delivered to the device via push or pull mechanism (depending on your Responsys Account settings)"
                                        "\n\n\t- When you wish to display the IAM popup, call trackEvent( custom-event )",
                                        style:
                                            TextStyle(color: Colors.black54))),
                                Container(
                                    margin: const EdgeInsets.only(
                                        right: 40, left: 40),
                                    child: TextField(
                                        maxLines: 1,
                                        controller: iamEventController,
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                          hintText:
                                              "Enter Custom Event Trigger",
                                        ))),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                                    child: Center(
                                        child: ElevatedButton(
                                      onPressed: () {
                                        trackCustomEventForIAM();
                                      },
                                      child: Text('SHOW IN-APP MSG',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    )))
                              ],
                            ))),
                    Card(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text("Message Center",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold)),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 30),
                                    child: Text(
                                        "Get the Message Center message list using fetchMessagesForMessageCenter( )."
                                        "\n\nIf any message has rich-content(HTML) then call fetchRichContentForMessage( )."
                                        "\n\nRemember to store these messages, since the SDK cache is purgeable.",
                                        style:
                                            TextStyle(color: Colors.black54))),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    child: Center(
                                        child: ElevatedButton(
                                      onPressed: () {
                                        fetchMessages();
                                      },
                                      child: Text('GET MESSAGES',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    )))
                              ],
                            ))),
                    Card(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text("Rapid Retargeter Events",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold)),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 30),
                                    child: Text(
                                        "Responsys SDK supports tracking of system-defined and custom events using trackEvent( )."
                                        "\n\nFor tracking custom events, you will need your Oracle CX - Infinity account to be setup for processing the incoming custom events. "
                                        "Your marketing team should work with your Oracle CX contact to get his done."
                                        "\n\nThe list of these events is available in the developer documentation."
                                        "\n\nFollowing are two of the supported events.",
                                        style:
                                            TextStyle(color: Colors.black54))),
                                Center(
                                    child: ElevatedButton(
                                  onPressed: () {
                                    trackEvent("\$Browsed")();
                                  },
                                  child: Text('TRACK EVENT - BROWSED',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                )),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                                    child: Center(
                                        child: ElevatedButton(
                                      onPressed: () {
                                        trackEvent("\AddedItemToCart")();
                                      },
                                      child: Text('TRACK EVENT - ADD TO CART',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    )))
                              ],
                            ))),
                    Card(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text("Geofences And Beacons",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold)),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 30),
                                    child: Text(
                                        "Record Geofence and Beacon entry/exit events using these APIs.",
                                        style:
                                            TextStyle(color: Colors.black54))),
                                Center(
                                    child: ElevatedButton(
                                  onPressed: () {
                                    onGeoRegionEntered();
                                  },
                                  child: Text('TRACK GEOFENCE ENTRY',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                )),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                                    child: Center(
                                        child: ElevatedButton(
                                      onPressed: () {
                                        onBeaconRegionEntered();
                                      },
                                      child: Text('TRACK BEACON ENTRY',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    )))
                              ],
                            ))),
                    Card(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text("Notification Preferences",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold)),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 30),
                                    child: Text(
                                        "Preferences are used to record user-choices for push notifications."
                                        "\n\nThe preferences should be pre-defined in Responsys system before being used in your app."
                                        "\n\nDo not use this as a key/value store as this data is purgeable.",
                                        style:
                                            TextStyle(color: Colors.black54))),
                                Center(
                                    child: ElevatedButton(
                                  onPressed: () {
                                    setPreference(PreferenceType.STRING)();
                                  },
                                  child: Text('SET STRING PREFERENCE',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                )),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                                    child: Center(
                                        child: ElevatedButton(
                                      onPressed: () {
                                        setPreference(PreferenceType.NUMBER)();
                                      },
                                      child: Text('SET NUMBER PREFERENCE',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    )))
                              ],
                            ))),
                    Card(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text("Set Badge Count",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold)),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 30),
                                    child: Text(
                                        "Use this API to set the app's icon badge count to the no. of messages in the Message Center.",
                                        style:
                                            TextStyle(color: Colors.black54))),
                                Container(
                                    margin: const EdgeInsets.only(
                                        right: 40, left: 40),
                                    child: TextField(
                                        maxLines: 1,
                                        controller: badgeCountController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                          hintText: "Enter Badge Count",
                                        ))),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                                    child: Center(
                                        child: ElevatedButton(
                                      onPressed: () {
                                        setMessageCenterBadgeCount();
                                      },
                                      child: Text('SET BADGE COUNT',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    )))
                              ],
                            ))),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Center(
                          child: Text(
                              "\u00a9 2023 Oracle and/or its affiliates. All rights reserved.",
                              style: TextStyle(
                                  color: Colors.black38, fontSize: 10.0)),
                        ))
                  ],
                ))));
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

  void registerUserId() {
    final String userId = userIdController.text;
    print("UserID: $userId");

    PushIOManager.registerUserId(userId);
  }

  void trackEngagement() {
    Map<String, String> props = {
      "sampleProductId": "121",
      "sampleItemCount": "5"
    };

    // PushIOManager.trackEngagement(type:EngagementType.PURCHASE,properties:props)
    PushIOManager.trackEngagement(EngagementType.PURCHASE, properties: props)
        .then((_) => showToast("Engagement Reported Successfully"))
        .catchError((error) => showToast("Engagement not reported: $error"));
  }

  void trackCustomEventForIAM() {
    final String event = iamEventController.text;

    PushIOManager.trackEvent(event, properties: null);
  }

  void fetchMessages() {
    PushIOManager.fetchMessagesForMessageCenter("Primary").then((messages) => {
          if (messages != null && messages.isNotEmpty)
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MessageCenterPage(messages: messages)))
            }
          else
            {showToast("No Message Center Messages")}
        });
  }

  trackEvent(String eventName) {
    Map<String, String> props = {"Pid": "1", "Pc": "sampleProduct"};

    PushIOManager.trackEvent(eventName, properties: props)
        .then((_) => showToast("Event recorded successfully"))
        .catchError((error) => showToast("Event not recorded: $error"));
  }

  void onGeoRegionEntered() {
    GeoRegion region = new GeoRegion("id1", "geofence1", "zone1", "zoneId1",
        "testSource", 20.0, 55.0, 25, null);

    PushIOManager.onGeoRegionEntered(region)
        .then((response) => showToast(
            "$response['regionType'] with ID - $response['regionID'] successfully reported"))
        .catchError((error) =>
            showToast("Unable to report \$GEOFENCE_ENTRY event: $error"));
  }

  void onBeaconRegionEntered() {
    BeaconRegion region = new BeaconRegion(
        "beaconId",
        "beaconName",
        "beaconTag",
        "beaconProximity",
        "iBeaconUUID",
        1,
        10,
        "eddyStoneId1",
        "eddyStoneId2",
        "zoneName",
        "zoneId",
        "source",
        25,
        null);

    PushIOManager.onBeaconRegionEntered(region)
        .then((response) => showToast(
            "$response['regionType'] with ID - $response['regionID'] successfully reported"))
        .catchError((error) =>
            showToast("Unable to report \$BEACON_ENTRY event: $error"));
  }

  setPreference(PreferenceType preferenceType) {
    const String key = "sampleKey";

    PushIOManager.declarePreference(key, "Label to show in UI", preferenceType)
        .then((_) => {
              showToast("Preference declared successfully"),
              if (preferenceType == PreferenceType.NUMBER)
                {
                  PushIOManager.setNumberPreference(key, 1)
                      .then((_) => showToast("Preference set successfully"))
                      .catchError(
                          (error) => showToast("Preference not set: $error"))
                }
              else
                {
                  PushIOManager.setStringPreference(key, "Test Value")
                      .then((_) => showToast("Preference set successfully"))
                      .catchError(
                          (error) => showToast("Preference not set: $error"))
                }
            })
        .catchError(
            (error) => {showToast("Preference could not be declared: $error")});
  }

  void setMessageCenterBadgeCount() {
    int badgeCount = 0;

    if (badgeCountController.text != null &&
        badgeCountController.text.isNotEmpty) {
      badgeCount = int.parse(badgeCountController.text);
    }

    print("Badge count is $badgeCount");

    PushIOManager.setBadgeCount(badgeCount, forceSetBadge: true)
        .then((_) => showToast("Badge count updated successfully"))
        .catchError((error) => showToast("Unable to set badge count: $error"));
  }

  showToast(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<List<Recommendations>> fetchRecommendations() async {
    final String serviceId = serviceIdController.text;

    String url =
        'https://us.service.recommendations.ocs.oraclecloud.com/recommendations/api/v1/services/' +
            serviceId;
    final headers = {"Content-type": "application/json"};
    final json = '{"history": [],"sessionHistory": [],"count": 50}';

    final response =
        await http.post(Uri.parse(url), headers: headers, body: json);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var recsObjectJson = jsonDecode(response.body)['recommendations'] as List;
      List<Recommendations> recsObjs = recsObjectJson
          .map((respJson) => Recommendations.fromJson(respJson))
          .toList();
      return (recsObjs);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load recommendations');
    }
  }

  Future<List<DadJoke>> fetchDadJoke() async {
    String url = 'https://icanhazdadjoke.com/slack';
    final headers = {"Accept": "application/json"};

    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jokeObjectJson = jsonDecode(response.body)['attachments'] as List;
      List<DadJoke> recsObjs =
          jokeObjectJson.map((respJson) => DadJoke.fromJson(respJson)).toList();
      return (recsObjs);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load dad jokes');
    }
  }

/* 
  Future<List<Recommendations>> getRecommendations() async {
    Completer<List<Recommendations>> completer = Completer();
    RecommendationService.callRecommendations().then((response) {
//      setState(() {
//        json.decode(response.body);
      var recsObjectJson = jsonDecode(response.body)['recommendations'] as List;
      List<Recommendations> recsObjs = recsObjectJson
          .map((respJson) => Recommendations.fromJson(respJson))
          .toList();
      _isVisible = true;
      completer.complete(recsObjs);
      return Future.value(recsObjs);
//      }      );
    });
    return completer.future;
  }
 */
}

/* class RecommendationService {
  static Future callRecommendations() {
    String url =
        'https://us.service.recommendations.ocs.oraclecloud.com/recommendations/api/v1/services/g4pw19ml';
    final headers = {"Content-type": "application/json"};
    final json = '{"history": [],"sessionHistory": [],"count": 50}';

    return http.post(Uri.parse(url), headers: headers, body: json);
  }
}
 */

class Recommendations {
  Recommendations(
      {this.name, this.currency, this.price, this.description, this.thumb});
  final String name; // String
  final String currency; // String
  final String price; // String
  final String description; // String
  final String thumb; // URL

//  factory Recommendations.fromJson(Map<String, dynamic> data) {
  factory Recommendations.fromJson(dynamic data) {
    final name = data['Name'] as String;
    final currency = data['Formatted Currency'] as String;
    final price = data['Formatted Price'] as String;
    final description = data['Description'] as String;
    final thumb = data['Thumb Image URL'] as String;

    return Recommendations(
        name: name,
        currency: currency,
        price: price,
        description: description,
        thumb: thumb);
  }
}

class DadJoke {
  DadJoke({this.text});
  final String text; // String

//  factory Recommendations.fromJson(Map<String, dynamic> data) {
  factory DadJoke.fromJson(dynamic data) {
    final joke = data['text'] as String;

    return DadJoke(text: joke);
  }
}
