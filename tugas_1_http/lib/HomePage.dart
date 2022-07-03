import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String body;
  late String id;
  late String nama;

  @override
  void initState() {
    body = "belum ada Data";
    id = "";
    nama = "";
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HTTP")),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("id: $id"),
          Text("nama : $nama"),
          ElevatedButton(
              onPressed: () async {
                var respons =
                    await http.get(Uri.parse("https://reqres.in/api/users/2"));
                if (respons.statusCode == 200) {
                  var data = json.decode(respons.body) as Map<String, dynamic>;
                  print("Berhasil");
                  setState(() {
                    id = data['data']["id"].toString();
                    nama =
                        "${data['data']['first_name']} ${data['data']['last_name']}";
                  });
                } else {
                  print("Data Tidak ada");
                }
              },
              child: Text("data"))
        ],
      )),
    );
  }
}
