import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grop/Pages/dashboard.dart';
import 'package:grop/widget/customTile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0.0,
      // ),
      endDrawer: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width - 100,
        height: MediaQuery.of(context).size.height,
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
                child: const Padding(
                  padding: EdgeInsets.only(top: 50, left: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, User",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                      Text(
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
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(children: [
                          Expanded(
                            child: ListTile(
                              leading: CircleAvatar(child: Icon(Icons.abc)),
                              title: Text(
                                "20&",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "Temp",
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              leading: CircleAvatar(child: Icon(Icons.abc)),
                              title: Text(
                                "20&",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
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
                                leading: CircleAvatar(child: Icon(Icons.abc)),
                                title: Text(
                                  "20&",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "Water",
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                leading: CircleAvatar(child: Icon(Icons.abc)),
                                title: Text(
                                  "20&",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "Temperature",
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
                      color: Color.fromARGB(255, 231, 221, 221),
                      fontWeight: FontWeight.w700),
                ),
                Expanded(
                  child: items.isEmpty
                      ? const Center(child: Text("No item in queue"))
                      : ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              tileColor: Colors.red,
                              title: Text(items[index]['title']!),
                              subtitle: Text(items[index]['subtitle']!),
                              leading: Text(items[index]['imageUrl']!),
                            );
                          },
                        ),
                ),
                ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child: const Text("logout")),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Dashboard()));
                  },
                  child: const Text("Details"),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
