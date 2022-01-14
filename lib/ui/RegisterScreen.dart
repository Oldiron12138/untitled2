import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';
import 'package:untitled2/BottomNavigationWidget.dart';
import 'package:untitled2/api/MyplayerServices.dart';
import 'package:untitled2/data/account_info_entity_entity.dart';
import 'package:untitled2/data/buy_response_entity.dart';
import 'package:untitled2/ui/AccountScreen.dart';
import 'package:untitled2/utils/Global.dart';
import 'package:untitled2/utils/SharePerfManager.dart';

AccountInfoEntityEntity? newData = null;
class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  FocusNode _userNickFocusNode = new FocusNode();
  FocusNode _userNameFocusNode = new FocusNode();
  FocusNode _passwordFocusNode = new FocusNode();
  FocusNode _passwordConfirmFocusNode = new FocusNode();

  //文本输入框控制器
  TextEditingController _userNickController = new TextEditingController();
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _passwordConfirmController = new TextEditingController();

  //抖动动画控制器
  ShakeAnimationController _userNickAnimation = new ShakeAnimationController();
  ShakeAnimationController _userNameAnimation = new ShakeAnimationController();
  ShakeAnimationController _userPasswordAnimation = new ShakeAnimationController();
  ShakeAnimationController _userPasswordConfirmAnimation = new ShakeAnimationController();

  //Stream 更新操作控制器
  StreamController<String> _userNickStream = new StreamController();
  StreamController<String> _userNameStream = new StreamController();
  StreamController<String> _userPasswordStream = new StreamController();
  StreamController<String> _userPasswordConfirmStream = new StreamController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar订制导航条
        body: mainBody());
  }

  Widget mainBody() {
    return Container(
      margin: EdgeInsets.only(left: 30,right: 30,top:30),
      //线性布局
      child: Column(
        children: [
          buildUserNickWidget(),
          SizedBox(
            height: 20,
          ),
          //用户名输入框
          buildUserNameWidget(),
          SizedBox(
            height: 20,
          ),
          //用户密码输入框
          buildUserPasswordWidget(),
          SizedBox(
            height: 20,
          ),
          buildUserPasswordConfirmWidget(),
          SizedBox(
            height: 20,
          ),
          //登录按钮
          Container(
            margin: EdgeInsets.only(top: 10),
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              child: Text("注册"),
              onPressed: () {
                checkRegCheckFunction();
              },
            ),
          )
        ],
      ),
    );
  }

  StreamBuilder<String> buildUserNickWidget() {
    return StreamBuilder<String>(
      stream: _userNickStream.stream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return ShakeAnimationWidget(
          //微左右的抖动
          shakeAnimationType: ShakeAnimationType.LeftRightShake,
          //设置不开启抖动
          isForward: false,
          //抖动控制器
          shakeAnimationController: _userNickAnimation,
          child: TextField(
            //焦点控制
            focusNode: _userNickFocusNode,
            //文本控制器
            controller: _userNickController,
            //键盘回车键点击回调
            onSubmitted: (String value) {
              //点击校验，如果有内容输入 输入焦点跳入下一个输入框
              if (checkUserNick()) {
                _userNickFocusNode.unfocus();
                FocusScope.of(context).requestFocus(_userNameFocusNode);
              } else {
                FocusScope.of(context).requestFocus(_userNickFocusNode);
              }
            },
            //边框样式设置
            decoration: InputDecoration(
              //红色的错误提示文本
              errorText: snapshot.data,
              labelText: "昵称",
              //设置上下左右 都有边框
              //设置四个角的弧度
              border: OutlineInputBorder(
                //设置边框四个角的弧度
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        );
      },
    );
  }


  StreamBuilder<String> buildUserNameWidget() {
    return StreamBuilder<String>(
      stream: _userNameStream.stream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return ShakeAnimationWidget(
          //微左右的抖动
          shakeAnimationType: ShakeAnimationType.LeftRightShake,
          //设置不开启抖动
          isForward: false,
          //抖动控制器
          shakeAnimationController: _userNameAnimation,
          child: TextField(
            //焦点控制
            focusNode: _userNameFocusNode,
            //文本控制器
            controller: _userNameController,
            //键盘回车键点击回调
            onSubmitted: (String value) {
              //点击校验，如果有内容输入 输入焦点跳入下一个输入框
              if (checkUserName()) {
                _userNameFocusNode.unfocus();
                FocusScope.of(context).requestFocus(_passwordFocusNode);
              } else {
                FocusScope.of(context).requestFocus(_userNameFocusNode);
              }
            },
            //边框样式设置
            decoration: InputDecoration(
              //红色的错误提示文本
              errorText: snapshot.data,
              labelText: "手机号",
              //设置上下左右 都有边框
              //设置四个角的弧度
              border: OutlineInputBorder(
                //设置边框四个角的弧度
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        );
      },
    );
  }

  StreamBuilder<String> buildUserPasswordWidget() {
    return StreamBuilder<String>(
      stream: _userPasswordStream.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return ShakeAnimationWidget(
          //微左右的抖动
          shakeAnimationType: ShakeAnimationType.LeftRightShake,
          //设置不开启抖动
          isForward: false,
          //抖动控制器
          shakeAnimationController: _userPasswordAnimation,
          child: TextField(
            focusNode: _passwordFocusNode,
            controller: _passwordController,
            onSubmitted: (String value) {
              if (checkUserPassword()) {
                checkLoginFunction();
              } else {
                FocusScope.of(context).requestFocus(_passwordFocusNode);
              }
            },
            //隐藏输入的文本
            obscureText: true,
            //最大可输入1行
            maxLines: 1,
            //边框样式设置
            decoration: InputDecoration(
              labelText: "密码",
              errorText: snapshot.data,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        );
      },
    );
  }

  StreamBuilder<String> buildUserPasswordConfirmWidget() {
    return StreamBuilder<String>(
      stream: _userPasswordConfirmStream.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return ShakeAnimationWidget(
          //微左右的抖动
          shakeAnimationType: ShakeAnimationType.LeftRightShake,
          //设置不开启抖动
          isForward: false,
          //抖动控制器
          shakeAnimationController: _userPasswordConfirmAnimation,
          child: TextField(
            focusNode: _passwordConfirmFocusNode,
            controller: _passwordConfirmController,
            onSubmitted: (String value) {
              if (checkUserPasswordConfirm()) {
                checkLoginFunction();
              } else {
                FocusScope.of(context).requestFocus(_passwordConfirmFocusNode);
              }
            },
            //隐藏输入的文本
            obscureText: true,
            //最大可输入1行
            maxLines: 1,
            //边框样式设置
            decoration: InputDecoration(
              labelText: "确认密码",
              errorText: snapshot.data,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        );
      },
    );
  }
  bool checkUserNick() {
    //获取输入框中的输入文本
    String userNick = _userNickController.text;
    if (userNick.length == 0) {
      print("zwj shakeshake");
      //Stream 事件流更新提示文案
      _userNickStream.add("请输入昵称");
      //抖动动画开启
      _userNickAnimation.start();
      return false;
    } else {
      //清除错误提示
      _userNickStream.add("");
      return true;
    }
  }

  bool checkUserName() {
    //获取输入框中的输入文本
    String userName = _userNameController.text;
    if (userName.length == 0) {
      print("zwj shakeshake");
      //Stream 事件流更新提示文案
      _userNameStream.add("请输入手机号");
      //抖动动画开启
      _userNameAnimation.start();
      return false;
    } else {
      //清除错误提示
      _userNameStream.add("");
      return true;
    }
  }

  bool checkUserPassword() {
    String userPassrowe = _passwordController.text;
    if (userPassrowe.length < 2) {
      _userPasswordStream.add("请输入密码");
      _userPasswordAnimation.start();
      return false;
    } else {
      _userPasswordStream.add("");
      return true;
    }
  }

  bool checkUserPasswordConfirm() {
    String userPassroweConfirm = _passwordConfirmController.text;
    if (userPassroweConfirm.length < 2) {
      _userPasswordConfirmStream.add("请再次输入密码");
      _userPasswordConfirmAnimation.start();
      return false;
    } else if(_passwordController.text != _passwordConfirmController.text){
      _userPasswordConfirmStream.add("密码不一致");
      _userPasswordConfirmAnimation.start();
      return false;
    }else {
      _userPasswordConfirmStream.add("");
      return true;
    }
  }

  Widget textFiledItem(String content) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        style: TextStyle(fontSize: 20, color: Colors.black87),
        decoration: InputDecoration(
          labelText: content,
          //icon: Icon(Icons.people),
          hintText: content,
          //prefixIcon: Icon(Icons.people_alt_rounded))
        ),
      ),
    );
  }

  void startLogin() async {
    print("zwj 开始请求数据");
    AccountInfoEntityEntity rrr =
    await MyplayerServices.getAccount(
        "/QQQ/servlet/Searchall", _userNameController.text, _passwordController.text);

    // setState(() {
    //   newData = rrr as AccountInfoEntityEntity?;
    // });
    if (rrr.num != null) {
      SharePerfManager.saveSharePref("Account_Num",rrr.num);
      Global.mCoin = rrr.coin;
      Global.mId = rrr.id;
      print("zwj password ${_passwordController.text}");
      SharePerfManager.saveSharePref("Account_Pwd",_passwordController.text.toString());
      SharePerfManager.saveSharePref<bool>("Already_Login",true);
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (context) => new BottomNavigationWidget()
          ), (route) => route == null);
    }

    print("zwj 登录成功 ${rrr.num}");
  }

  void checkLoginFunction() {
    if(checkUserName() && checkUserPassword()) {
      startLogin();
    }
  }

  void startReg() async {
    print("zwj 开始请求数据");
    BuyResponseEntity rrr = await MyplayerServices.register(
        "/QQQ/servlet/WebSocketTest",
        _userNickController.text,
        _passwordController.text,
        _userNameController.text);

    // setState(() {
    //   newData = rrr as AccountInfoEntityEntity?;
    // });
    if (rrr.resultData!) {
      //setState(() {
        print("BuyResponseEntity 登录成功 ${rrr.resultData!}");
        Navigator.pop(context);
      //});
    }
  }

  void checkRegCheckFunction() {
    if(checkUserNick() && checkUserName() && checkUserPassword() && checkUserPasswordConfirm()) {
      startReg();
    }
  }
}