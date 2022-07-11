import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_app/HomeScree.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            SizedBox(
              height: 80,
            ),
            Image.asset(
              "images/add-user.png",
              height: 100,
              width: 100,
            ),
            SizedBox(
              height: 50,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: "Email"),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: "Password"),
              obscureText: true,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(60, 10, 60, 0),
              child: ElevatedButton(
                  onPressed: () async {
                    await _firebaseAuth.createUserWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text);
                    SnackBar snackBar =
                        SnackBar(content: Text("Register Berhasil"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  child: Text("Register")),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(60, 10, 60, 0),
              child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await _firebaseAuth
                          .signInWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text)
                          .then((value) => Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => HomeScreen())));
                    } catch (e) {
                      print(e);
                    }
                    SnackBar snackBar =
                        SnackBar(content: Text("Login Berhasil"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  child: Text("Login")),
            )
          ],
        ),
      ),
    );
  }
}
