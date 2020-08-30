import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:io';
import 'drawer.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File-X',
      home: Home1(),
      //home: Drawer1(),
    );
  }
}

class Home1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Files-X',
          style: TextStyle(color: Colors.blue, fontSize: 25),
        ),
      ),
      body: showlist(),
    );
  }
}

class showlist extends StatelessWidget {
  void getper() async {
    var status = await Permission.storage.status;
    if (status.isUndetermined) {
      Permission.storage.request();
    }
  }

  Future<List<Widget>> getinfo() async {
    var dir = Directory("/sdcard");
    var l = dir.listSync(recursive: false, followLinks: false);
    List<Widget> l1 = [];
    print(l);
    for (var x in l) {
      var temp = x.path.split("/");
      print(temp[temp.length - 1]);
      if (temp[temp.length - 1] != null) {
        l1.add(Filetiles(name: temp[temp.length - 1], type: x.statSync().type,path: x.path,));
      } else {
        print('NULL');
      }
    }
    return l1;
  }

  @override
  Widget build(BuildContext context) {
    getper();
    getinfo();
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            searchtab(),
            showcard(),
            SizedBox(
              height: 10,
            ),
            Text(
              'File types',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: gettiles(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Recent files',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),

            //Time being add multiple same file to show scroll
            FutureBuilder(
              future: getinfo(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data,
                  );
                }
                return CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
    );
  }

  List<Widget> gettiles() {
    List l = ['photos', 'music', 'video', 'docs'];
    List<Widget> wid = [];
    for (var x in l) {
      wid.add(tilegenerate(x: x));
    }
    return wid;
  }
}

class searchtab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 20),
      child: Container(
        width: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey),
            Text(
              '     Search for files',
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}

class showcard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var totalsize=0;
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        height: 150,
        child: Stack(
          children: [
            Container(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'Images/background1.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            )),
            Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircularPercentIndicator(
                      percent: 0.5,
                      radius: 50,
                      backgroundColor: Colors.white,
                      animation: true,
                      center: Text(
                        '50%',
                        style: TextStyle(color: Colors.white),
                      ),
                      progressColor: Colors.red[800],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Internal Storage',
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        Text(
                          '',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          '32Gb / 64Gb',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                  ]),
            )
          ],
        ));
  }
}

class tilegenerate extends StatelessWidget {
  final x;
  tilegenerate({this.x});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'Images/${x}.jpg',
                height: 40,
              ),
              Text(
                '${x}',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Filetiles extends StatelessWidget {
  final type, name, path;
  Filetiles({this.name, this.type, this.path});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('${name} was tapped');
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Drawer1(pathtemp: path,)));
      },
      child: ListTile(
        leading: Image.asset(
          'Images/docs.jpg',
          height: 30,
        ),
        title: Text(
          name,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        subtitle: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${type}   Size 128Kb',
                style: TextStyle(fontSize: 12),
              ),
              Text(
                '${path}',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
