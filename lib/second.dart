import 'package:bms/config.dart';
import 'package:bms/third.dart';
import 'package:flutter/material.dart';

class Second extends StatefulWidget {
  int shayri_ind;
  Second(this.shayri_ind);
  @override
  State<Second> createState() => _SecondState();
}
class _SecondState extends State<Second> {
  List shayri = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.shayri_ind == 0) {
      shayri = Config.shayri1;
    } else if (widget.shayri_ind == 1) {
      shayri = Config.shayri2;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("shayri"),
      ),
      body: ListView.builder(
        itemCount: shayri.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return Third(index, shayri);
                },
              ));
            },
            title: Text(shayri[index].toString().substring(0, 20)),
          );
        },
      ),
    );
  }
}
