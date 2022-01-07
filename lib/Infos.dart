import 'package:flutter/material.dart';
import 'api/MyplayerServices.dart';
import 'data/info_data_entity_entity.dart';

List<InfoDataEntityEntity>? newData = null;
class Infos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InfosState();
}

class InfosState extends State<Infos> {

  @override
  void initState() {
    super.initState();
    getData();
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
    );
  }

  buildListData(BuildContext context, InfoDataEntityEntity? newData) {
    return Container(
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
                textContainer("标题:","城市:","街道:","消费:"),
              ],
              
            ),
            Column(
              children: [
                textContainer(getDataTitle(newData)!,newData!.city!,newData!.street!,newData!.price!),
              ],

            ),
          ]
      ),
    );
  }

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
}