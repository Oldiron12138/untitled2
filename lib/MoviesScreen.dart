import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:untitled2/ViewModel/MoviesViewModel.dart';
import 'package:untitled2/data/buy_response_entity.dart';
import 'package:untitled2/ui/AccountScreen.dart';
import 'package:untitled2/ui/LoginScreen.dart';
import 'package:untitled2/ui/MyHome.dart';
import 'package:untitled2/utils/Global.dart';
import 'package:untitled2/utils/SharePerfManager.dart';

import 'api/MyplayerServices.dart';
import 'data/result_data_entity.dart';
List<ResultDataEntity>? newData = null;
BuyResponseEntity? newData1 = null;
var focusUrl;
var focusNum;
ResultDataEntity? defaultData = ResultDataEntity();
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

  _playVideo(String? mNum, String? mUrl) {
    focusNum = mNum;
    print("zwj _playVideo");
    setState(() {
      if (!Global.isLoged) {
        print("zwj _playVideo1");
        showCupertinoAlertDialog("请先登录。", "宁还没有登录", "登录");
      } else if (Global.mUnlockMovie != null) {
        print("zwj _playVideo2");
        Global.mUnlockMovie?.forEach((element) {
          print("zwj _playVideo2$element");
          if (element == focusNum) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyHome(url: mUrl!)));
            return;
          }else{
            showCupertinoAlertDialog("内容未解锁", "花费一枚金币解锁此内容?", "解锁");
            focusUrl = mUrl;
          }
        });
      } else {
        print("zwj _playVideo3");
        showCupertinoAlertDialog("内容未解锁", "花费一枚金币解锁此内容?", "解锁");
        focusUrl = mUrl;
        focusNum = mNum;
      }
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHome()));
    });
  }

  void showCupertinoAlertDialog(String title, String content, String confirm) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Align(
                  child: Text(content),
                  alignment: Alignment(0, 0),
                ),
              ],
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("取消"),
                onPressed: () {
                  Navigator.pop(context);
                  print("取消");
                },
              ),
              CupertinoDialogAction(
                child: Text(confirm),
                onPressed: () {
                  if (confirm == "解锁") {
                    print("zwj解锁");
                    Navigator.pop(context);
                    unLockVideo();
                  } else if(confirm == "登录") {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  } else if (confirm == "充值") {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountScreen()));
                  }
                },
              ),
            ],
          );
        });
  }

  unLockVideo() async {
    if(Global.mCoin != null && (Global.mCoin!) > 0) {
      Global.mCoin = Global.mCoin! - 1;
      BuyResponseEntity rrr =
      await MyplayerServices.buyContent(
          "/QQQ/servlet/UpdateServlet", Global.userName,Global.userPwd,Global.mCoin,Global.mId);
      if (Global.mUnlockMovie == null) {
        List<String> list = <String>[];
        list.add(focusNum);
        Global.mUnlockMovie = list;
        SharePerfManager.saveSharePrefList("Unlocked_M", list);
      } else {
        Global.mUnlockMovie.add(focusNum);
        print("zwjcachesize ${Global.mUnlockMovie.length}");
        SharePerfManager.saveSharePrefList("Unlocked_M", Global.mUnlockMovie);
      }
      setState(() {
        if(rrr!.resultData!) {
          Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new MyHome(url: focusUrl!))
          );
        }
        newData1 = rrr as BuyResponseEntity?;
      });
      //showCupertinoAlertDialog("余额不足","请前往Account页面充值?","充值");
      // AccountInfoEntityEntity rrr =
      //     await MyplayerServices.getAccount(
      //     "/QQQ/servlet/Searchall", name,pwd);
    } else {
      showCupertinoAlertDialog("余额不足","请前往Account页面充值?","充值");
    }

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
    print("刷新");
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
      ),
    body: Center(
      child: GridView.builder(
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

        itemCount: newData?.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 0.75
        ),// 数据长度
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
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(15),
          color: Color(0xFF61BDBD),),
        margin: EdgeInsets.all(6.0),
      padding: EdgeInsets.only(bottom: 6.0),

      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200.0,
            decoration: BoxDecoration(

                borderRadius: BorderRadius.only(topLeft:Radius.circular(15),topRight:Radius.circular(15),),
                color: Color(0xFF61BDBD),
                image: DecorationImage(image: NetworkImage(getImageUrl(newData)!),
                  alignment: Alignment.center,
                  fit: BoxFit.fill,
                )
            ),

            child: Center(
              child: IconButton(onPressed:() {_playVideo(newData?.num,newData?.video);}, icon:Icon(Icons.play_arrow),alignment: Alignment.center,
                iconSize: 60,
                color: Colors.white,),
            ),
          ),
        Text(getDataNum(newData)!,
                 style: TextStyle(fontSize: 20),)
        ]
      )
    );
  }
}
