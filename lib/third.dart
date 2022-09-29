import 'dart:math';

import 'package:bms/fourth.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Third extends StatefulWidget {
  int shayri_ind;
  List shayri = [];

  Third(this.shayri_ind, this.shayri);

  @override
  State<Third> createState() => _ThirdState();
}

class _ThirdState extends State<Third> {
  int cur_index = 0;
  bool color_temp = false;
  List gra_color = [
    Colors.green,
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.orange,
    Colors.black26,
    Colors.greenAccent,
    Colors.blueGrey,
    Colors.brown,
    Colors.deepPurple,
    Colors.purpleAccent,
    Colors.orangeAccent,
    Colors.teal,
    Colors.green,
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.orange,
    Colors.black26,
    Colors.greenAccent,
  ];
  PageController? controller;
  int a = 0, b = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(gra_color[0]);
    cur_index = widget.shayri_ind;
    controller = PageController(initialPage: cur_index);
    a = Random().nextInt(gra_color.length);
    b = Random().nextInt(gra_color.length);
  }

  @override
  Widget build(BuildContext context) {
    double top_pa = MediaQuery.of(context).padding.top;
    double stasbar = MediaQuery.of(context).padding.bottom;
    double screen_hi = MediaQuery.of(context).size.height;
    double appbar = kToolbarHeight;
    double tot_hei = screen_hi - top_pa - stasbar - appbar;
    return Scaffold(
      appBar: AppBar(title: Text("Love shayri")),
      body:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return Container(
                      margin: EdgeInsets.only(top: 20),
                      height: tot_hei,
                      child: GridView.builder(
                        itemCount: gra_color.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          return InkWell(child: Container(
                            width: 150,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors:[gra_color[index],
                                      (index<gra_color.length-1) ? gra_color[index+1] : Colors.red] )),
                            height: 150,
                            child: Text(
                              "pyar mohabat shayri",
                              style:
                              TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),onTap: () {
                            setState(() {
                              color_temp=true;
                              a=index;
                              if(index<gra_color.length-1)
                              b=index+1;
                              else
                                b=1;
                            });
                            Navigator.pop(context);
                          },);
                        },
                      ),
                    );
                  },
                );
              },
              child: Container(
                  margin: EdgeInsets.all(15),
                  height: 30,
                  width: 30,
                  child: Image.asset("image/expand.png")),
            ),
            Text("${cur_index + 1}/${widget.shayri.length}"),
            InkWell(
              onTap: () {
                setState(() {
                  color_temp = true;
                  a = Random().nextInt(gra_color.length);
                  b = Random().nextInt(gra_color.length);
                });
              },
              child: Container(
                  margin: EdgeInsets.all(15),
                  height: 30,
                  width: 30,
                  child: Image.asset("image/reload.png")),
            ),
          ],
        ),
        Expanded(
          child: Container(
            child: PageView.builder(
              controller: controller,
              itemCount: widget.shayri.length,
              onPageChanged: (value) {
            setState(() {
              cur_index = value;
            });
              },
              itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                  color: (color_temp == false) ? Colors.pink : null,
                  gradient: (color_temp == true)
                      ? LinearGradient(colors: [gra_color[a], gra_color[b]])
                      : null),
              child: Text(
                widget.shayri[index],
                style: TextStyle(fontSize: 25),
              ),
            );
              },
            ),
          ),
        ),
        Container(
          color: Colors.green,
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    FlutterClipboard.copy(widget.shayri[cur_index])
                        .then((value) {
                      Fluttertoast.showToast(
                          msg: "text copied..",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    });
                  },
                  icon: Icon(
                    Icons.copy,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {
                    setState(() {
                      cur_index--;
                    });
                    controller!.jumpToPage(cur_index);
                  },
                  icon: Icon(Icons.arrow_back_ios)),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Fourth(widget.shayri[cur_index]);
                  },));
                },
                child: Container(child: Image.asset("image/pencil2.png")),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      cur_index++;
                    });
                    controller!.jumpToPage(cur_index);
                  },
                  icon: Icon(Icons.arrow_forward_ios_outlined)),
              IconButton(
                  onPressed: () async {
                    await FlutterShare.share(
                      title: 'This is title',
                      text: widget.shayri[cur_index],
                    );
                  },
                  icon: Icon(Icons.share)),
            ],
          ),
        )
      ]),
    );
  }
}
