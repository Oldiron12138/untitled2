import 'package:untitled2/api/MyplayerServices.dart';
import 'package:untitled2/data/result_data_entity.dart';

import '../api/MyplayerServices.dart';
import '../data/result_data_entity.dart';

class MoviesViewModel {
  // 手机号码登录
  static phoneLogin(String phone, String verifyCode) async {
    Future<List<ResultDataEntity>> response = await MyplayerServices.get(
        "/test/test3.json", {});
    if (response != null) {
    //  print("zwj ${response.length}");
      return response;

      // PhoneLoginEntity phoneLoginEntity = PhoneLoginEntity.fromJson(
      //     json.decode(response.data));
      // return new ResultDataEntity(phoneLoginEntity, true);
    } else {
      //
      return null;
    }
  }
}