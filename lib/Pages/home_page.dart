// ignore_for_file: non_constant_identifier_names, avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:grop/Pages/dashboard.dart';
import 'package:grop/Pages/display_image.dart';
import 'package:grop/utility.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var sensor_gas = "Loading..";
  var sensor_ldr = "Loading..";
  var sensor_radar = "Loading...";
  var sensor_soil_humidity = "Loading..";
  var timestamp = "Loading..";
  // var weather_json;
  final DatabaseReference _ref = FirebaseDatabase.instance
      .ref("/UsersData/uUFYqQTnDedZdKUANKk4gVa8a4M2/readings");

  @override
  void initState() {
    super.initState();

    _ref
        .orderByChild("timestamp")
        .limitToLast(10)
        .onValue
        .listen((DatabaseEvent event) {
      print("000000000000");
      final data = event.snapshot.value;
      print(data);
      updateSensorData(data);
      // final loc = "bangalore";

      // setState(() {
      //   weather_json = getWeather(loc);
      // });
    });
  }

  void updateSensorData(dynamic data) {
    print("hi");
    print("00000 $data");

    setState(() {
      if (data != null) {
        print(data[timestamp]);
        sensor_gas = data["sensor_gas"] ?? "N/A";
        sensor_ldr = data["sensor_ldr"] ?? "N/A";
        sensor_radar = data["sensor_radar"] ?? "N/A";
        sensor_soil_humidity = data["sensor_soil_humidity"] ?? "N/A";
        timestamp = data["timestamp"] ?? "N/A";
      }
    });
  }

  List<String> todos = ["Usage of pesticides", "Need more water", "", "", ""];
  // final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    // print("weather_json   00000000000 $weather_json");

    return Scaffold(
      endDrawer: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width - 100,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
                child: const Text(
                  'Home',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Dashboard()));
                },
                child: const Text(
                  'Dashboard',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              InkWell(
                onTap: () {},
                child: const Text(
                  'About',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              InkWell(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                color: const Color(0xFF269B56),
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Hello, User",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                          InkWell(
                            onTap: () async {
                              final pickedImage = await pickImageFromGallery();

                              if (pickedImage != null) {
                                print('Image picked: $pickedImage');

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ImageDisplayPage(
                                      imagePath: pickedImage,
                                    ),
                                  ),
                                );
                              } else {
                                print('Image pick canceled');
                              }
                            },
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      const Text(
                        "Everything is going fine great",
                        // "something need your attention"
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.green,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150, left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 5.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(children: [
                          Expanded(
                            child: ListTile(
                              leading:
                                  const CircleAvatar(child: Icon(Icons.air)),
                              title: Text(
                                sensor_soil_humidity,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              subtitle: const Text(
                                "Humidity",
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              leading: const CircleAvatar(
                                  child: Icon(Icons.water_drop_outlined)),
                              title: Text(
                                sensor_ldr,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              subtitle: const Text(
                                "Rainfall",
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                        ]),
                        Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                leading: const CircleAvatar(
                                    child: Icon(Icons.water)),
                                title: Text(
                                  sensor_soil_humidity,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: const Text(
                                  "Water",
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                leading: const CircleAvatar(
                                    child: Icon(Icons.fireplace_rounded)),
                                title: Text(
                                  sensor_gas,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: const Text(
                                  "Fire Alarm",
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF269B56),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 1.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xFF00803E),
                          radius: 16,
                          child: Icon(
                            Icons.water_drop_outlined,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Water your plant",
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(Icons.arrow_forward, color: Colors.white)
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "To Do",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  color: Colors.grey[200],
                  child: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: 18,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black38,
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                margin: const EdgeInsets.all(5),
                                height: 50,
                                width: 20,
                                child: Center(child: Text("To Do task$index")),
                              );
                              // Text('Put Water in your crop');
                            })
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    "Gov. Initatives",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.red,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(   
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.black, // Set the border color
                                    width: 2.0, // Set the border width
                                  ),
                                ), // color: Colors.green,
                                width: MediaQuery.of(context).size.width,
                                height: 30,
                                child: const Center(
                                  child: Text(
                                    "Pradhan Mantri Fasal Bima Yojana",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black, // Set the border color
                                  width: 2.0, // Set the border width
                                ),
                              ),
                              // color: Colors.green,
                              width: MediaQuery.of(context).size.width,
                              height: 30,
                              child: Center(
                                child: const Text(
                                  "Agriculture Infrastructure Fund",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black, // Set the border color
                                  width: 2.0, // Set the border width
                                ),
                              ),
                              // color: Colors.green,
                              width: MediaQuery.of(context).size.width,
                              height: 30,
                              child: const Center(
                                child: Text(
                                  "The Pradhan Mantri Kisan Samman Nidhi (PM-KISAN)",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          )
        ]),
      ),
    );
  }
}
