import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/BottomNavigationWidget.dart';
import 'package:untitled2/utils/Global.dart';
import 'package:untitled2/utils/SharePerfManager.dart';
//void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '底部导航演示',
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashScreenState();

}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _getLoginPwd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar订制导航条
      body: mainBody(),);
  }

  Widget mainBody() {
    return Center(
      child: LinearProgressIndicator(
        backgroundColor: Colors.blue,
// value: 0.2,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
      ),
    );
  }

  _getLoginPwd(){
    var s=SharePerfManager.getSharePref("Account_Pwd");
    s.then((value){
      Global.userPwd = value;
      print("zwj Bottom navi ${Global.userPwd}");
    }).whenComplete(_getMoviesCache()).onError(_getMoviesCache());
  }

  _getMoviesCache(){
    print("zwj _getMoviesCache");
    var s=SharePerfManager.getSharePrefList("Unlocked_M");
    s.then((value){
      Global.mUnlockMovie = value;
      print("zwjmovieccccc ${value.length}");
    }).whenComplete(() => _getCoinCache).onError(_getCoinCache());
  }

  _getCoinCache(){
    var s=SharePerfManager.getSharePrefCoin("Account_Coin");
    s.then((value){
      Global.mCoin = value;
    }).whenComplete(() => Navigator.push(context,
        MaterialPageRoute(builder: (context) => BottomNavigationWidget())).onError((error, stackTrace) => Navigator.push(context,
        MaterialPageRoute(builder: (context) => BottomNavigationWidget()))));
  }
}