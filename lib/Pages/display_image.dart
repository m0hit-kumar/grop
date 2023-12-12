import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grop/utility.dart';

class ImageDisplayPage extends StatefulWidget {
  final String imagePath;

  const ImageDisplayPage({required this.imagePath});

  @override
  State<ImageDisplayPage> createState() => _ImageDisplayPageState();
}

class _ImageDisplayPageState extends State<ImageDisplayPage> {
  String processingResult = "Processing...";
  var disease = "Loading..";
  var solutions = "Loading";
  File get imagePath => imagePath;

  @override
  void initState() {
    super.initState();
    processImage();
  }

  void processImage() {
    // Add your image processing logic here
    // For example, you can use a package like TFLite or any other image processing logic

    // Simulating processing for demonstration purposes
    // Replace this with your actual image processing code

    // sendImageToServer(imagePath);

    // var disease = "Loading..";
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        // processingResult = "Processed result: Disease detected!";

        try {
          print("----------- $imagePath");

          sendImageToServer2(imagePath);
        } catch (e) {
          print("0000000000000000000 $e");
        }
        disease = "Early Blight";
        solutions = """
              - Improve air circulation.
              - Apply organic mulch around plants.
              - Water at the base in the morning.
              - Avoid planting in the same location.
              """;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Disease Detection'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Container(
                // padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                    width: 10.0,
                  ),
                ),
                child: Image.file(
                  File(widget.imagePath),
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              // Text(
              //   processingResult,
              //   style: const TextStyle(fontSize: 18),
              // ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: Text(
                  "Analyze",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),

              const SizedBox(height: 20),
              Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        const Text(
                          "Disease:  ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w900),
                        ),
                        Text(
                          disease,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  // height: ,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Solutions:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(height: 20),
                        Text(
                          solutions,
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
