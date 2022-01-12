import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled2/Capture.dart';
import 'package:untitled2/ui/InfoDetail.dart';
import 'api/MyplayerServices.dart';
import 'data/info_data_entity_entity.dart';

List<InfoDataEntityEntity>? newData = null;

class Infos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InfosState();
}

class InfosState extends State<Infos> {
  static const platform = const MethodChannel('com.example.untitled2/battery_power');
  @override
  void initState() {
    super.initState();
    getData();
  }

  String _batteryLevel = 'Unknown battery level.';

  Future<String> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
return batteryLevel;
  }

  void getData() async {
    print("zwj 开始请求数据");
    List<InfoDataEntityEntity> infos =
    await MyplayerServices.getInfo(
        "/test/test4.json", {});
    setState(() {
      newData = infos as List<InfoDataEntityEntity>?;
      print("zwj Size ${newData?.length}");
    });

    print("zwj 请求完成");
  }

  @override
  Widget build(BuildContext context) {
    _getBatteryLevel().then((value) => print("zwj level ${value}" ));

    print("111");
    return Scaffold(
      appBar: AppBar(
        title: Text('Infos'),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, item) {
            return Container(
              child: Column(
                children: <Widget>[
                  buildListData(context, newData?.elementAt(item)),
                  Divider()
                ],
              ),

            );
          },

          itemCount: newData?.length,    //
        ),
      ),
      floatingActionButton: floatButton()
    );
  }

  buildListData(BuildContext context, InfoDataEntityEntity? newData) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          setState(() {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InfoDetail(dataDetail: newData!))
            );
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFE4B5),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.all(10.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image(
                  image: NetworkImage(getImageUrl(newData)!),
                  width: 150.0,
                  height: 150.0,
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.cover,
                ),
                Column(
                  children: [
                    textContainer("标题:", "城市:", "街道:", "消费:"),
                  ],
                ),
                Column(
                  children: [
                    textContainer(getDataTitle(newData)!, newData!.city!,
                        newData!.street!, newData!.price!),
                  ],
                ),
              ]),
        ));
  }
  //处理
  //   return Container(
  //   decoration: BoxDecoration(
  //   color: Color(0xFFFFE4B5),
  //   borderRadius: BorderRadius.circular(8),
  //   ),
  //   padding: const EdgeInsets.all(5.0),
  //   margin: const EdgeInsets.all(10.0),
  //   child: Row(
  //   mainAxisAlignment: MainAxisAlignment.start,
  //   children: <Widget>[
  //   Image(
  //   image: NetworkImage(getImageUrl(newData)!),
  //   width: 150.0,
  //   height: 150.0,
  //   alignment: Alignment.centerLeft,
  //   fit: BoxFit.cover,
  //
  //   ),
  //   Column(
  //   children: [
  //   textContainer("标题:","城市:","街道:","消费:"),
  //   ],
  //
  //   ),
  //   Column(
  //   children: [
  //   textContainer(getDataTitle(newData)!,newData!.city!,newData!.street!,newData!.price!),
  //   ],
  //
  //   ),
  //   ]
  //   ),
  //   );
  // }

  String? getImageUrl(InfoDataEntityEntity? newData) {
    if (newData?.url == null) {
      return 'null';
    } else {
      print("image url ${newData?.url}");
      return newData?.url;
    }
  }

  String? getDataTitle(InfoDataEntityEntity? newData) {
    if (newData?.title == null) {
      return 'null';
    } else {
      return newData?.title;
    }
  }

  Container floatButton() {
    return Container(
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.all(15),
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        color: Colors.white,
      ),
      child: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(
          Icons.add,
          color: Colors.black,
          size: 30,
        ),
        onPressed: () {startShare();},
      ),
    );
  }

  Container textContainer(String s1,String s2,String s3,String s4) {
     return Container(

       child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text(s1),
           Text(s2),
           Text(s3),
           Text(s4)
        ],),
       margin: const EdgeInsets.only(left: 20.0));
  }

  void startShare() {
      setState(() {
        Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new Capture())
        );
      });
  }
}