import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

Future<Map<String, dynamic>> getWeather(String location) async {
  final String apiUrl =
      'https://api.weatherapi.com/v1/current.json?key=fa2d8fc391d1488d835213945230812&q=$location';

  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load weather data');
  }
}

Future<String?> pickImageFromGallery() async {
  final ImagePicker _picker = ImagePicker();

  try {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      // You can customize options like maxHeight, maxWidth, imageQuality, etc.
    );

    if (pickedFile != null) {
      // Return the path of the picked image
      return pickedFile.path;
    } else {
      // Return null if image pick was canceled
      return null;
    }
  } catch (e) {
    print('Error picking image: $e');
    // Handle errors as needed
    return null;
  }
}

String imageToBase64(File imageFile) {
  List<int> imageBytes = imageFile.readAsBytesSync();
  String base64String = base64Encode(imageBytes);
  return base64String;
}

Future<void> sendImageToServer(File imageFile) async {
  List<int> imageBytes = imageFile.readAsBytesSync();

  String imgData = base64Encode(imageBytes);
  final String url = "https://susya.onrender.com";

  try {
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{'image': imgData}),
    );

    if (response.statusCode == 200) {
      // Successful response, you can handle the result here
      print(response.body);
    } else {
      // Handle errors or non-200 status codes
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    // Handle exceptions
    print('Error: $e');
  }
}

Future<void> sendImageToServer2(File imageFile) async {
  try {
    // const String url = "https://susya.onrender.com";
    const String url = "https://plant-disease-detector-pytorch.herokuapp.com";

    // Open the image file as a stream for efficient reading
    final Stream<List<int>> imageStream = imageFile.openRead();

    // Send the image data in chunks
    await for (List<int> chunk in imageStream) {
      String imgData = base64Encode(chunk);
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{'image': imgData}),
      );

      if (response.statusCode != 200) {
        // Handle errors or non-200 status codes
        print('Request failed with status: ${response.statusCode}');
        return;
      }
    }

    // Image sent successfully
    print('Image sent successfully');
  } catch (e) {
    // Handle exceptions
    print('Error: $e');
  }
}

Future<dynamic> sendToPredictor(imagePath) async {
  final imageBytes = File(imagePath).readAsBytesSync();
  String imageBase64 = base64Encode(imageBytes);

  var dio = Dio();

  final response = await dio
      .post("https://plant-disease-detector-pytorch.herokuapp.com/", data: {
    'image': imageBase64,
  });

  // final String plant = response.data['plant'];
  // final String disease = response.data['disease'];

  // final result = {'plant': plant, 'disease': disease};

  return response.data;
}
