import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_app/login.dart';
import 'package:http/http.dart' as http;

import 'model/users.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  List<Users> _dataAll = [];
  Future _getData() async {
    try {
      var respons =
          await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
      // print(respons.body);

      List _data = (json.decode(respons.body) as Map<String, dynamic>)['data'];
      print(_data);
      _data.forEach((element) {
        _dataAll.add(Users.fromJson(element));
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      print(auth.currentUser!.email);
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Home Screen",
            style: TextStyle(fontSize: 30),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  _signOut().then((value) => Navigator.of(context)
                      .pushReplacement(
                          MaterialPageRoute(builder: ((context) => Login()))));
                },
                icon: Icon(
                  Icons.exit_to_app,
                  size: 29,
                ))
          ],
        ),
        body: FutureBuilder(
            future: _getData(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                    itemCount: _dataAll.length,
                    itemBuilder: ((context, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(_dataAll[index].avatar),
                            radius: 30,
                          ),
                          title: Text(
                            "${_dataAll[index].firstName}"
                            "${_dataAll[index].lastName}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(_dataAll[index].email),
                        )));
              }
            })));
  }
}
