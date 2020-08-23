import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File-X',
      home: Home1(),
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
  @override
  Widget build(BuildContext context) {
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
            ),SizedBox(
              height: 10,
            ),

            //Time being add multiple same file to show scroll
            Column(
              children: getfiles(),
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
  List<Widget> getfiles() {
    List<Widget> wid = [];
    for (var x=0;x<10;x++) {
      wid.add(filetile());
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
                'Images/backgroundtile.jpg',
                fit: BoxFit.cover,
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
                      progressColor: Colors.yellow[700],
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
              Text('${x}',style: TextStyle(color: Colors.grey,fontSize: 12),)
            ],
          ),
        ),
      ),
    );
  }
}

class filetile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      height: 50,
      child: Row(
        children: [
          Image.asset('Images/docs.jpg',fit: BoxFit.cover,height: 25,),
          SizedBox(width: 20,),
          Text("Word Document",),
          SizedBox(
            width: 100,
          ),
          Text("128Kb")

        ],
      ),
    );
  }
}



