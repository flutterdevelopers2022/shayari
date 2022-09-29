import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:bms/config.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:permission_handler/permission_handler.dart';

class Fourth extends StatefulWidget {
  String shayri;

  Fourth(this.shayri);

  @override
  State<Fourth> createState() => _FourthState();
}

class _FourthState extends State<Fourth> {
  GlobalKey _globalKey = new GlobalKey();
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
  String cur_font = "font1";
  Color cur_color = Colors.blue;
  double text_size = 20;
  int z = 0;
  int p=0;
Future  demo()async
  {
       await Future.delayed(Duration(seconds: 5));
       return 10;
  }

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_permission();
    demo().then((value) {

      print("MyVal=$value");

    });

  }
  get_permission()
  async {
    var status = await Permission.storage.status;
    if(status.isDenied){
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
      print(statuses[Permission.storage]);
    }
  }
  Future<Uint8List> _capturePng() async {
    try {
      print('inside');
      RenderRepaintBoundary? boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary?;
      ui.Image image = await boundary!.toImage(pixelRatio: 3.0);
      ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData!.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes);
      print(pngBytes);
      print(bs64);
      setState(() {});
      return pngBytes;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo Shayri"),
      ),
      body: Column(children: [
        RepaintBoundary(child: Flexible(
            child: Container(
              color: cur_color,
              child: Text(
                " ${widget.shayri}",
                style: TextStyle(fontSize: text_size, fontFamily: cur_font),
              ),
            )),key: _globalKey,),
        Spacer(),
        Expanded(
            child: Container(
          color: Colors.black12,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.all(15),
                      height: 30,
                      width: 30,
                      child: Image.asset("image/reload.png")),
                  Container(
                      margin: EdgeInsets.all(15),
                      height: 30,
                      width: 30,
                      child: Image.asset("image/expand.png")),
                ],
              ),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          barrierColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return Container(
                                height: 100,
                                child: StatefulBuilder(
                                  builder: (context, setState1) {
                                    return Slider(
                                      min: 10,
                                      max: 100,
                                      value: text_size,
                                      onChanged: (double value) {
                                        setState(() {
                                          setState1(() {
                                            text_size = value;
                                            print(text_size);
                                          });
                                        });
                                      },
                                    );
                                  },
                                ));
                          },
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        margin: EdgeInsets.all(15),
                        color: Colors.red,
                        child: Text("TextSize",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      margin: EdgeInsets.all(15),
                      color: Colors.red,
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        var folder=await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS)+"/myfolder";
                        print("MYFolder : $folder");
                        Directory dir=Directory(folder);
                        if(!await dir.exists())
                          {
                            dir.create();
                          }




                      },
                      child: Container(
                        height: 40,
                        margin: EdgeInsets.all(15),
                        color: Colors.red,
                        child: Text("Share"),
                      ),
                    ),
                  ),
                ],
              )),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          barrierColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 7,
                                    child: Container(
                                      color: Colors.black54,
                                      height: 200,
                                      child: GridView.builder(
                                        itemCount: gra_color.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 8,
                                                mainAxisSpacing: 5,
                                                crossAxisSpacing: 5),
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                cur_color = gra_color[index];
                                              });
                                            },
                                            child: Container(
                                                color: gra_color[index]),
                                          );
                                        },
                                      ),
                                    )),
                                Expanded(
                                    child: IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.close),
                                ))
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 40,
                        margin: EdgeInsets.all(15),
                        color: Colors.red,
                        child: Text("Background"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          barrierColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return Row(
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        z--;
                                      });
                                    },
                                    child: Text("Dec-$z")),
                                StatefulBuilder(
                                  builder: (context, setState1) {
                                    return ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            setState1(() {
                                              z++;
                                            });
                                          });
                                        },
                                        child: Text("Inc- $z"));
                                  },
                                )
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        child: Text("$z"),
                        margin: EdgeInsets.all(15),
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 100,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: Config.font_name.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        cur_font = Config.font_name[index];
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 40,
                                      width: 100,
                                      margin:
                                          EdgeInsets.fromLTRB(10, 30, 10, 30),
                                      color: Colors.red,
                                      child: Text("Shayri",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontFamily:
                                                  Config.font_name[index])),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 40,
                        margin: EdgeInsets.all(15),
                        color: Colors.red,
                        child: Text("FOnt"),
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
        )),
      ]),
    );
  }
}
