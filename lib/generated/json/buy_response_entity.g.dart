import 'package:untitled2/generated/json/base/json_convert_content.dart';
import 'package:untitled2/data/buy_response_entity.dart';

BuyResponseEntity $BuyResponseEntityFromJson(Map<String, dynamic> json) {
	final BuyResponseEntity buyResponseEntity = BuyResponseEntity();
	final bool? resultData = jsonConvert.convert<bool>(json['resultData']);
	if (resultData != null) {
		buyResponseEntity.resultData = resultData;
	}
	return buyResponseEntity;
}

Map<String, dynamic> $BuyResponseEntityToJson(BuyResponseEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['resultData'] = entity.resultData;
	return data;
}