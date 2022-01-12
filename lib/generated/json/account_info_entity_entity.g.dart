import 'package:untitled2/generated/json/base/json_convert_content.dart';
import 'package:untitled2/data/account_info_entity_entity.dart';

AccountInfoEntityEntity $AccountInfoEntityEntityFromJson(Map<String, dynamic> json) {
	final AccountInfoEntityEntity accountInfoEntityEntity = AccountInfoEntityEntity();
	final String? num = jsonConvert.convert<String>(json['num']);
	if (num != null) {
		accountInfoEntityEntity.num = num;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		accountInfoEntityEntity.name = name;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		accountInfoEntityEntity.id = id;
	}
	final int? coin = jsonConvert.convert<int>(json['coin']);
	if (coin != null) {
		accountInfoEntityEntity.coin = coin;
	}
	final String? token = jsonConvert.convert<String>(json['token']);
	if (token != null) {
		accountInfoEntityEntity.token = token;
	}
	return accountInfoEntityEntity;
}

Map<String, dynamic> $AccountInfoEntityEntityToJson(AccountInfoEntityEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['num'] = entity.num;
	data['name'] = entity.name;
	data['id'] = entity.id;
	data['coin'] = entity.coin;
	data['token'] = entity.token;
	return data;
}