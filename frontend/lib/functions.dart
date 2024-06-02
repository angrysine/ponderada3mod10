import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "dart:convert";
import "package:awesome_notifications/awesome_notifications.dart";

import 'package:http/http.dart' as http;

var urlBase = "44.193.127.173";
const storage = FlutterSecureStorage();
Future<http.Response> createUser(user, password) {
  print("aaaaaaaaaa");
  return http.post(Uri.parse("http://$urlBase:5001/addUser"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'username': user,
        'password': password,
      }));
}

Future<http.Response> login(user, password) {
  return http.post(Uri.parse('http://$urlBase:5001/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'username': user,
        'password': password,
      }));
}

Future<http.Response> addTask(title, content, token) {
  return http.post(Uri.parse('http://$urlBase:5001/addTask'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(
        {
          'title': title,
          'content': content,
        },
      ));
}

Future<http.Response> updateTask(title, content, token) {
  return http.put(
    Uri.parse('http://$urlBase:5001/updateTask'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: json.encode({'title': title, 'content': content}),
  );
}

Future<http.Response> deleteTask(title, token) {
  return http.delete(
    Uri.parse('http://$urlBase:5001/deleteTask'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: json.encode({'title': title}),
  );
}

Future<http.Response> getTasks(token) {
  print(token);
  return http.get(Uri.parse('http://$urlBase:5001/getTasks'), headers: {
    'Authorization': 'Bearer $token',
  });
}

void saveToken(token) async {
  await storage.write(key: 'token', value: token);
}

String getToken(response) {
  var token = json.decode(response.body);
  print(token);
  return token['token'];
}

Future<String?> getTokenFromStorage() async {
  return await storage.read(key: 'token');
}

Future<void> createNotification(title, body, bigPicture) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 10,
      channelKey: 'basic_channel',
      title: title,
      body: body,
      // bigPicture: "https://bit.ly/fcc-running-cats",
    ),
  );
}

Future<String> sendImage(File file, token) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('http://$urlBase:5001/uploadfile'),
  );
  request.headers['Authorization'] = 'Bearer $token';
  request.files.add(
    await http.MultipartFile.fromPath(
      'file',
      file.path,
    ),
  );
  var response = await request.send();
  print(response.statusCode);
  print(await response.stream.bytesToString());
  return await response.stream.bytesToString();
}
