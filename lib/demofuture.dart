import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main()
{
  runApp(MaterialApp(home: Demo2(),));
}
class Demo2 extends StatefulWidget {
  const Demo2({Key? key}) : super(key: key);

  @override
  State<Demo2> createState() => _Demo2State();
}

class _Demo2State extends State<Demo2> {
  int a=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    a=demo();
  }

  demo()
   async {
    await Future.delayed(Duration(seconds: 5));
    return 10;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Center(child: Text("A : $a"),)),);
  }
}
