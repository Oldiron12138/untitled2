import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'dart:collection';

import 'package:untitled2/data/result_data_entity.dart';
import 'package:untitled2/data/info_data_entity_entity.dart';
import 'package:untitled2/utils/Code.dart';
import 'package:untitled2/utils/Config.dart';
import 'package:untitled2/data/account_info_entity_entity.dart';

///http请求管理类，可单独抽取出来
class MyplayerServices {
  //"http://120.26.243.3:8080/test/test3.json";
  static String _baseUrl = "http://120.26.243.3:8080";
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";
  static Map optionParams = {
    "timeoutMs": 15000,
    "token": null,
    "authorizationCode": null,
  };

  static setBaseUrl(String baseUrl){
    _baseUrl = baseUrl;
  }

  static get(url,param) async{
    return await request(_baseUrl+url, param, new Options(method:"GET"));
  }

  static getAccount(url,name,pwd) async{
    print("zwjname $name");
    print("zwjpwd $pwd");
    return await userInfo(_baseUrl+url, name,pwd, new Options(method:"GET"));
  }

  static getInfo(url,param) async{
    return await requestInfo(_baseUrl+url, param, new Options(method:"GET"));
  }

  static post(url,param) async{
    return await request(_baseUrl+url, param, new Options(method: 'POST'));
  }

  static delete(url,param) async{
    return await request(_baseUrl+url, param, new Options(method: 'DELETE'));
  }

  // static put(url,param) async{
  //   return await request(_baseUrl+url, param, new Options(method: "PUT", contentType: ContentType.text));
  // }

  static request(url, params, Options option, {noTip = false}) async {
    print('zwj success 111 ${url.toString()}');

    option.responseType = ResponseType.plain;

    ///超时
    Dio dio = new Dio();
    // 添加拦截器
    Response response;

    try {
      response = await dio.request(url, data: params, options: option);
      print("zwj666 ${response.toString()}");
    } on DioError catch (e) {
      // 请求错误处理
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      }
      if (Config.DEBUG) {
        print('请求异常: ' + e.toString());
        print('请求异常 url: ' + url);
      }
      return "error";
    }

    try {
      if (option.contentType != null) {
        print("zwj111");
        //return new ResultDataEntity();
      } else {
        var responseJson = response.data;
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        List responseJson = json.decode(response.data);
        List<ResultDataEntity> cardbeanList = responseJson.map((
            m) => new ResultDataEntity.fromJson(m)).toList();
        print("zwj1010");
        return cardbeanList;
      }
    } catch (e) {
      print(e.toString() + url);
    }
  }

  ///发起网络请求
  ///[ url] 请求url
  ///[ params] 请求参数
  ///[ header] 外加头
  ///[ option] 配置
  static requestInfo(url, params, Options option, {noTip = false}) async {
    print('zwj success 111 ${url.toString()}');

    option.responseType = ResponseType.plain;

    ///超时
    Dio dio = new Dio();
    // 添加拦截器
    Response response;

    try {
      response = await dio.request(url, data: params, options: option);
      print("zwj666 ${response.toString()}");
    } on DioError catch (e) {
      // 请求错误处理
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      }
      if (Config.DEBUG) {
        print('请求异常: ' + e.toString());
        print('请求异常 url: ' + url);
      }
      return "error";
    }

    try {
      if (option.contentType != null) {
        print("zwj111");
        //return new ResultDataEntity();
      } else {
        var responseJson = response.data;
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        List responseJson = json.decode(response.data);
        List<InfoDataEntityEntity> cardbeanList = responseJson.map((
            m) => new InfoDataEntityEntity.fromJson(m)).toList();
        print("zwj1010");
        return cardbeanList;
      }
    } catch (e) {
      print(e.toString() + url);
    }
  }
 // userInfo
  static userInfo(url, name, pwd, Options option, {noTip = false}) async {
    option.responseType = ResponseType.plain;

    ///超时
    Dio dio = new Dio();
    // 添加拦截器
    Response response;
    Map<String,dynamic> map = Map();
    map["name"]= name;
    map["pwd"] = pwd;

    try {
      response = await dio.get(url,queryParameters: map);
      print("zwjresName ${map["name"]}");
      print("zwjresPwd ${map["pwd"]}");
      print("zwj666 ${response.toString()}");
    } on DioError catch (e) {
      // 请求错误处理
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      }
      if (Config.DEBUG) {
        print('请求异常: ' + e.toString());
        print('请求异常 url: ' + url);
      }
      return "error";
    }

    try {
      if (option.contentType != null) {
        print("zwj111");
        //return new ResultDataEntity();
      } else {
        var responseJson = response.data;
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        AccountInfoEntityEntity cardbeanList = AccountInfoEntityEntity.fromJson(json.decode(response.data));
        print("zwj1010");
        return cardbeanList;
      }
    } catch (e) {
      print(e.toString() + url);
    }
  }
}