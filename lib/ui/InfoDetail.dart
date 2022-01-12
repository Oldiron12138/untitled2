import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:untitled2/data/info_data_entity_entity.dart';

class InfoDetail extends StatefulWidget {
  final InfoDataEntityEntity dataDetail;

  const InfoDetail({required this.dataDetail}) : super();
  @override
  State<StatefulWidget> createState() => InfoDetailState();
}

class InfoDetailState extends State<InfoDetail> {
  late InfoDataEntityEntity dataDetail;
  @override
  void initState() {
    super.initState();
    dataDetail = widget.dataDetail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar订制导航条
      body: mainBody(),);
  }

  Widget mainBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        renderBody(),
        titleBody(),
        textBody("城市", dataDetail.city!),
        textBody("街道", dataDetail.street!),
        textBody("消费", dataDetail.price!),
        textBody("微信", dataDetail.phone!),
        textBody("描述", dataDetail.desc!),

      ],
    );
  }

  Widget renderBody() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: NetworkImage(dataDetail.url!),
            fit: BoxFit.cover,
            width: 200,
            height: 200,
          ),
        ],
      ))
    ]);
  }

  Widget textBody(String title, String content) {
    return Container(
      padding: EdgeInsets.only(left: 30,top: 10.0,right: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title+":   ",style: TextStyle(fontSize: 20),maxLines: 10,),
          Expanded(
            child: Text(content,style: TextStyle(fontSize: 20),maxLines: 10,),
          ),
        ],

      ),

    );
  }

  Widget titleBody() {
    return Container(
      padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 8.0,bottom: 8.0),
      margin: EdgeInsets.all(8.0),
      color: Color(0xADD8E6FF),
      child: Text(dataDetail.title!, textAlign: TextAlign.start, style: TextStyle(
          color: Colors.black, fontSize: 30,
      ),
      ),
    );
  }

}