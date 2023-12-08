import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var x = "Loading...";
  final DatabaseReference _ref = FirebaseDatabase.instance
      .ref("/UsersData/uUFYqQTnDedZdKUANKk4gVa8a4M2/readings");
  @override
  void initState() {
    super.initState();
    _ref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      updateStarCount(data);
    });
  }

  void updateStarCount(dynamic data) {
    // Update the UI or perform other actions with the data
    setState(() {
      // print(data);
      x = data.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Center(
                      child: Text(x),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
