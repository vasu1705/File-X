import 'package:filemanager/main.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:provider/provider.dart';

//GLOBAL CONSTANTS
List Photoext=['jpg','png','svg','jpeg'];
List Videoext=['mp4','mpeg4','avi'];
List Docext=['pdf','docx','text','apk'];

class Drawer1 extends StatelessWidget {
  final pathtemp;
  Drawer1({this.pathtemp});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=> pathmodel(globalpath: pathtemp),
      child: Drawer2(),
    );
  }
}

class Drawer2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            // Removing last folder to go back to parent directory but not till root directory as it is not accessed  
            String pathtemp=Provider.of<pathmodel>(context,listen:false).globalpath;
            List pathlist=pathtemp.split('/');
            print(pathlist);
            print(pathlist.length);
            if (pathlist.length==3) Navigator.pop(context);
            pathlist.removeLast();
            pathtemp=pathlist.join('/');
            Provider.of<pathmodel>(context,listen: false).changepath(pathtemp);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Explore',
          style: TextStyle(color: Colors.blue),
        ),
        elevation: 0,
      ),
      body: Showdrawer(),
    );
  }
}

class Showdrawer extends StatefulWidget {
  @override
  _ShowdrawerState createState() => _ShowdrawerState();
}

class _ShowdrawerState extends State<Showdrawer> {
  //path will be a state variable which will be changed by SetState Method
  var Path=" ";

  //get list of Future items from path they are widgets of Filetiles

  Future<List<Widget>> getdirectories() async {
    var dir = Directory(Path);
    var l = dir.listSync(recursive: false, followLinks: true);
    List<Widget> l1 = [];
    for (var x in l) {
      var temp = x.path.split("/");
      if (temp[temp.length - 1] != null) {
        l1.add(Filetiles(
          name: temp[temp.length - 1],
          type: x.statSync().type,
          path: x.path,
        ));
      } else {
        print('NULL');
      }
    }

    return l1;
  }
  @override
  Widget build(BuildContext context) {
    Path=Provider.of<pathmodel>(context,listen: true).globalpath;
    return FutureBuilder(
        future: getdirectories(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView(
              children: snapshot.data,
            );
          }
          return CircularProgressIndicator();
        }
    );
  }
}

class Filetiles extends StatelessWidget {
  final type, name, path;
  Filetiles({this.name, this.type, this.path});
  @override
  Widget build(BuildContext context) {

    String getinfoimage(){
      if(type==FileSystemEntityType.file){
        var ext= (path.toString().split('.'))[1];
        print(ext);
        for(var x in Photoext){
          if (x==ext){
            return 'photos.jpg';
          }
        }
        for(var x in Videoext){
          if (x==ext){
            return 'video.jpg';
          }
        }
        for(var x in Docext){
          if (x==ext){
            if(x=='pdf') return 'pdf.png';
            if(x=='apk') return 'apk.png';
            return 'docs.jpg';
          }
        }
        return 'unknownfile.png';
      }
      return 'folder.png';
    }

    return GestureDetector(
      onTap: () {
        print('${name} was tapped');
        if(type==FileSystemEntityType.file){
          var ext= (path.toString().split('.'));

          if(ext[ext.length-1]=='jpg'){
            Navigator.push(context,MaterialPageRoute(builder: (context)=> showimage(pathimage: path,)));
          }
        }
        else{
          Provider.of<pathmodel>(context,listen: false).changepath(path);
        }
      },
      child: ListTile(
        leading: Image.asset(
          'Images/${getinfoimage()}',
          height: 30,
        ),
        title: Text(
          name,
          style: TextStyle(fontSize: 16, color: Colors.black),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
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


class pathmodel extends ChangeNotifier{
  var globalpath;
  pathmodel({this.globalpath});
  void changepath(String path){
    globalpath=path;
    notifyListeners();
  }
}

class showimage extends StatelessWidget {
  final pathimage;
  showimage({this.pathimage});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Image.asset(pathimage),
          //child: Text('$pathimage'),
        ),
      ),
    );
  }
}
