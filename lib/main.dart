import 'package:bms/config.dart';
import 'package:bms/second.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: Login(),
  ));
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Love shayri"),),
      body: ListView.builder(itemCount: Config.title.length,itemBuilder: (context, index) {
        return ListTile(onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Second(index);
          },));
        },title: Text(Config.title[index]),);
      },)
    );
  }
}
