import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Capture extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CapturesState();
}

class CapturesState extends State<Capture> {
  @override
  void initState() {
    super.initState();
  }

  File? _image = null;

  Future choosePic(ImageSource source) async {
    //参数类型为ImageSource
    var image = await ImagePicker.pickImage(source: source);
    setState(() {
      //将用户照片存储到_image
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar订制导航条
      body: mainBody(),
      floatingActionButton: renderFloatingActionBar(),
    );
  }

  //渲染头部的Appbar
  Widget renderAppBar() {
    return AppBar(
      title: Text("拍照"),
      centerTitle: true,
    );
  }

  Widget mainBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        renderBody(),
        textBody(),
      ],
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

  Container textFieldContainer() {
    return Container(
      height: 350,
        width: 300,
        child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      textFiledItem("请添加标题"),
                      textFiledItem("请输入城市"),
                      textFiledItem("请输入详细地址"),
                      textFiledItem("请输入价格"),
                      textFiledItem("请输入联系方式"),
                      textFiledItem("请添加描述"),
                    ]
                )
            ),

        margin: const EdgeInsets.only(left: 20.0)
    );
  }

  Widget textBody() {
     return Row(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         //textContainer("1","2","3","4"),
         textFieldContainer(),
       ],
     );
  }

  Widget textFiledItem(String content) {
     return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        style: TextStyle(fontSize: 12, color: Colors.black87),
        decoration: InputDecoration(
          labelText: content,
          //icon: Icon(Icons.people),
          hintText: content,
          //prefixIcon: Icon(Icons.people_alt_rounded))
        ),
      ),
    );
  }

  //渲染页面主体区域
  Widget renderBody() {
    if (_image == null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("请选择照片！",textAlign: TextAlign.center,textWidthBasis: TextWidthBasis.parent)],
            ),
            width: 150,
            height: 150,
            color: Color(0xFF42A5F5),
          ),

        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.file(
            _image!,
            fit: BoxFit.cover,
            width: 200,
            height: 200,
          ),
        ],
      );
    }
  }

  //渲染底部浮动按钮
  Widget renderFloatingActionBar() {
    return ButtonBar(
      //设置对齐方式
      alignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        //第一个浮动按钮
        FloatingActionButton(
          onPressed: () {
            choosePic(ImageSource.camera);
          },
          tooltip: 'photo_camera',
          child: Icon(Icons.photo_camera), //相机拍照
        ),
        //第二个浮动按钮
        FloatingActionButton(
          onPressed: () {
            choosePic(ImageSource.camera);
          },
          tooltip: '发布',
          child: Icon(Icons.add), //相机拍照
        ),
        FloatingActionButton(
          onPressed: () {
            choosePic(ImageSource.gallery);
          },
          tooltip: 'photo_libarary',
          child: Icon(Icons.photo_library), //选择相册照片
        )
      ],
    );
  }
}
