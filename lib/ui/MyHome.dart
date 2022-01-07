import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class MyHome extends StatefulWidget {
  final String url;

  const MyHome({required this.url}) : super();

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  var dura;
  var _url;
  bool visbale = true;
  late VideoPlayerController _controller;      //先定义一个VideoPlayer的控制器变量
  @override
  void initState() {    //重写组件初始化方法
    // TODO: implement initState
    super.initState();
    _controller=VideoPlayerController.network(//定义连接器内容，这里初学者可能有点难懂下面详细讲
        widget.url
    )..initialize().then((a){
      setState(() {

      });
    });
    _controller.addListener(() {
      setState(() {
        //进度条的播放进度，用当前播放时间除视频总长度得到
        dura=_controller.value.position.inSeconds/
            _controller.value.duration.inSeconds;
      });
    });
  }
  void updateMessage(String msg) {
    setState((){
      _url = msg;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
          child: Stack(

            alignment: Alignment.bottomRight,
            children: <Widget>[
           GestureDetector(
             onTap: () {
               setState(() {
                 if (visbale) {
                   visbale = false;
                 } else {
                   visbale = true;
                 }
               });

             },
             child: _controller.value.isInitialized ? AspectRatio(   //     这里和上面是联动的，下面详细讲
               aspectRatio: _controller.value.aspectRatio,

               child: VideoPlayer(_controller),

             ):Container(
               width: 100,
               height: 100,
               color: Colors.white,
             ),
           ),

              Visibility(
                child: LinearProgressIndicator(
                backgroundColor: Colors.greenAccent,
                value:dura,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
              )
                ,visible: visbale,),

              //打印的视频内容，供调试参考

             GestureDetector(
               onTap: () {
                setState(() {
                  if (visbale) {
                    visbale = false;
                  } else {
                    visbale = true;
                  }
                });
              },

              child: Visibility(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(onPressed: () {  },icon:const Icon(Icons.skip_previous)),
                    IconButton(onPressed: () {
                      _controller.value.isPlaying   //设置播放状态
                          ? _controller.pause()
                          : _controller.play(); },icon: Icon(chooseIcon(),color: Colors.red,)),
                    IconButton(onPressed: () {  },icon:const Icon(Icons.skip_next)),
                  ],
                ),
                  visible: visbale,
              ),
             ),
            ]
          )
      ),
    );
  }

  tapPlay() {
    setState(() {
      _controller.value.isPlaying   //设置播放状态
          ? _controller.pause()
          : _controller.play();
    });
  }

  IconData chooseIcon() {
    return _controller.value.isPlaying ? Icons.pause : Icons.play_arrow;
  }
}