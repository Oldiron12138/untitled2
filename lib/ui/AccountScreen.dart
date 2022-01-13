import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled2/api/MyplayerServices.dart';
import 'package:untitled2/data/account_info_entity_entity.dart';
import 'package:untitled2/utils/Global.dart';

AccountInfoEntityEntity? newData = null;
class AccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AccountScreenState();
}

class AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar订制导航条
      body: mainBody(),
    floatingActionButton: floatButton(),);
  }


  void getData() async {
    var name = Global.userName;
    var pwd = Global.userPwd;
    print("zzwwjj $name");
    print("zzwwjj $pwd");
    print("zwj 开始请求数据");
    AccountInfoEntityEntity rrr =
    await MyplayerServices.getAccount(
        "/QQQ/servlet/Searchall", name,pwd);


    setState(() {
      newData = rrr as AccountInfoEntityEntity?;
    });

    print("zwj 请求完成AAAAAA");

  }

  Widget mainBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.all(10.0),
          child: Text(newData!.name!,textAlign: TextAlign.center, style: TextStyle(
            fontSize: 30
          ),),
        ),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFE4B5),
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.only(left: 8.0,right: 8.0,top:4.0,bottom: 4.0),
          margin: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.only(left: 8.0,right: 8.0,top:4.0,bottom: 4.0),
            margin: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("账号: ",style: TextStyle(fontSize: 30),textAlign: TextAlign.center,),
                Text(newData!.num.toString(),style: TextStyle(fontSize: 20),textAlign: TextAlign.center)
              ],
            ),
          ),

        ),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFE4B5),
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.only(left: 8.0,right: 8.0,top:4.0,bottom: 4.0),
          margin: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.only(left: 8.0,right: 8.0,top:4.0,bottom: 4.0),
            margin: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("金币: ",style: TextStyle(fontSize: 30),textAlign: TextAlign.center,),
                Text(newData!.coin.toString(),style: TextStyle(fontSize: 20),textAlign: TextAlign.center)
              ],
            ),
          ),

        )
      ],
    );
  }

  Container floatButton() {
    return Container(
    //  padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(15),
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        color: Colors.white,
      ),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(onPressed: () { startCharge(); }, child: Text("充值",textAlign: TextAlign.center, style: TextStyle(fontSize: 15),),style: ButtonStyle(
        //定义文本的样式 这里设置的颜色是不起作用的
        textStyle: MaterialStateProperty.all(
        TextStyle(fontSize: 18, color: Colors.red)),
      //设置按钮上字体与图标的颜色
      //foregroundColor: MaterialStateProperty.all(Colors.deepPurple),
      //更优美的方式来设置
      //背景颜色
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        //设置按下时的背景颜色
        if (states.contains(MaterialState.pressed)) {
          return Colors.blue[200];
        }
        //默认不使用背景颜色
        return Colors.blue[200];
      }),
    ),),
        ],
      ),
    );
  }

  void startCharge() {}
}