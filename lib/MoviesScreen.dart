import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:untitled2/ViewModel/MoviesViewModel.dart';
import 'package:untitled2/ui/MyHome.dart';

import 'api/MyplayerServices.dart';
import 'data/result_data_entity.dart';
List<ResultDataEntity>? newData = null;
ResultDataEntity? defaultData = ResultDataEntity("Movie" , "aaa" , "aaa");
class MoviesScreen extends StatefulWidget {
  var httpClient = new HttpClient();

  @override
  State<StatefulWidget> createState() => MoviesScreenState();
}

_getData() async {
  print("zwj async");
  MoviesViewModel vm = MoviesViewModel();
  MoviesViewModel.phoneLogin("111", "111");
}



class MoviesScreenState extends State<MoviesScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

   _playVideo (String? mUrl) {
      setState(() {

        //Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHome()));
        Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new MyHome(url: mUrl!))
        );
      });
  }

  playVideo(String? mUrl) {
    print("zwj video url $mUrl");
    String url1 = "url";
    if (mUrl == null) {
      url1 = "url";
      return;
    } else {
      url1 = mUrl;
    }
    setState(() {

      //Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHome()));
      // Future.delayed(Duration.zero, () { Navigator.push(
      //     context,
      //     new MaterialPageRoute(builder: (context) => new MyHome(url: url1))
      // );});
    });


  }

  void getData() async {
    print("zwj 开始请求数据");
    List<ResultDataEntity> rrr =
    await MyplayerServices.get(
        "/test/test3.json", {});


    setState(() {
      newData = rrr as List<ResultDataEntity>?;
      print("zwj Size ${newData?.length}");
    });

    print("zwj 请求完成");

  }

  @override
  Widget build(BuildContext context) {
    // List<ResultDataEntity>? newData =
    //     await MyplayerServices.get("/test/test3.json", {});
    //getData().whenComplete(() => setData());
    //Future.sync(() => print('同步运行的Future')).whenComplete(() => print('complete'));
  //  MoviesViewModel.phoneLogin("111","111");
   // print("000");
    print("刷新");
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
      ),
    body: Center(
      child: ListView.builder(
        // 有分割线
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

        itemCount: newData?.length,    // 数据长度
      ),
    ),
    );
  }

  String? getDataNum(ResultDataEntity? newData) {
    if (newData?.num == null) {
      return 'null';
    } else {
      return newData?.num;
    }
  }

  String? getImageUrl(ResultDataEntity? newData) {
    if (newData?.url == null) {
      return 'null';
    } else {
      print("image url ${newData?.url}");
      return newData?.url;
    }
  }

  Widget buildListData(BuildContext context, ResultDataEntity? newData) {

    return Container(
      child: Column(
          children: <Widget>[

        Stack(
            alignment: Alignment.center,
            children: <Widget>[
        Image(
            //image: NetworkImage('https://t7.baidu.com/it/u=2531125946,3055766435&fm=193&f=GIF'),
            image: NetworkImage(getImageUrl(newData)!),  // 加载是网络图片
            width: 200.0,
            height: 200.0,
            alignment: Alignment.center, // 设置对齐方式, 跟container 里面对齐方式一样
            //如果图片没有填充满容器的话，图片的对齐方式，值为一个 AlignmentGeometry 对象，Alignment 是它的一个实现类
            //可选值同 Container 的 Alignment 取值一样。
            //Alignment.topLeft：垂直靠顶部水平靠左对齐
            //Alignment.topCenter：垂直靠顶部水平居中对齐
            //Alignment.topRight：垂直靠顶部水平靠右对齐
            //Alignment.centerLeft：垂直居中水平靠左对齐
            //Alignment.center：垂直和水平居中都对齐
            //Alignment.centerRight：垂直居中水平靠右对齐
            //Alignment.bottomLeft：垂直靠底部水平靠左对齐
            //Alignment.bottomCenter：垂直靠底部水平居中对齐
            //Alignment.bottomRight：垂直靠底部水平靠右对齐
            //除了上面的常量之外，还可以创建 Alignment 对象指定 x、y 偏移量
            fit: BoxFit.cover,  //fit 属性用来控制图片的拉伸和挤压，这都是根据父容器来 的。 类似 Android 中 ImageView 的 scaleType
            //BoxFit.none：将图片的内容按原大小居中显示。
            //BoxFit.contain：将图片的内容完整居中显示，通过按比例缩小或原来的 size 使得图片宽/高等于或小于组件的宽/高，类似 Android 的 centerInside。
            //BoxFit.cover：按比例放大图片的 size 居中显示，类似 Android 的 centerCrop。
            //BoxFit.fill：把图片不按比例放大/缩小到组件的大小显示，类似 Android 的 fitXY。
            //BoxFit.fitHeight：把图片的高按照组件的高显示，宽等比例放大/缩小。
            //BoxFit.fitWidth：把图片的宽按照组件的宽显示，高等比例放大/缩小。
            //BoxFit.scaleDown：如果图片宽高大于组件宽高，则让图片内容完全居中显示，此时同 contain，如果图片宽高小于组件宽高，则按图片原大小居中显示，此时同 none。

            //  matchTextDirection: true,

            //如果图片没填充满容器的话，图片的重复方式，可选值有：
            //ImageRepeat.noRepeat：不重复
            //ImageRepeat.repeat：X、Y 轴都重复
            //ImageRepeat.repeatX：只在 X 轴重复
            //ImageRepeat.repeatY：只在 Y 轴重复
          ),
              IconButton(onPressed:() {_playVideo(newData?.video);}, icon:Icon(Icons.play_arrow),alignment: Alignment.center,
                  iconSize: 60,
              color: Colors.white,),
            ]

        ),



          Text(getDataNum(newData)!,
            style: Theme.of(context).textTheme.headline4,)]
      ),
    );
  }
}
