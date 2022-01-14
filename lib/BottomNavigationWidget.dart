import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled2/Capture.dart';
import 'package:untitled2/CircleScreen.dart';
import 'package:untitled2/Infos.dart';
import 'package:untitled2/MoviesScreen.dart';
import 'package:untitled2/ui/AccountScreen.dart';
import 'package:untitled2/ui/LoginScreen.dart';
import 'package:untitled2/ui/RegisterScreen.dart';
import 'package:untitled2/ui/SplashScreen.dart';
import 'package:untitled2/utils/Global.dart';
import 'package:untitled2/utils/SharePerfManager.dart';

class BottomNavigationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new BottomNavigationWidgetState();
  }
}

class BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _currentIndex = 0;
  List<Widget> list = [];
  var aleadyLogin;

  _getLoginStatus(){
    var s=SharePerfManager.getSharePref("Account_Num");
    s.then((value){
      aleadyLogin = value;
      setState(() {
        if (aleadyLogin != null){
          print("zwj Bottom navi $aleadyLogin");
          Global.userName = value;
          Global.isLoged = true;
          list[3] = AccountScreen();
          _getLoginPwd();
        }
      });

    });
  }

  _getLoginPwd(){
    var s=SharePerfManager.getSharePref("Account_Pwd");
    s.then((value){
      Global.userPwd = value;
      print("zwj Bottom navi ${Global.userPwd}");
    });
  }

  _getMoviesCache(){
    var s=SharePerfManager.getSharePrefList("Unlocked_M");
    s.then((value){
      Global.mUnlockMovie = value;
      print("zwjmovieccccc ${value.length}");
    });
  }

  _getCoinCache(){
    var s=SharePerfManager.getSharePrefCoin("Account_Coin");
    s.then((value){
      Global.mCoin = value;
    });
  }

  @override
  void initState() {
    print("zwjBottom initstate ${Global.screenWidth}");
    _getLoginStatus();
    _getMoviesCache();
    _getCoinCache();
    //print("zwj Bottom navi $aleadyLogin");
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    list
      ..add(MoviesScreen())
      ..add(Infos())
      ..add(Infos())
      ..add((aleadyLogin != null)? AccountScreen() : LoginScreen());
          //AccountScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*
    返回一个脚手架，里面包含两个属性，一个是底部导航栏，另一个就是主体内容
     */
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        //底部导航栏的创建需要对应的功能标签作为子项，这里我就写了3个，每个子项包含一个图标和一个title。
        items: [
          const BottomNavigationBarItem(
              icon: Icon(
                  Icons.local_movies
              ),
              title: Text(
                'Movies',
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.view_list,
              ),
              title: new Text(
                'Infos',
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.perm_media,
              ),
              title: new Text(
                'Square',
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              title: new Text(
                'Account',
              )),

        ],
        currentIndex: _currentIndex,
        onTap: (int i) {
          setState(() {
            _currentIndex = i;
            print("zwj $i");
          });
        },
      ),
      body: list[_currentIndex],
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '底部导航演示',
      home: BottomNavigationWidget(),
    );
  }
}